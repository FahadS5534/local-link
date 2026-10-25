import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:local_link/features/timetable/domain/entities/station.dart';
import 'package:local_link/features/timetable/presentation/providers/timetable_providers.dart';
import '../../data/repositories/drift_disruption_repository.dart';
import '../../data/repositories/in_memory_crowd_report_repository.dart';
import '../../domain/entities/crowd_report.dart';
import '../../domain/entities/disruption_report.dart';
import '../../domain/entities/service_advisory.dart';
import '../../domain/repositories/crowd_report_repository.dart';
import '../../domain/repositories/disruption_repository.dart';

/// Provider for crowd reporting repository.
final crowdReportRepositoryProvider = Provider<CrowdReportRepository>((ref) {
  final repo = InMemoryCrowdReportRepository();
  ref.onDispose(repo.dispose);
  return repo;
});

/// Stream provider for live crowd reports for a specific train trip.
final tripCrowdReportsProvider =
    StreamProvider.family<List<CoachCrowdReport>, String>((ref, tripId) {
      final repository = ref.watch(crowdReportRepositoryProvider);
      return repository.watchActiveReportsForTrip(tripId);
    });

/// Provider for community disruption & service advisory repository.
final disruptionRepositoryProvider = Provider<DisruptionRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final repo = DriftDisruptionRepository(db);
  ref.onDispose(repo.dispose);
  return repo;
});

/// Stream of active commuter disruption reports.
final activeDisruptionsProvider =
    StreamProvider.family<List<DisruptionReport>, RailwayLineId?>((
      ref,
      lineId,
    ) {
      final repo = ref.watch(disruptionRepositoryProvider);
      return repo.watchActiveDisruptions(lineId: lineId);
    });

/// Future provider for active railway service advisories (e.g. Mega Blocks).
final activeAdvisoriesProvider = FutureProvider<List<ServiceAdvisory>>((ref) {
  final repo = ref.watch(disruptionRepositoryProvider);
  return repo.getActiveAdvisories();
});
