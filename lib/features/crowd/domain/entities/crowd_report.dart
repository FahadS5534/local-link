/// Category of train coach in Mumbai suburban rakes.
enum CoachType {
  secondClass,
  firstClass,
  ladies,
  divyang;

  String get displayName {
    switch (this) {
      case CoachType.secondClass:
        return 'Second Class';
      case CoachType.firstClass:
        return 'First Class';
      case CoachType.ladies:
        return 'Ladies';
      case CoachType.divyang:
        return 'Divyang (Accessible)';
    }
  }
}

/// Commuter-reported crowding density level.
enum CrowdDensity {
  low,
  medium,
  heavy,
  superDense;

  String get displayName {
    switch (this) {
      case CrowdDensity.low:
        return 'Seats Available';
      case CrowdDensity.medium:
        return 'Standing Room';
      case CrowdDensity.heavy:
        return 'Packed';
      case CrowdDensity.superDense:
        return 'Super-Dense (Boarding Difficult)';
    }
  }

  /// Numeric score for weighted averaging (1 to 4).
  int get score {
    switch (this) {
      case CrowdDensity.low:
        return 1;
      case CrowdDensity.medium:
        return 2;
      case CrowdDensity.heavy:
        return 3;
      case CrowdDensity.superDense:
        return 4;
    }
  }
}

/// Freshness categorization per ADR-007.
enum ReportFreshness {
  fresh, // 0 - 15 minutes ago
  expiring, // 15 - 30 minutes ago
  expired, // > 30 minutes ago
}

/// Represents an anonymous crowdsourced coach crowding submission.
class CoachCrowdReport {
  final String id;
  final String tripId;
  final String stationId;
  final CoachType coachType;
  final CrowdDensity crowdDensity;
  final DateTime timestamp;
  final String clientSessionHash;

  const CoachCrowdReport({
    required this.id,
    required this.tripId,
    required this.stationId,
    required this.coachType,
    required this.crowdDensity,
    required this.timestamp,
    required this.clientSessionHash,
  });

  /// Evaluates freshness decay relative to [now].
  ReportFreshness getFreshness([DateTime? now]) {
    final current = now ?? DateTime.now();
    final difference = current.difference(timestamp);

    if (difference.inSeconds <= 15 * 60) {
      return ReportFreshness.fresh;
    } else if (difference.inSeconds <= 30 * 60) {
      return ReportFreshness.expiring;
    } else {
      return ReportFreshness.expired;
    }
  }

  /// True if the report was submitted within the active 30-minute freshness TTL.
  bool isFresh([DateTime? now]) => getFreshness(now) != ReportFreshness.expired;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoachCrowdReport &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
