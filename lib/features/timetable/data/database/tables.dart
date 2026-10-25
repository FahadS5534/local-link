import 'package:drift/drift.dart';

/// Relational table definition for suburban stations.
class StationsTable extends Table {
  @override
  String get tableName => 'stations';

  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameHi => text()();
  TextColumn get nameMr => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get linesJson => text()();
  BoolColumn get isInterchange =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Relational table definition for train trips.
class TripsTable extends Table {
  @override
  String get tableName => 'trips';

  TextColumn get id => text()();
  TextColumn get trainNumber => text()();
  TextColumn get lineId => text()();
  TextColumn get direction => text()();
  TextColumn get serviceType => text()();
  TextColumn get sourceStationId => text()();
  TextColumn get destinationStationId => text()();
  IntColumn get operatingDaysMask =>
      integer().withDefault(const Constant(127))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Relational table definition for individual stop schedules with indexed departure times.
class StopSchedulesTable extends Table {
  @override
  String get tableName => 'stop_schedules';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get tripId => text()();
  TextColumn get stationId => text()();
  IntColumn get stopSequence => integer()();
  IntColumn get arrivalMinutes => integer()();
  IntColumn get departureMinutes => integer()();
  TextColumn get platform => text().nullable()();
}

/// Metadata key-value table for version tracking.
class DatasetMetadataTable extends Table {
  @override
  String get tableName => 'dataset_metadata';

  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
