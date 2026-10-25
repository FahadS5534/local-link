import 'package:flutter/foundation.dart';

/// Represents the status of a station proximity alarm.
enum AlertStatus { active, triggered, muted }

/// Domain entity representing a geofenced station proximity alarm.
@immutable
class StationProximityAlert {
  final String id;
  final String stationId;
  final String stationName;
  final String stationCode;
  final double latitude;
  final double longitude;
  final double radiusMeters;
  final AlertStatus status;
  final DateTime createdAt;
  final DateTime? triggeredAt;

  const StationProximityAlert({
    required this.id,
    required this.stationId,
    required this.stationName,
    required this.stationCode,
    required this.latitude,
    required this.longitude,
    this.radiusMeters = 1000.0,
    this.status = AlertStatus.active,
    required this.createdAt,
    this.triggeredAt,
  });

  bool get isActive => status == AlertStatus.active;
  bool get isTriggered => status == AlertStatus.triggered;
  bool get isMuted => status == AlertStatus.muted;

  StationProximityAlert copyWith({
    String? id,
    String? stationId,
    String? stationName,
    String? stationCode,
    double? latitude,
    double? longitude,
    double? radiusMeters,
    AlertStatus? status,
    DateTime? createdAt,
    DateTime? triggeredAt,
  }) {
    return StationProximityAlert(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      stationName: stationName ?? this.stationName,
      stationCode: stationCode ?? this.stationCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      triggeredAt: triggeredAt ?? this.triggeredAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StationProximityAlert &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          stationId == other.stationId &&
          status == other.status &&
          radiusMeters == other.radiusMeters;

  @override
  int get hashCode => id.hashCode ^ stationId.hashCode ^ status.hashCode;
}
