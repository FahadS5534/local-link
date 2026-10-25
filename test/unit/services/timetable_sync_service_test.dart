import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/timetable/data/database/app_database.dart';
import 'package:local_link/features/timetable/domain/services/timetable_sync_service.dart';

void main() {
  late AppDatabase db;
  late TimetableSyncService syncService;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    syncService = TimetableSyncService(db: db);
  });

  tearDown(() async {
    await db.close();
  });

  group('TimetableSyncService Tests', () {
    test('computes deterministic SHA-256 checksum', () {
      final checksum1 = syncService.computeChecksum(
        '["stations"]',
        '["trips"]',
      );
      final checksum2 = syncService.computeChecksum(
        '["stations"]',
        '["trips"]',
      );
      final checksum3 = syncService.computeChecksum(
        '["different"]',
        '["trips"]',
      );

      expect(checksum1, equals(checksum2));
      expect(checksum1, isNot(equals(checksum3)));
      expect(checksum1.length, equals(64));
    });

    test(
      'successfully imports real valid dataset and updates sync history audit',
      () async {
        final stationsJson = File(
          'assets/data/mumbai_stations.json',
        ).readAsStringSync();
        final tripsJson = File(
          'assets/data/mumbai_trips.json',
        ).readAsStringSync();

        final result = await syncService.syncDataset(
          version: 'v2026.10',
          stationsJson: stationsJson,
          tripsJson: tripsJson,
        );

        expect(result.isSuccess, isTrue);
        expect(result.version, equals('v2026.10'));
        expect(result.stationsCount, greaterThanOrEqualTo(45));
        expect(result.tripsCount, greaterThanOrEqualTo(10));

        final latestSync = await syncService.getLatestSuccessfulSync();
        expect(latestSync, isNotNull);
        expect(latestSync!.datasetVersion, equals('v2026.10'));
        expect(latestSync.status, equals('SUCCESS'));
      },
    );

    test(
      'rejects dataset with checksum mismatch and records FAILED status in audit',
      () async {
        final stationsJson = File(
          'assets/data/mumbai_stations.json',
        ).readAsStringSync();
        final tripsJson = File(
          'assets/data/mumbai_trips.json',
        ).readAsStringSync();

        final result = await syncService.syncDataset(
          version: 'v2026.10',
          stationsJson: stationsJson,
          tripsJson: tripsJson,
          expectedChecksum:
              '0000000000000000000000000000000000000000000000000000000000000000',
        );

        expect(result.isSuccess, isFalse);
        expect(result.errorMessage, contains('checksum mismatch'));

        final rows = await db.select(db.syncHistoryTable).get();
        expect(rows.length, equals(1));
        expect(rows.first.status, equals('FAILED'));
      },
    );

    test(
      'preserves valid dataset and rolls back on malformed corrupted import',
      () async {
        // 1. Initial valid seed
        final stationsJson = File(
          'assets/data/mumbai_stations.json',
        ).readAsStringSync();
        final tripsJson = File(
          'assets/data/mumbai_trips.json',
        ).readAsStringSync();
        await syncService.syncDataset(
          version: 'v2026.10',
          stationsJson: stationsJson,
          tripsJson: tripsJson,
        );

        final initialStationCount =
            (await db.select(db.stationsTable).get()).length;
        expect(initialStationCount, greaterThanOrEqualTo(45));

        // 2. Corrupted import attempt
        final corruptResult = await syncService.syncDataset(
          version: 'v2026.11',
          stationsJson: 'not a valid json syntax',
          tripsJson: '[]',
        );

        expect(corruptResult.isSuccess, isFalse);

        // 3. Database is intact (rollback preserved prior data)
        final postStationCount =
            (await db.select(db.stationsTable).get()).length;
        expect(postStationCount, equals(initialStationCount));
      },
    );

    test(
      'prevents redundant duplicate imports with identical checksum',
      () async {
        final stationsJson = File(
          'assets/data/mumbai_stations.json',
        ).readAsStringSync();
        final tripsJson = File(
          'assets/data/mumbai_trips.json',
        ).readAsStringSync();

        await syncService.syncDataset(
          version: 'v2026.10',
          stationsJson: stationsJson,
          tripsJson: tripsJson,
        );

        final secondResult = await syncService.syncDataset(
          version: 'v2026.10',
          stationsJson: stationsJson,
          tripsJson: tripsJson,
        );

        expect(secondResult.isSuccess, isTrue);
        expect(secondResult.errorMessage, contains('already up-to-date'));
      },
    );
  });
}
