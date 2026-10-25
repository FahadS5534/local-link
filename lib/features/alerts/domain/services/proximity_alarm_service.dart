import 'dart:async';
import '../entities/station_proximity_alert.dart';
import '../repositories/alerts_repository.dart';
import 'haversine_calculator.dart';

/// Event payload emitted when a commuter arrives within a station's alert radius or threshold stop.
class ProximityAlarmTriggerEvent {
  final StationProximityAlert alert;
  final double distanceMeters;
  final int remainingStops;
  final DateTime timestamp;
  final String triggerReason; // 'GEOFENCE' or 'SEQUENCE_THRESHOLD'

  const ProximityAlarmTriggerEvent({
    required this.alert,
    required this.distanceMeters,
    this.remainingStops = 0,
    required this.timestamp,
    this.triggerReason = 'GEOFENCE',
  });
}

/// Service that monitors commuter location against active station proximity alerts,
/// supporting both physical Haversine geofences and journey route sequence progression.
class ProximityAlarmService {
  final AlertsRepository _repository;
  final _triggerController =
      StreamController<ProximityAlarmTriggerEvent>.broadcast();

  // Threshold for considering a station "entered/passed" along the line (500 meters)
  static const double stationArrivalHysteresisMeters = 500.0;

  ProximityAlarmService({required AlertsRepository repository})
    : _repository = repository;

  /// Stream of alarm trigger events emitted when commuter enters a geofence or reaches sequence threshold.
  Stream<ProximityAlarmTriggerEvent> get triggerEvents =>
      _triggerController.stream;

  /// Evaluates commuter coordinate against all active alerts.
  ///
  /// Returns a list of triggered alerts for this coordinate update.
  Future<List<ProximityAlarmTriggerEvent>> evaluateLocation({
    required double latitude,
    required double longitude,
  }) async {
    final alerts = await _repository.getAlerts();
    final activeAlerts = alerts.where((a) => a.isActive).toList();
    final triggeredList = <ProximityAlarmTriggerEvent>[];

    for (final alert in activeAlerts) {
      final distance = HaversineCalculator.distanceInMeters(
        startLat: latitude,
        startLng: longitude,
        endLat: alert.latitude,
        endLng: alert.longitude,
      );

      if (distance <= alert.radiusMeters) {
        await _repository.markTriggered(alert.id);
        final event = ProximityAlarmTriggerEvent(
          alert: alert,
          distanceMeters: distance,
          remainingStops: alert.remainingStops,
          timestamp: DateTime.now(),
          triggerReason: 'GEOFENCE',
        );
        _triggerController.add(event);
        triggeredList.add(event);
      }
    }

    return triggeredList;
  }

  /// Journey-aware sequence progression evaluation.
  ///
  /// Tracks progression through [alert.orderedRouteStationIds], preventing false alarms from
  /// parallel tracks or closely spaced suburban stations.
  Future<ProximityAlarmTriggerEvent?> evaluateRouteProgression({
    required String alertId,
    required Map<String, ({double lat, double lng})> stationCoordinates,
    required double currentLat,
    required double currentLng,
  }) async {
    final alerts = await _repository.getAlerts();
    final alert = alerts.firstWhere(
      (a) => a.id == alertId,
      orElse: () => throw Exception('Alert $alertId not found'),
    );

    if (!alert.isActive || !alert.hasRouteSequence) {
      return null;
    }

    final sequence = alert.orderedRouteStationIds;
    final currentIndex = alert.currentStopIndex;

    // Check next station in sequence
    if (currentIndex + 1 < sequence.length) {
      final nextStationId = sequence[currentIndex + 1];
      final nextCoords = stationCoordinates[nextStationId];

      if (nextCoords != null) {
        final dist = HaversineCalculator.distanceInMeters(
          startLat: currentLat,
          startLng: currentLng,
          endLat: nextCoords.lat,
          endLng: nextCoords.lng,
        );

        // Commuter has approached within station radius -> Advance stop progression
        if (dist <= stationArrivalHysteresisMeters) {
          final updatedAlert = alert.copyWith(
            currentStopIndex: currentIndex + 1,
          );
          await _repository.saveAlert(updatedAlert);

          // Check if we hit the user's configured stops-before-alert trigger
          if (updatedAlert.remainingStops <= updatedAlert.stopsBeforeAlert) {
            await _repository.markTriggered(updatedAlert.id);
            final event = ProximityAlarmTriggerEvent(
              alert: updatedAlert,
              distanceMeters: dist,
              remainingStops: updatedAlert.remainingStops,
              timestamp: DateTime.now(),
              triggerReason: 'SEQUENCE_THRESHOLD',
            );
            _triggerController.add(event);
            return event;
          }
        }
      }
    }

    return null;
  }

  /// Commuter manual station progression override (useful in low-GPS underground tunnels).
  Future<ProximityAlarmTriggerEvent?> advanceStopManually(
    String alertId,
  ) async {
    final alerts = await _repository.getAlerts();
    final alert = alerts.firstWhere(
      (a) => a.id == alertId,
      orElse: () => throw Exception('Alert $alertId not found'),
    );

    if (!alert.isActive || !alert.hasRouteSequence) return null;

    final updatedAlert = alert.copyWith(
      currentStopIndex: alert.currentStopIndex + 1,
    );
    await _repository.saveAlert(updatedAlert);

    if (updatedAlert.remainingStops <= updatedAlert.stopsBeforeAlert) {
      await _repository.markTriggered(updatedAlert.id);
      final event = ProximityAlarmTriggerEvent(
        alert: updatedAlert,
        distanceMeters: 0,
        remainingStops: updatedAlert.remainingStops,
        timestamp: DateTime.now(),
        triggerReason: 'SEQUENCE_THRESHOLD',
      );
      _triggerController.add(event);
      return event;
    }

    return null;
  }

  void dispose() {
    _triggerController.close();
  }
}
