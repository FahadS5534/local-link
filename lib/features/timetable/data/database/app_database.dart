import 'dart:convert';
import 'package:drift/drift.dart';
import '../../domain/entities/station.dart';
import '../../domain/entities/stop_schedule.dart';
import '../../domain/entities/train_trip.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    StationsTable,
    TripsTable,
    StopSchedulesTable,
    DatasetMetadataTable,
    SavedJourneysTable,
    JourneyHistoryTable,
    ServiceAdvisoriesTable,
    SyncHistoryTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      // Create high-speed SQLite lookup indexes
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_stations_code ON stations(code);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_stops_station_dep ON stop_schedules(station_id, departure_minutes);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_stops_trip_seq ON stop_schedules(trip_id, stop_sequence);',
      );
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(savedJourneysTable);
        await m.createTable(journeyHistoryTable);
        await m.createTable(serviceAdvisoriesTable);
        await m.createTable(syncHistoryTable);
      }
    },
  );

  /// Check if the database has already been seeded.
  Future<bool> isDatabaseEmpty() async {
    final count = await (select(stationsTable)..limit(1)).get();
    return count.isEmpty;
  }

  /// Bulk seed stations, trips, and stops into SQLite in a single transaction.
  Future<void> seedDatabase({
    required List<Station> stations,
    required List<({TrainTrip trip, List<StopSchedule> stops})> tripsWithStops,
  }) async {
    await transaction(() async {
      // 1. Insert stations
      for (final s in stations) {
        await into(stationsTable).insertOnConflictUpdate(
          StationsTableCompanion.insert(
            id: s.id,
            code: s.code,
            nameEn: s.nameEn,
            nameHi: s.nameHi,
            nameMr: s.nameMr,
            latitude: s.latitude,
            longitude: s.longitude,
            linesJson: jsonEncode(s.lines.map((l) => l.name).toList()),
            isInterchange: Value(s.isInterchange),
          ),
        );
      }

      // 2. Insert trips & stops
      for (final record in tripsWithStops) {
        final t = record.trip;
        await into(tripsTable).insertOnConflictUpdate(
          TripsTableCompanion.insert(
            id: t.id,
            trainNumber: t.trainNumber,
            lineId: t.lineId.name,
            direction: t.direction.name,
            serviceType: t.serviceType.name,
            sourceStationId: t.sourceStationId,
            destinationStationId: t.destinationStationId,
            operatingDaysMask: Value(t.operatingDaysMask),
          ),
        );

        for (final stop in record.stops) {
          await into(stopSchedulesTable).insert(
            StopSchedulesTableCompanion.insert(
              tripId: stop.tripId,
              stationId: stop.stationId,
              stopSequence: stop.stopSequence,
              arrivalMinutes: stop.arrivalMinutes,
              departureMinutes: stop.departureMinutes,
              platform: Value(stop.platform),
            ),
          );
        }
      }

      // Record metadata
      await into(datasetMetadataTable).insertOnConflictUpdate(
        DatasetMetadataTableCompanion.insert(
          key: 'seeded_at',
          value: DateTime.now().toIso8601String(),
        ),
      );
    });
  }

  /// Search stations matching query across English, Marathi, Hindi names or official station code.
  Future<List<Station>> searchStations(String query) async {
    final cleanQuery = '%${query.trim().toLowerCase()}%';
    final rows =
        await (select(stationsTable)..where(
              (tbl) =>
                  tbl.nameEn.lower().like(cleanQuery) |
                  tbl.nameHi.like(cleanQuery) |
                  tbl.nameMr.like(cleanQuery) |
                  tbl.code.lower().like(cleanQuery),
            ))
            .get();

    return rows.map(_mapStationRow).toList();
  }

  /// Retrieve all stations ordered alphabetically by English name.
  Future<List<Station>> getAllStations() async {
    final rows = await (select(
      stationsTable,
    )..orderBy([(t) => OrderingTerm.asc(t.nameEn)])).get();
    return rows.map(_mapStationRow).toList();
  }

  /// Look up station by stable ID (e.g. 'ST_DDR').
  Future<Station?> getStationById(String id) async {
    final row = await (select(
      stationsTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row == null ? null : _mapStationRow(row);
  }

  /// Look up station by railway code (e.g. 'DDR', 'CSMT').
  Future<Station?> getStationByCode(String code) async {
    final cleanCode = code.trim().toUpperCase();
    final row = await (select(
      stationsTable,
    )..where((tbl) => tbl.code.equals(cleanCode))).getSingleOrNull();
    return row == null ? null : _mapStationRow(row);
  }

  /// Direct journey lookup: find trips that stop at [originStationId] and later at [destinationStationId].
  Future<
    List<({TrainTrip trip, StopSchedule originStop, StopSchedule destStop})>
  >
  findDirectTrips({
    required String originStationId,
    required String destinationStationId,
    int? afterMinutes,
    int? weekday,
  }) async {
    final originStops = alias(stopSchedulesTable, 'orig_stops');
    final destStops = alias(stopSchedulesTable, 'dest_stops');

    final query = select(tripsTable).join([
      innerJoin(originStops, originStops.tripId.equalsExp(tripsTable.id)),
      innerJoin(destStops, destStops.tripId.equalsExp(tripsTable.id)),
    ]);

    query.where(
      originStops.stationId.equals(originStationId) &
          destStops.stationId.equals(destinationStationId) &
          originStops.stopSequence.isSmallerThan(destStops.stopSequence),
    );

    if (afterMinutes != null) {
      query.where(
        originStops.departureMinutes.isBiggerOrEqualValue(afterMinutes),
      );
    }

    query.orderBy([OrderingTerm.asc(originStops.departureMinutes)]);

    final rows = await query.get();

    final results =
        <({TrainTrip trip, StopSchedule originStop, StopSchedule destStop})>[];

    for (final row in rows) {
      final tripRow = row.readTable(tripsTable);
      final origRow = row.readTable(originStops);
      final destRow = row.readTable(destStops);

      final trip = _mapTripRow(tripRow);
      if (weekday != null && !trip.runsOnWeekday(weekday)) {
        continue;
      }

      final originStop = _mapStopRow(origRow);
      final destStop = _mapStopRow(destRow);

      results.add((trip: trip, originStop: originStop, destStop: destStop));
    }

    return results;
  }

  /// Fetch all intermediate stops for a trip ordered by stopSequence.
  Future<List<StopSchedule>> getStopsForTrip(String tripId) async {
    final rows =
        await (select(stopSchedulesTable)
              ..where((tbl) => tbl.tripId.equals(tripId))
              ..orderBy([(t) => OrderingTerm.asc(t.stopSequence)]))
            .get();

    return rows.map(_mapStopRow).toList();
  }

  Station _mapStationRow(StationsTableData row) {
    final linesList = (jsonDecode(row.linesJson) as List<dynamic>)
        .map(
          (e) => RailwayLineId.values.firstWhere(
            (val) => val.name == e.toString(),
            orElse: () => RailwayLineId.western,
          ),
        )
        .toList();

    return Station(
      id: row.id,
      code: row.code,
      nameEn: row.nameEn,
      nameHi: row.nameHi,
      nameMr: row.nameMr,
      latitude: row.latitude,
      longitude: row.longitude,
      lines: linesList,
      isInterchange: row.isInterchange,
    );
  }

  TrainTrip _mapTripRow(TripsTableData row) {
    return TrainTrip(
      id: row.id,
      trainNumber: row.trainNumber,
      lineId: RailwayLineId.values.firstWhere(
        (e) => e.name == row.lineId,
        orElse: () => RailwayLineId.western,
      ),
      direction: TrainDirection.values.firstWhere(
        (e) => e.name == row.direction,
        orElse: () => TrainDirection.down,
      ),
      serviceType: ServiceType.values.firstWhere(
        (e) => e.name == row.serviceType,
        orElse: () => ServiceType.slow,
      ),
      sourceStationId: row.sourceStationId,
      destinationStationId: row.destinationStationId,
      operatingDaysMask: row.operatingDaysMask,
    );
  }

  StopSchedule _mapStopRow(StopSchedulesTableData row) {
    return StopSchedule(
      tripId: row.tripId,
      stationId: row.stationId,
      stopSequence: row.stopSequence,
      arrivalMinutes: row.arrivalMinutes,
      departureMinutes: row.departureMinutes,
      platform: row.platform,
    );
  }
}
