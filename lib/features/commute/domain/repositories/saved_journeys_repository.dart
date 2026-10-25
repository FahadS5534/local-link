import '../entities/journey_history_entry.dart';
import '../entities/saved_journey.dart';

/// Repository interface for managing commuter's saved journeys and search history.
abstract class SavedJourneysRepository {
  /// Retrieves all saved journeys ordered by pinned status and creation date.
  Future<List<SavedJourney>> getSavedJourneys();

  /// Watches all saved journeys reactively.
  Stream<List<SavedJourney>> watchSavedJourneys();

  /// Saves or updates a journey (e.g. Home, Work, College).
  Future<void> saveJourney(SavedJourney journey);

  /// Deletes a saved journey by its identifier.
  Future<void> deleteSavedJourney(String id);

  /// Toggles whether a journey is pinned to the dashboard.
  Future<void> togglePin(String id);

  /// Retrieves recent journey history entries.
  Future<List<JourneyHistoryEntry>> getJourneyHistory({int limit = 10});

  /// Watches recent journey history entries reactively.
  Stream<List<JourneyHistoryEntry>> watchJourneyHistory({int limit = 10});

  /// Records a journey query in history.
  Future<void> recordJourneyHistory(JourneyHistoryEntry entry);

  /// Clears all stored journey history entries.
  Future<void> clearJourneyHistory();
}
