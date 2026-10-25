import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import '../../data/datasources/timetable_parser.dart';
import '../../data/database/app_database.dart';

/// Represents the status of a timetable synchronization attempt.
enum SyncStatus { idle, syncing, success, failed }

/// Result object describing the outcome of a timetable synchronization.
class TimetableSyncResult {
  final bool isSuccess;
  final String version;
  final String checksum;
  final int stationsCount;
  final int tripsCount;
  final String? errorMessage;
  final DateTime timestamp;

  const TimetableSyncResult({
    required this.isSuccess,
    required this.version,
    required this.checksum,
    this.stationsCount = 0,
    this.tripsCount = 0,
    this.errorMessage,
    required this.timestamp,
  });
}

/// Service orchestrating atomic timetable dataset synchronization with SHA-256 validation.
class TimetableSyncService {
  final AppDatabase _db;
  final TimetableParser _parser;

  TimetableSyncService({
    required AppDatabase db,
    TimetableParser parser = const TimetableParser(),
  }) : _db = db,
       _parser = parser;

  /// Calculates SHA-256 hash for dataset verification.
  String computeChecksum(String stationsJson, String tripsJson) {
    final bytes = utf8.encode(stationsJson + tripsJson);
    return sha256.convert(bytes).toString();
  }

  /// Checks if a dataset with this [checksum] was already imported successfully.
  Future<bool> isDatasetAlreadySynced(String checksum) async {
    final existing =
        await (_db.select(_db.syncHistoryTable)..where(
              (tbl) =>
                  tbl.checksum.equals(checksum) & tbl.status.equals('SUCCESS'),
            ))
            .get();
    return existing.isNotEmpty;
  }

  /// Atomically validates and applies a new timetable dataset.
  /// If validation fails or an exception occurs, the previous dataset remains untouched.
  Future<TimetableSyncResult> syncDataset({
    required String version,
    required String stationsJson,
    required String tripsJson,
    String? expectedChecksum,
  }) async {
    final checksum = computeChecksum(stationsJson, tripsJson);
    final now = DateTime.now();

    // 1. Verify integrity against expected checksum if supplied
    if (expectedChecksum != null &&
        expectedChecksum.isNotEmpty &&
        expectedChecksum.toLowerCase() != checksum.toLowerCase()) {
      await _recordSyncAudit(
        version: version,
        checksum: checksum,
        status: 'FAILED',
        timestamp: now,
      );
      return TimetableSyncResult(
        isSuccess: false,
        version: version,
        checksum: checksum,
        errorMessage: 'SHA-256 checksum mismatch. Dataset may be corrupted.',
        timestamp: now,
      );
    }

    // 2. Prevent redundant sync
    if (await isDatasetAlreadySynced(checksum)) {
      return TimetableSyncResult(
        isSuccess: true,
        version: version,
        checksum: checksum,
        errorMessage: 'Dataset is already up-to-date.',
        timestamp: now,
      );
    }

    try {
      // 3. Strict parsing & relational validation outside transaction
      final stations = _parser.parseStationsJson(stationsJson);
      final stationMap = {for (final s in stations) s.id: s};
      final tripsWithStops = _parser.parseTripsJson(tripsJson, stationMap);

      if (stations.isEmpty || tripsWithStops.isEmpty) {
        throw Exception('Dataset contains zero stations or trips.');
      }

      // 4. Atomic database update transaction
      await _db.seedDatabase(
        stations: stations,
        tripsWithStops: tripsWithStops,
      );

      // 5. Update sync metadata in database
      await _recordSyncAudit(
        version: version,
        checksum: checksum,
        status: 'SUCCESS',
        timestamp: now,
      );

      return TimetableSyncResult(
        isSuccess: true,
        version: version,
        checksum: checksum,
        stationsCount: stations.length,
        tripsCount: tripsWithStops.length,
        timestamp: now,
      );
    } catch (e) {
      // 6. On error: rollback guaranteed by SQLite transaction; record failure audit
      await _recordSyncAudit(
        version: version,
        checksum: checksum,
        status: 'FAILED',
        timestamp: now,
      );

      return TimetableSyncResult(
        isSuccess: false,
        version: version,
        checksum: checksum,
        errorMessage: e.toString(),
        timestamp: now,
      );
    }
  }

  /// Retrieves the latest successful sync record.
  Future<SyncHistoryTableData?> getLatestSuccessfulSync() async {
    return (_db.select(_db.syncHistoryTable)
          ..where((tbl) => tbl.status.equals('SUCCESS'))
          ..orderBy([(t) => OrderingTerm.desc(t.syncedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> _recordSyncAudit({
    required String version,
    required String checksum,
    required String status,
    required DateTime timestamp,
  }) async {
    await _db
        .into(_db.syncHistoryTable)
        .insert(
          SyncHistoryTableCompanion.insert(
            datasetVersion: version,
            checksum: checksum,
            status: status,
            syncedAt: timestamp,
          ),
        );
  }
}
