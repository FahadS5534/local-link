import 'dart:convert';
import '../../domain/entities/station.dart';
import '../../domain/entities/stop_schedule.dart';
import '../../domain/entities/train_trip.dart';
import '../../domain/failures/timetable_failure.dart';

/// Validates and parses raw timetable JSON datasets into domain entities.
class TimetableParser {
  const TimetableParser();

  /// Parses and validates a JSON string containing an array of station definitions.
  List<Station> parseStationsJson(String rawJson) {
    final dynamic decoded;
    try {
      decoded = jsonDecode(rawJson);
    } catch (e) {
      throw CorruptedDatasetFailure('Invalid JSON format: $e');
    }

    if (decoded is! List) {
      throw const CorruptedDatasetFailure('Expected a JSON array of stations');
    }

    final stations = <Station>[];
    final seenIds = <String>{};
    final seenCodes = <String>{};

    for (final dynamic item in decoded) {
      if (item is! Map<String, dynamic>) {
        throw const CorruptedDatasetFailure(
          'Each station must be a JSON object',
        );
      }

      final id = item['id'] as String?;
      final code = item['code'] as String?;
      final nameEn = item['nameEn'] as String?;
      final nameHi = item['nameHi'] as String?;
      final nameMr = item['nameMr'] as String?;
      final lat = (item['latitude'] as num?)?.toDouble();
      final lng = (item['longitude'] as num?)?.toDouble();
      final linesRaw = item['lines'] as List<dynamic>?;
      final isInterchange = (item['isInterchange'] as bool?) ?? false;

      if (id == null || id.isEmpty || !id.startsWith('ST_')) {
        throw CorruptedDatasetFailure('Invalid or missing station id: $id');
      }
      if (code == null || code.isEmpty) {
        throw CorruptedDatasetFailure('Missing station code for id: $id');
      }
      if (nameEn == null || nameEn.isEmpty) {
        throw CorruptedDatasetFailure('Missing English name for station: $id');
      }
      if (nameHi == null || nameHi.isEmpty) {
        throw CorruptedDatasetFailure('Missing Hindi name for station: $id');
      }
      if (nameMr == null || nameMr.isEmpty) {
        throw CorruptedDatasetFailure('Missing Marathi name for station: $id');
      }

      // Mumbai Metropolitan Region coordinate boundary check
      if (lat == null || lat < 18.5 || lat > 20.5) {
        throw CorruptedDatasetFailure(
          'Latitude out of Mumbai bounds for $id: $lat',
        );
      }
      if (lng == null || lng < 72.5 || lng > 73.5) {
        throw CorruptedDatasetFailure(
          'Longitude out of Mumbai bounds for $id: $lng',
        );
      }

      if (linesRaw == null || linesRaw.isEmpty) {
        throw CorruptedDatasetFailure(
          'Station must belong to at least one line: $id',
        );
      }

      final lines = <RailwayLineId>[];
      for (final dynamic l in linesRaw) {
        final lineEnum = _parseLineId(l?.toString());
        if (lineEnum != null && !lines.contains(lineEnum)) {
          lines.add(lineEnum);
        }
      }

      if (seenIds.contains(id)) {
        throw CorruptedDatasetFailure('Duplicate station id: $id');
      }
      if (seenCodes.contains(code)) {
        throw CorruptedDatasetFailure('Duplicate station code: $code');
      }

      seenIds.add(id);
      seenCodes.add(code);

      stations.add(
        Station(
          id: id,
          code: code,
          nameEn: nameEn,
          nameHi: nameHi,
          nameMr: nameMr,
          latitude: lat,
          longitude: lng,
          lines: lines,
          isInterchange: isInterchange,
        ),
      );
    }

    return stations;
  }

