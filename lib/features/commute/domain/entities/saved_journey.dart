import 'package:flutter/foundation.dart';

/// Represents a commuter's frequently saved journey (e.g. Home, Work, College).
@immutable
class SavedJourney {
  final String id;
  final String label; // e.g. "Work", "College", "Home"
  final String originStationId;
  final String destinationStationId;
  final bool isPinned;
  final DateTime createdAt;

  const SavedJourney({
    required this.id,
    required this.label,
    required this.originStationId,
    required this.destinationStationId,
    this.isPinned = false,
    required this.createdAt,
  });

  SavedJourney copyWith({
    String? id,
    String? label,
    String? originStationId,
    String? destinationStationId,
    bool? isPinned,
    DateTime? createdAt,
  }) {
    return SavedJourney(
      id: id ?? this.id,
      label: label ?? this.label,
      originStationId: originStationId ?? this.originStationId,
      destinationStationId: destinationStationId ?? this.destinationStationId,
      isPinned: isPinned ?? this.isPinned,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedJourney &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          label == other.label &&
          originStationId == other.originStationId &&
          destinationStationId == other.destinationStationId &&
          isPinned == other.isPinned;

  @override
  int get hashCode =>
      id.hashCode ^
      label.hashCode ^
      originStationId.hashCode ^
      destinationStationId.hashCode;
}
