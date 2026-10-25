import 'package:local_link/features/timetable/domain/entities/station.dart';

/// Categories of commuter-reported disruptions.
enum DisruptionType {
  delay,
  unusualCrowd,
  platformChange,
  accessibilityIssue,
  technicalHalt;

  String get displayName {
    switch (this) {
      case DisruptionType.delay:
        return 'Train Running Late';
      case DisruptionType.unusualCrowd:
        return 'Unusual Crowding';
      case DisruptionType.platformChange:
        return 'Sudden Platform Change';
      case DisruptionType.accessibilityIssue:
        return 'Elevator / Escalator Out of Order';
      case DisruptionType.technicalHalt:
        return 'Signal / Technical Halt';
    }
  }
}

/// Represents a community-submitted rail disruption report.
class DisruptionReport {
  final String id;
  final RailwayLineId lineId;
  final String? stationId;
  final DisruptionType type;
  final String description;
  final int upvotes;
  final DateTime timestamp;
  final bool isVerified;

  const DisruptionReport({
    required this.id,
    required this.lineId,
    this.stationId,
    required this.type,
    required this.description,
    this.upvotes = 1,
    required this.timestamp,
    this.isVerified = false,
  });

  /// Check if the disruption report is still active (under 2 hours old).
  bool isActive([DateTime? now]) {
    final current = now ?? DateTime.now();
    return current.difference(timestamp).inMinutes < 120;
  }

  DisruptionReport copyWith({
    String? id,
    RailwayLineId? lineId,
    String? stationId,
    DisruptionType? type,
    String? description,
    int? upvotes,
    DateTime? timestamp,
    bool? isVerified,
  }) {
    return DisruptionReport(
      id: id ?? this.id,
      lineId: lineId ?? this.lineId,
      stationId: stationId ?? this.stationId,
      type: type ?? this.type,
      description: description ?? this.description,
      upvotes: upvotes ?? this.upvotes,
      timestamp: timestamp ?? this.timestamp,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