  /// Parses and validates a JSON string containing an array of train trips with stops.
  List<({TrainTrip trip, List<StopSchedule> stops})> parseTripsJson(
    String rawJson,
    Map<String, Station> knownStations,
  ) {
    final dynamic decoded;
    try {
      decoded = jsonDecode(rawJson);
    } catch (e) {
      throw CorruptedDatasetFailure('Invalid trips JSON format: $e');
    }

    if (decoded is! List) {
      throw const CorruptedDatasetFailure('Expected a JSON array of trips');
    }

    final results = <({TrainTrip trip, List<StopSchedule> stops})>[];
    final seenTripIds = <String>{};

    for (final dynamic item in decoded) {
      if (item is! Map<String, dynamic>) {
        throw const CorruptedDatasetFailure('Each trip must be a JSON object');
      }

      final id = item['id'] as String?;
      final trainNumber = item['trainNumber'] as String?;
      final lineIdStr = item['lineId'] as String?;
      final dirStr = item['direction'] as String?;
      final servStr = item['serviceType'] as String?;
      final srcId = item['sourceStationId'] as String?;
      final destId = item['destinationStationId'] as String?;
      final daysMask = (item['operatingDaysMask'] as num?)?.toInt() ?? 127;
      final stopsRaw = item['stops'] as List<dynamic>?;

      if (id == null || id.isEmpty) {
        throw const CorruptedDatasetFailure('Trip id is missing');
      }
      if (seenTripIds.contains(id)) {
        throw CorruptedDatasetFailure('Duplicate trip id: $id');
      }
      seenTripIds.add(id);

      if (trainNumber == null || trainNumber.isEmpty) {
        throw CorruptedDatasetFailure('Missing train number for trip: $id');
      }

      final lineId = _parseLineId(lineIdStr);
      if (lineId == null) {
        throw CorruptedDatasetFailure(
          'Invalid line id for trip: $id ($lineIdStr)',
        );
      }

      final direction = _parseDirection(dirStr);
      if (direction == null) {
        throw CorruptedDatasetFailure(
          'Invalid direction for trip: $id ($dirStr)',
        );
      }

      final serviceType = _parseServiceType(servStr);
      if (serviceType == null) {
        throw CorruptedDatasetFailure(
          'Invalid service type for trip: $id ($servStr)',
        );
      }

      if (srcId == null || !knownStations.containsKey(srcId)) {
        throw CorruptedDatasetFailure(
          'Unknown source station for trip $id: $srcId',
        );
      }
      if (destId == null || !knownStations.containsKey(destId)) {
        throw CorruptedDatasetFailure(
          'Unknown destination station for trip $id: $destId',
        );
      }

      if (stopsRaw == null || stopsRaw.length < 2) {
        throw CorruptedDatasetFailure('Trip $id must contain at least 2 stops');
      }

      final stops = <StopSchedule>[];
      var prevDepMinutes = -1;
      var expectedSeq = 1;

      for (final dynamic stopItem in stopsRaw) {
        if (stopItem is! Map<String, dynamic>) {
          throw CorruptedDatasetFailure('Invalid stop format in trip: $id');
        }

        final stationId = stopItem['stationId'] as String?;
        final seq = (stopItem['seq'] as num?)?.toInt();
        final arr = (stopItem['arr'] as num?)?.toInt();
        final dep = (stopItem['dep'] as num?)?.toInt();
        final platform = stopItem['platform'] as String?;

        if (stationId == null || !knownStations.containsKey(stationId)) {
          throw CorruptedDatasetFailure(
            'Unknown station in trip $id: $stationId',
          );
        }

        if (seq == null || seq != expectedSeq) {
          throw InvalidScheduleFailure(
            id,
            'Non-monotonic stop sequence at stop $seq (expected $expectedSeq)',
          );
        }
        expectedSeq++;

        if (arr == null || arr < 0 || arr >= 1440) {
          throw InvalidScheduleFailure(id, 'Invalid arrival minutes: $arr');
        }
        if (dep == null || dep < 0 || dep >= 1440) {
          throw InvalidScheduleFailure(id, 'Invalid departure minutes: $dep');
        }

        if (dep < arr) {
          throw InvalidScheduleFailure(
            id,
            'Departure time ($dep) cannot be before arrival time ($arr) at $stationId',
          );
        }

        if (prevDepMinutes != -1 && arr < prevDepMinutes) {
          // Allowed only if crossing midnight (e.g. 23:55 dep -> 00:05 arr)
          final crossesMidnight = prevDepMinutes > 1300 && arr < 120;
          if (!crossesMidnight) {
            throw InvalidScheduleFailure(
              id,
              'Arrival ($arr) is before previous departure ($prevDepMinutes)',
            );
          }
        }
        prevDepMinutes = dep;

        stops.add(
          StopSchedule(
            tripId: id,
            stationId: stationId,
            stopSequence: seq,
            arrivalMinutes: arr,
            departureMinutes: dep,
            platform: platform,
          ),
        );
      }

      final trip = TrainTrip(
        id: id,
        trainNumber: trainNumber,
        lineId: lineId,
        direction: direction,
        serviceType: serviceType,
        sourceStationId: srcId,
        destinationStationId: destId,
        operatingDaysMask: daysMask,
      );

      results.add((trip: trip, stops: stops));
    }

    return results;
  }

  static RailwayLineId? _parseLineId(String? raw) {
    return switch (raw?.toLowerCase()) {
      'western' => RailwayLineId.western,
      'centralmain' || 'central' => RailwayLineId.centralMain,
      'harbour' => RailwayLineId.harbour,
      'transharbour' || 'trans_harbour' => RailwayLineId.transHarbour,
      'uran' => RailwayLineId.uran,
      _ => null,
    };
  }

  static TrainDirection? _parseDirection(String? raw) {
    return switch (raw?.toLowerCase()) {
      'up' => TrainDirection.up,
      'down' => TrainDirection.down,
      _ => null,
    };
  }

  static ServiceType? _parseServiceType(String? raw) {
    return switch (raw?.toLowerCase()) {
      'slow' => ServiceType.slow,
      'fast' => ServiceType.fast,
      'acslow' || 'ac_slow' => ServiceType.acSlow,
      'acfast' || 'ac_fast' => ServiceType.acFast,
      'ladiesspecial' || 'ladies_special' => ServiceType.ladiesSpecial,
      _ => null,
    };
  }
}
