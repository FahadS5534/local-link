import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/timetable/data/datasources/timetable_parser.dart';
import 'package:local_link/features/timetable/domain/entities/station.dart';
import 'package:local_link/features/timetable/domain/failures/timetable_failure.dart';

void main() {
  const parser = TimetableParser();

  group('TimetableParser - Real Seed Data Validation', () {
    test('parses authentic mumbai_stations.json without errors', () {
      final file = File('assets/data/mumbai_stations.json');
      expect(
        file.existsSync(),
        isTrue,
        reason: 'mumbai_stations.json must exist',
      );

      final rawJson = file.readAsStringSync();
      final stations = parser.parseStationsJson(rawJson);

      expect(stations.length, greaterThanOrEqualTo(45));

      // Check key junction stations
      final dadar = stations.firstWhere((s) => s.code == 'DDR');
      expect(dadar.nameEn, 'Dadar');
      expect(dadar.nameHi, 'दादर');
      expect(dadar.nameMr, 'दादर');
      expect(dadar.isInterchange, isTrue);
      expect(dadar.lines, contains(RailwayLineId.western));
      expect(dadar.lines, contains(RailwayLineId.centralMain));

      final csmt = stations.firstWhere((s) => s.code == 'CSMT');
      expect(csmt.lines, contains(RailwayLineId.centralMain));
      expect(csmt.lines, contains(RailwayLineId.harbour));

      final borivali = stations.firstWhere((s) => s.code == 'BVI');
      expect(borivali.nameEn, 'Borivali');
      expect(borivali.lines, contains(RailwayLineId.western));
    });

    test('parses authentic mumbai_trips.json without errors', () {
      final stationsFile = File('assets/data/mumbai_stations.json');
      final stations = parser.parseStationsJson(
        stationsFile.readAsStringSync(),
      );
      final stationMap = {for (final s in stations) s.id: s};

      final tripsFile = File('assets/data/mumbai_trips.json');
      expect(
        tripsFile.existsSync(),
        isTrue,
        reason: 'mumbai_trips.json must exist',
      );

      final rawJson = tripsFile.readAsStringSync();
      final tripRecords = parser.parseTripsJson(rawJson, stationMap);

      expect(tripRecords, isNotEmpty);

      // Verify fast train record
      final fastTrip = tripRecords.firstWhere((r) => r.trip.id == 'WR_90001');
      expect(fastTrip.trip.isFast, isTrue);
      expect(fastTrip.stops.length, 6);
      expect(fastTrip.stops.first.stationId, 'ST_CCG');
      expect(fastTrip.stops.last.stationId, 'ST_BVI');

      // Verify slow train record
      final slowTrip = tripRecords.firstWhere((r) => r.trip.id == 'WR_90003');
      expect(slowTrip.trip.isFast, isFalse);
      expect(slowTrip.stops.length, 22);
    });
  });

  group('TimetableParser - Error Handling & Edge Cases', () {
    test('throws CorruptedDatasetFailure on malformed JSON string', () {
      expect(
        () => parser.parseStationsJson('{ invalid json }'),
        throwsA(isA<CorruptedDatasetFailure>()),
      );
    });

    test(
      'throws CorruptedDatasetFailure on station latitude out of Mumbai bounds',
      () {
        const invalidLatStation = '''
      [
        {
          "id": "ST_INVALID",
          "code": "INV",
          "nameEn": "Invalid Station",
          "nameHi": "अमान्य",
          "nameMr": "अमान्य",
          "latitude": 28.6139,
          "longitude": 72.8277,
          "lines": ["western"]
        }
      ]
      ''';
        expect(
          () => parser.parseStationsJson(invalidLatStation),
          throwsA(isA<CorruptedDatasetFailure>()),
        );
      },
    );

    test('throws CorruptedDatasetFailure on duplicate station code', () {
      const duplicateCodeJson = '''
      [
        {
          "id": "ST_AAA",
          "code": "DUP",
          "nameEn": "Station A",
          "nameHi": "ए",
          "nameMr": "ए",
          "latitude": 19.0178,
          "longitude": 72.8431,
          "lines": ["western"]
        },
        {
          "id": "ST_BBB",
          "code": "DUP",
          "nameEn": "Station B",
          "nameHi": "बी",
          "nameMr": "बी",
          "latitude": 19.0178,
          "longitude": 72.8431,
          "lines": ["western"]
        }
      ]
      ''';
      expect(
        () => parser.parseStationsJson(duplicateCodeJson),
        throwsA(isA<CorruptedDatasetFailure>()),
      );
    });

    test(
      'throws InvalidScheduleFailure when stop sequence is non-monotonic',
      () {
        final stations = {
          'ST_A': const Station(
            id: 'ST_A',
            code: 'A',
            nameEn: 'A',
            nameHi: 'ए',
            nameMr: 'ए',
            latitude: 19.0,
            longitude: 72.8,
            lines: [RailwayLineId.western],
          ),
          'ST_B': const Station(
            id: 'ST_B',
            code: 'B',
            nameEn: 'B',
            nameHi: 'बी',
            nameMr: 'बी',
            latitude: 19.1,
            longitude: 72.8,
            lines: [RailwayLineId.western],
          ),
        };

        const nonMonotonicStopsJson = '''
      [
        {
          "id": "TRIP_BAD_SEQ",
          "trainNumber": "99999",
          "lineId": "western",
          "direction": "down",
          "serviceType": "slow",
          "sourceStationId": "ST_A",
          "destinationStationId": "ST_B",
          "stops": [
            { "stationId": "ST_A", "seq": 1, "arr": 500, "dep": 500 },
            { "stationId": "ST_B", "seq": 3, "arr": 510, "dep": 510 }
          ]
        }
      ]
      ''';

        expect(
          () => parser.parseTripsJson(nonMonotonicStopsJson, stations),
          throwsA(isA<InvalidScheduleFailure>()),
        );
      },
    );

    test(
      'throws InvalidScheduleFailure when departure time is before arrival time',
      () {
        final stations = {
          'ST_A': const Station(
            id: 'ST_A',
            code: 'A',
            nameEn: 'A',
            nameHi: 'ए',
            nameMr: 'ए',
            latitude: 19.0,
            longitude: 72.8,
            lines: [RailwayLineId.western],
          ),
          'ST_B': const Station(
            id: 'ST_B',
            code: 'B',
            nameEn: 'B',
            nameHi: 'बी',
            nameMr: 'बी',
            latitude: 19.1,
            longitude: 72.8,
            lines: [RailwayLineId.western],
          ),
        };

        const depBeforeArrJson = '''
      [
        {
          "id": "TRIP_BAD_TIME",
          "trainNumber": "99999",
          "lineId": "western",
          "direction": "down",
          "serviceType": "slow",
          "sourceStationId": "ST_A",
          "destinationStationId": "ST_B",
          "stops": [
            { "stationId": "ST_A", "seq": 1, "arr": 505, "dep": 500 },
            { "stationId": "ST_B", "seq": 2, "arr": 510, "dep": 510 }
          ]
        }
      ]
      ''';

        expect(
          () => parser.parseTripsJson(depBeforeArrJson, stations),
          throwsA(isA<InvalidScheduleFailure>()),
        );
      },
    );
  });
}
