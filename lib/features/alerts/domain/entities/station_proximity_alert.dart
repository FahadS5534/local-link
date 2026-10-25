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
  final List<String> orderedRouteStationIds;
  final int stopsBeforeAlert;
  final int currentStopIndex;
  final String? destinationStationId;

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
    this.orderedRouteStationIds = const [],
    this.stopsBeforeAlert = 1,
    this.currentStopIndex = 0,
    this.destinationStationId,
  });

  bool get isActive => status == AlertStatus.active;
  bool get isTriggered => status == AlertStatus.triggered;
  bool get isMuted => status == AlertStatus.muted;

  /// Returns true if this alert is sequence-aware with an active ordered station list.
  bool get hasRouteSequence => orderedRouteStationIds.length > 1;

  /// Remaining stops before arriving at destination.
  int get remainingStops {
    if (!hasRouteSequence) return 0;
    final total = orderedRouteStationIds.length;
    final remaining = (total - 1) - currentStopIndex;
    return remaining > 0 ? remaining : 0;
  }

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
    List<String>? orderedRouteStationIds,
    int? stopsBeforeAlert,
    int? currentStopIndex,
    String? destinationStationId,
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
      orderedRouteStationIds:
          orderedRouteStationIds ?? this.orderedRouteStationIds,
      stopsBeforeAlert: stopsBeforeAlert ?? this.stopsBeforeAlert,
      currentStopIndex: currentStopIndex ?? this.currentStopIndex,
      destinationStationId: destinationStationId ?? this.destinationStationId,
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
