import 'dart:async';
import '../entities/station_proximity_alert.dart';
import '../repositories/alerts_repository.dart';
import 'haversine_calculator.dart';

/// Event payload emitted when a commuter arrives within a station's alert radius.
class ProximityAlarmTriggerEvent {
  final StationProximityAlert alert;
  final double distanceMeters;
  final DateTime timestamp;

  const ProximityAlarmTriggerEvent({
    required this.alert,
    required this.distanceMeters,
    required this.timestamp,
  });
}

/// Service that monitors commuter location against active station proximity alerts.
class ProximityAlarmService {
  final AlertsRepository _repository;
  final _triggerController =
      StreamController<ProximityAlarmTriggerEvent>.broadcast();

  ProximityAlarmService({required AlertsRepository repository})
    : _repository = repository;

  /// Stream of alarm trigger events emitted when commuter enters a geofence.
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
          timestamp: DateTime.now(),
        );
        _triggerController.add(event);
        triggeredList.add(event);
      }
    }

    return triggeredList;
  }

  void dispose() {
    _triggerController.close();
  }
}
