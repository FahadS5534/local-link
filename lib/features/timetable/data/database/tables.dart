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

/// Commuter saved journeys (e.g. Home, Work, College).
class SavedJourneysTable extends Table {
  @override
  String get tableName => 'saved_journeys';

  TextColumn get id => text()();
  TextColumn get label => text()();
  TextColumn get originStationId => text()();
  TextColumn get destinationStationId => text()();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Commuter journey search history and commute statistics.
class JourneyHistoryTable extends Table {
  @override
  String get tableName => 'journey_history';

  TextColumn get id => text()();
  TextColumn get originStationId => text()();
  TextColumn get destinationStationId => text()();
  IntColumn get estimatedDurationMinutes => integer()();
  DateTimeColumn get queriedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local cached railway service advisories and disruption notices.
class ServiceAdvisoriesTable extends Table {
  @override
  String get tableName => 'service_advisories';

  TextColumn get id => text()();
  TextColumn get lineId => text()();
  TextColumn get titleEn => text()();
  TextColumn get titleMr => text()();
  TextColumn get titleHi => text()();
  TextColumn get descriptionEn => text()();
  TextColumn get descriptionMr => text()();
  TextColumn get descriptionHi => text()();
  TextColumn get severity => text()();
  DateTimeColumn get effectiveFrom => dateTime()();
  DateTimeColumn get effectiveUntil => dateTime()();
  BoolColumn get isVerified => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Timetable synchronization audit log and version manifests.
class SyncHistoryTable extends Table {
  @override
  String get tableName => 'sync_history';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get datasetVersion => text()();
  TextColumn get checksum => text()();
  TextColumn get status => text()();
  DateTimeColumn get syncedAt => dateTime()();
}
