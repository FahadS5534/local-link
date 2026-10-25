import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/timetable/data/database/app_database.dart';
import 'package:local_link/features/timetable/data/datasources/timetable_parser.dart';
import 'package:local_link/features/timetable/data/repositories/drift_timetable_repository.dart';

void main() {
  late AppDatabase db;
  late DriftTimetableRepository repository;
  const parser = TimetableParser();

  setUp(() async {
    // In-memory SQLite connection for isolated, reproducible testing
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftTimetableRepository(db: db);

    // Pre-seed with authentic datasets
    final stationsRaw = File(
      'assets/data/mumbai_stations.json',
    ).readAsStringSync();
    final stations = parser.parseStationsJson(stationsRaw);
    final stationMap = {for (final s in stations) s.id: s};

    final tripsRaw = File('assets/data/mumbai_trips.json').readAsStringSync();
    final trips = parser.parseTripsJson(tripsRaw, stationMap);

    await db.seedDatabase(stations: stations, tripsWithStops: trips);
  });

  tearDown(() async {
    await db.close();
  });

  group('Drift SQLite Database Integration Tests', () {
    test('database reports not empty after seeding', () async {
      expect(await db.isDatabaseEmpty(), isFalse);
    });

    test('getAllStations returns all seeded suburban stations', () async {
      final stations = await repository.getAllStations();
      expect(stations.length, greaterThanOrEqualTo(45));

      // Verify stations are sorted alphabetically by English name
      for (var i = 0; i < stations.length - 1; i++) {
        expect(
          stations[i].nameEn.compareTo(stations[i + 1].nameEn),
          lessThanOrEqualTo(0),
        );
      }
    });

    test('searches stations by English name case-insensitively', () async {
      final results = await repository.searchStations('church');
      expect(results, isNotEmpty);
      expect(results.first.code, 'CCG');
      expect(results.first.nameEn, 'Churchgate');
    });

    test('searches stations by station code (e.g. DDR, CSMT, BVI)', () async {
      final ddr = await repository.searchStations('DDR');
      expect(ddr, isNotEmpty);
      expect(ddr.first.nameEn, 'Dadar');
      expect(ddr.first.isInterchange, isTrue);

      final csmt = await repository.searchStations('csmt');
      expect(csmt, isNotEmpty);
      expect(csmt.first.code, 'CSMT');
    });

    test('searches stations by Marathi name in Devanagari script', () async {
      final results = await repository.searchStations('वांद्रे'); // Bandra
      expect(results, isNotEmpty);
      expect(results.first.code, 'BA');
      expect(results.first.nameEn, 'Bandra');
    });

    test('searches stations by Hindi name in Devanagari script', () async {
      final results = await repository.searchStations('अंधेरी'); // Andheri
      expect(results, isNotEmpty);
      expect(results.first.code, 'ADH');
      expect(results.first.nameEn, 'Andheri');
    });

    test(
      'querying direct routes from Churchgate to Borivali returns fast and slow options',
      () async {
        // Warmup query to initialize JIT compilation
        await repository.findDirectRoutes(
          originId: 'ST_CCG',
          destinationId: 'ST_BVI',
          afterMinutes: 500,
        );

        final stopwatch = Stopwatch()..start();

        final routes = await repository.findDirectRoutes(
          originId: 'ST_CCG',
          destinationId: 'ST_BVI',
          afterMinutes: 500, // 08:20
        );

        stopwatch.stop();

        // Ensure reasonable performance gate in parallel test environment
        expect(stopwatch.elapsedMilliseconds, lessThan(500));
        expect(routes.length, 2);

        // Route 1: WR_90001 (Fast Local)
        final fastRoute = routes.first;
        expect(fastRoute.isDirect, isTrue);
        expect(fastRoute.legs.first.trip.isFast, isTrue);
        expect(fastRoute.legs.first.departureTimeFormatted, '08:20'); // 500 min
        expect(fastRoute.legs.first.arrivalTimeFormatted, '09:06'); // 546 min
        expect(fastRoute.totalDurationMinutes, 46); // 46 min fast train
        expect(fastRoute.legs.first.intermediateStops.length, 6);

        // Route 2: WR_90003 (Slow Local)
        final slowRoute = routes[1];
        expect(slowRoute.isDirect, isTrue);
        expect(slowRoute.legs.first.trip.isFast, isFalse);
        expect(slowRoute.legs.first.departureTimeFormatted, '08:30'); // 510 min
        expect(slowRoute.legs.first.arrivalTimeFormatted, '10:29'); // 629 min
        expect(slowRoute.totalDurationMinutes, 119); // 119 min slow train
        expect(slowRoute.legs.first.intermediateStops.length, 22);
      },
    );

    test(
      'querying direct routes between stations on different corridors returns empty',
      () async {
        // Churchgate (Western) to CSMT (Central) has no direct train without transfer
        final routes = await repository.findDirectRoutes(
          originId: 'ST_CCG',
          destinationId: 'ST_CSMT',
          afterMinutes: 500,
        );

        expect(routes, isEmpty);
      },
    );
  });
}
