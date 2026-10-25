import 'package:flutter/services.dart';
import '../../domain/entities/route_plan.dart';
import '../../domain/entities/station.dart';
import '../../domain/entities/stop_schedule.dart';
import '../../domain/failures/timetable_failure.dart';
import '../../domain/repositories/timetable_repository.dart';
import '../database/app_database.dart';
import '../datasources/timetable_parser.dart';

/// SQLite Drift implementation of [TimetableRepository].
class DriftTimetableRepository implements TimetableRepository {
  final AppDatabase _db;
  final TimetableParser _parser;
  final AssetBundle _bundle;

  DriftTimetableRepository({
    required AppDatabase db,
    TimetableParser parser = const TimetableParser(),
    AssetBundle? bundle,
  }) : _db = db,
       _parser = parser,
       _bundle = bundle ?? rootBundle;

  @override
  Future<void> initializeSeedData() async {
    final isEmpty = await _db.isDatabaseEmpty();
    if (!isEmpty) return;

    try {
      final stationsRaw = await _bundle.loadString(
        'assets/data/mumbai_stations.json',
      );
      final stations = _parser.parseStationsJson(stationsRaw);
      final stationMap = {for (final s in stations) s.id: s};

      final tripsRaw = await _bundle.loadString(
        'assets/data/mumbai_trips.json',
      );
      final trips = _parser.parseTripsJson(tripsRaw, stationMap);

      await _db.seedDatabase(stations: stations, tripsWithStops: trips);
    } catch (e) {
      throw DatabaseFailure('Failed to initialize seed timetable data', e);
    }
  }

  @override
  Future<List<Station>> getAllStations() {
    return _db.getAllStations();
  }

  @override
  Future<List<Station>> searchStations(String query) {
    if (query.trim().isEmpty) {
      return _db.getAllStations();
    }
    return _db.searchStations(query);
  }

  @override
  Future<Station?> getStationByCode(String code) {
    return _db.getStationByCode(code);
  }

  @override
  Future<Station?> getStationById(String id) {
    return _db.getStationById(id);
  }

  @override
  Future<List<StopSchedule>> getStopsForTrip(String tripId) {
    return _db.getStopsForTrip(tripId);
  }

  @override
  Future<List<RoutePlan>> findDirectRoutes({
    required String originId,
    required String destinationId,
    int? afterMinutes,
    int? weekday,
  }) async {
    final originStation = await _db.getStationById(originId);
    final destinationStation = await _db.getStationById(destinationId);

    if (originStation == null || destinationStation == null) {
      return const [];
    }

    final directRecords = await _db.findDirectTrips(
      originStationId: originId,
      destinationStationId: destinationId,
      afterMinutes: afterMinutes,
      weekday: weekday,
    );

    final routePlans = <RoutePlan>[];

    for (final record in directRecords) {
      final allStops = await _db.getStopsForTrip(record.trip.id);

      // Slice intermediate stops between origin and destination
      final journeyStops = allStops
          .where(
            (s) =>
                s.stopSequence >= record.originStop.stopSequence &&
                s.stopSequence <= record.destStop.stopSequence,
          )
          .toList();

      final leg = RouteLeg(
        trip: record.trip,
        originStation: originStation,
        destinationStation: destinationStation,
        departureMinutes: record.originStop.departureMinutes,
        arrivalMinutes: record.destStop.arrivalMinutes,
        intermediateStops: journeyStops,
      );

      routePlans.add(
        RoutePlan(
          origin: originStation,
          destination: destinationStation,
          legs: [leg],
        ),
      );
    }

    return routePlans;
  }
}
