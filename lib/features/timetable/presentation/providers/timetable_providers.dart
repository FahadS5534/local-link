import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/drift_timetable_repository.dart';
import '../../domain/entities/route_plan.dart';
import '../../domain/entities/station.dart';
import '../../domain/repositories/timetable_repository.dart';

/// Provides the active [AppDatabase] instance.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase(
    LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'locallink_timetable.sqlite'));
      return NativeDatabase(file);
    }),
  );

  ref.onDispose(() => db.close());
  return db;
});

/// Provides the [TimetableRepository] backed by Drift SQLite.
final timetableRepositoryProvider = Provider<TimetableRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftTimetableRepository(db: db);
});

/// Fetches all Mumbai Suburban stations.
final allStationsProvider = FutureProvider<List<Station>>((ref) async {
  final repo = ref.watch(timetableRepositoryProvider);
  await repo.initializeSeedData();
  return repo.getAllStations();
});

/// Searches stations by query string (case-insensitive across English, Marathi, Hindi).
final stationSearchProvider = FutureProvider.family<List<Station>, String>((
  ref,
  query,
) async {
  final repo = ref.watch(timetableRepositoryProvider);
  await repo.initializeSeedData();
  return repo.searchStations(query);
});

/// Queries direct train journeys between two stations.
final directRoutesProvider =
    FutureProvider.family<
      List<RoutePlan>,
      ({String originId, String destinationId, int? afterMinutes})
    >((ref, params) async {
      final repo = ref.watch(timetableRepositoryProvider);
      await repo.initializeSeedData();
      return repo.findDirectRoutes(
        originId: params.originId,
        destinationId: params.destinationId,
        afterMinutes: params.afterMinutes,
      );
    });
