import 'package:flutter/foundation.dart';

/// Represents an item in commuter's local journey search history.
@immutable
class JourneyHistoryEntry {
  final String id;
  final String originStationId;
  final String destinationStationId;
  final int estimatedDurationMinutes;
  final DateTime queriedAt;

  const JourneyHistoryEntry({
    required this.id,
    required this.originStationId,
    required this.destinationStationId,
    required this.estimatedDurationMinutes,
    required this.queriedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JourneyHistoryEntry &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
