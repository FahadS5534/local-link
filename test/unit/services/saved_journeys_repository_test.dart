import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/commute/data/repositories/drift_saved_journeys_repository.dart';
import 'package:local_link/features/commute/domain/entities/journey_history_entry.dart';
import 'package:local_link/features/commute/domain/entities/saved_journey.dart';
import 'package:local_link/features/timetable/data/database/app_database.dart';

void main() {
  late AppDatabase db;
  late DriftSavedJourneysRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = DriftSavedJourneysRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('DriftSavedJourneysRepository Tests', () {
    test('saves, reads, and toggles pinned status of journeys', () async {
      final now = DateTime.now();
      final journey1 = SavedJourney(
        id: 'sj_1',
        label: 'Work (BVI -> CCG)',
        originStationId: 'ST_BVI',
        destinationStationId: 'ST_CCG',
        isPinned: false,
        createdAt: now,
      );

      final journey2 = SavedJourney(
        id: 'sj_2',
        label: 'College (TNA -> DDR)',
        originStationId: 'ST_TNA',
        destinationStationId: 'ST_DDR',
        isPinned: true,
        createdAt: now.add(const Duration(minutes: 5)),
      );

      await repo.saveJourney(journey1);
      await repo.saveJourney(journey2);

      final list = await repo.getSavedJourneys();
      expect(list.length, equals(2));
      // Pinned journey should be first
      expect(list.first.id, equals('sj_2'));

      // Toggle pin on journey 1
      await repo.togglePin('sj_1');
      final updatedList = await repo.getSavedJourneys();
      final updatedJ1 = updatedList.firstWhere((j) => j.id == 'sj_1');
      expect(updatedJ1.isPinned, isTrue);

      // Delete journey 2
      await repo.deleteSavedJourney('sj_2');
      final afterDelete = await repo.getSavedJourneys();
      expect(afterDelete.length, equals(1));
      expect(afterDelete.first.id, equals('sj_1'));
    });

    test(
      'records and retrieves search history with limit, and clears history',
      () async {
        final now = DateTime.now();
        for (int i = 0; i < 5; i++) {
          await repo.recordJourneyHistory(
            JourneyHistoryEntry(
              id: 'h_$i',
              originStationId: 'ST_CCG',
              destinationStationId: 'ST_BVI',
              estimatedDurationMinutes: 45 + i,
              queriedAt: now.add(Duration(minutes: i)),
            ),
          );
        }

        final history = await repo.getJourneyHistory(limit: 3);
        expect(history.length, equals(3));
        // Latest first
        expect(history.first.id, equals('h_4'));

        await repo.clearJourneyHistory();
        final cleared = await repo.getJourneyHistory();
        expect(cleared, isEmpty);
      },
    );
  });
}
