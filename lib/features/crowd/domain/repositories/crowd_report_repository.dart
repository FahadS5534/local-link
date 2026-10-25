import '../entities/crowd_report.dart';

/// Contract for submitting and querying crowdsourced coach density reports.
abstract interface class CrowdReportRepository {
  /// Submits a new crowding observation.
  Future<void> submitReport(CoachCrowdReport report);

  /// Fetches all active non-expired reports for a specific scheduled trip.
  Future<List<CoachCrowdReport>> getActiveReportsForTrip(
    String tripId, {
    DateTime? asOf,
  });

  /// Subscribes to live crowd reports for a specific trip.
  Stream<List<CoachCrowdReport>> watchActiveReportsForTrip(
    String tripId, {
    DateTime? asOf,
  });
}
