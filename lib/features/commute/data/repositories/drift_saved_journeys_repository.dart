import 'package:drift/drift.dart';
import '../../domain/entities/journey_history_entry.dart';
import '../../domain/entities/saved_journey.dart';
import '../../domain/repositories/saved_journeys_repository.dart';
import '../../../timetable/data/database/app_database.dart';

/// Drift/SQLite implementation of [SavedJourneysRepository].
class DriftSavedJourneysRepository implements SavedJourneysRepository {
  final AppDatabase _db;

  DriftSavedJourneysRepository(this._db);

  @override
  Future<List<SavedJourney>> getSavedJourneys() async {
    final rows =
        await (_db.select(_db.savedJourneysTable)..orderBy([
              (t) => OrderingTerm.desc(t.isPinned),
              (t) => OrderingTerm.desc(t.createdAt),
            ]))
            .get();

    return rows.map(_mapSavedJourney).toList();
  }

  @override
  Stream<List<SavedJourney>> watchSavedJourneys() {
    return (_db.select(_db.savedJourneysTable)..orderBy([
          (t) => OrderingTerm.desc(t.isPinned),
          (t) => OrderingTerm.desc(t.createdAt),
        ]))
        .watch()
        .map((rows) => rows.map(_mapSavedJourney).toList());
  }

  @override
  Future<void> saveJourney(SavedJourney journey) async {
    await _db
        .into(_db.savedJourneysTable)
        .insertOnConflictUpdate(
          SavedJourneysTableCompanion.insert(
            id: journey.id,
            label: journey.label,
            originStationId: journey.originStationId,
            destinationStationId: journey.destinationStationId,
            isPinned: Value(journey.isPinned),
            createdAt: journey.createdAt,
          ),
        );
  }

  @override
  Future<void> deleteSavedJourney(String id) async {
    await (_db.delete(
      _db.savedJourneysTable,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<void> togglePin(String id) async {
    final existing = await (_db.select(
      _db.savedJourneysTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

    if (existing != null) {
      await (_db.update(
        _db.savedJourneysTable,
      )..where((tbl) => tbl.id.equals(id))).write(
        SavedJourneysTableCompanion(isPinned: Value(!existing.isPinned)),
      );
    }
  }

  @override
  Future<List<JourneyHistoryEntry>> getJourneyHistory({int limit = 10}) async {
    final rows =
        await (_db.select(_db.journeyHistoryTable)
              ..orderBy([(t) => OrderingTerm.desc(t.queriedAt)])
              ..limit(limit))
            .get();

    return rows.map(_mapHistoryEntry).toList();
  }

  @override
  Stream<List<JourneyHistoryEntry>> watchJourneyHistory({int limit = 10}) {
    return (_db.select(_db.journeyHistoryTable)
          ..orderBy([(t) => OrderingTerm.desc(t.queriedAt)])
          ..limit(limit))
        .watch()
        .map((rows) => rows.map(_mapHistoryEntry).toList());
  }

  @override
  Future<void> recordJourneyHistory(JourneyHistoryEntry entry) async {
    await _db
        .into(_db.journeyHistoryTable)
        .insertOnConflictUpdate(
          JourneyHistoryTableCompanion.insert(
            id: entry.id,
            originStationId: entry.originStationId,
            destinationStationId: entry.destinationStationId,
            estimatedDurationMinutes: entry.estimatedDurationMinutes,
            queriedAt: entry.queriedAt,
          ),
        );
  }

  @override
  Future<void> clearJourneyHistory() async {
    await _db.delete(_db.journeyHistoryTable).go();
  }

  SavedJourney _mapSavedJourney(SavedJourneysTableData row) {
    return SavedJourney(
      id: row.id,
      label: row.label,
      originStationId: row.originStationId,
      destinationStationId: row.destinationStationId,
      isPinned: row.isPinned,
      createdAt: row.createdAt,
    );
  }

  JourneyHistoryEntry _mapHistoryEntry(JourneyHistoryTableData row) {
    return JourneyHistoryEntry(
      id: row.id,
      originStationId: row.originStationId,
      destinationStationId: row.destinationStationId,
      estimatedDurationMinutes: row.estimatedDurationMinutes,
      queriedAt: row.queriedAt,
    );
  }
}
