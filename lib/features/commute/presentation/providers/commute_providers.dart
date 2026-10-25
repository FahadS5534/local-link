import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/drift_saved_journeys_repository.dart';
import '../../domain/entities/journey_history_entry.dart';
import '../../domain/entities/saved_journey.dart';
import '../../domain/repositories/saved_journeys_repository.dart';
import '../../../timetable/domain/services/timetable_sync_service.dart';
import '../../../timetable/presentation/providers/timetable_providers.dart';

/// Provides the [SavedJourneysRepository] backed by Drift SQLite.
final savedJourneysRepositoryProvider = Provider<SavedJourneysRepository>((
  ref,
) {
  final db = ref.watch(databaseProvider);
  return DriftSavedJourneysRepository(db);
});

/// Watches the list of saved commuter journeys in real time.
final savedJourneysStreamProvider = StreamProvider<List<SavedJourney>>((ref) {
  final repo = ref.watch(savedJourneysRepositoryProvider);
  return repo.watchSavedJourneys();
});

/// Watches the recent journey history entries in real time.
final journeyHistoryStreamProvider = StreamProvider<List<JourneyHistoryEntry>>((
  ref,
) {
  final repo = ref.watch(savedJourneysRepositoryProvider);
  return repo.watchJourneyHistory(limit: 10);
});

/// Provides the [TimetableSyncService] for atomic dataset updates.
final timetableSyncServiceProvider = Provider<TimetableSyncService>((ref) {
  final db = ref.watch(databaseProvider);
  return TimetableSyncService(db: db);
});

/// Fetches the latest successful sync audit record.
final latestSyncProvider = FutureProvider((ref) async {
  final syncService = ref.watch(timetableSyncServiceProvider);
  return syncService.getLatestSuccessfulSync();
});
