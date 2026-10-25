import 'dart:async';

import '../../domain/entities/crowd_report.dart';
import '../../domain/repositories/crowd_report_repository.dart';

/// In-memory implementation of CrowdReportRepository with automatic 30-minute freshness decay.
class InMemoryCrowdReportRepository implements CrowdReportRepository {
  final List<CoachCrowdReport> _reports = [];
  final _controller = StreamController<void>.broadcast();

  @override
  Future<void> submitReport(CoachCrowdReport report) async {
    _reports.add(report);
    _controller.add(null);
  }

  @override
  Future<List<CoachCrowdReport>> getActiveReportsForTrip(
    String tripId, {
    DateTime? asOf,
  }) async {
    final now = asOf ?? DateTime.now();
    return _reports.where((r) => r.tripId == tripId && r.isFresh(now)).toList();
  }

  @override
  Stream<List<CoachCrowdReport>> watchActiveReportsForTrip(
    String tripId, {
    DateTime? asOf,
  }) async* {
    yield await getActiveReportsForTrip(tripId, asOf: asOf);
    await for (final _ in _controller.stream) {
      yield await getActiveReportsForTrip(tripId, asOf: asOf);
    }
  }

  /// Helper for test fixtures to populate initial reports.
  void seedReports(List<CoachCrowdReport> reports) {
    _reports.addAll(reports);
    _controller.add(null);
  }

  void dispose() {
    _controller.close();
  }
}
