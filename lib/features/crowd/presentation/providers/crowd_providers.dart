import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/in_memory_crowd_report_repository.dart';
import '../../domain/entities/crowd_report.dart';
import '../../domain/repositories/crowd_report_repository.dart';

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
