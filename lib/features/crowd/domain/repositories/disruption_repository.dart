import 'package:local_link/features/timetable/domain/entities/station.dart';
import '../entities/disruption_report.dart';
import '../entities/service_advisory.dart';

/// Contract for managing community disruption reports and verified service advisories.
abstract class DisruptionRepository {
  /// Fetches currently active commuter-reported disruptions.
  Future<List<DisruptionReport>> getActiveDisruptions({
    RailwayLineId? lineId,
    DateTime? asOf,
  });

  /// Watches currently active commuter-reported disruptions reactively.
  Stream<List<DisruptionReport>> watchActiveDisruptions({
    RailwayLineId? lineId,
  });

  /// Submits a new commuter disruption report.
  Future<void> submitDisruption(DisruptionReport report);

  /// Corroborates an existing disruption report (upvote).
  Future<void> upvoteDisruption(String id);

  /// Fetches currently effective railway service advisories (e.g. Mega Blocks).
  Future<List<ServiceAdvisory>> getActiveAdvisories({
    String? lineId,
    DateTime? asOf,
  });

  /// Stores verified service advisories locally in Drift SQLite.
  Future<void> saveAdvisories(List<ServiceAdvisory> advisories);
}
