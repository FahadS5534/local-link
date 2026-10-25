import '../entities/station_proximity_alert.dart';

/// Abstract repository managing persistence and reactive state of station proximity alarms.
abstract class AlertsRepository {
  /// Fetches all registered proximity alerts.
  Future<List<StationProximityAlert>> getAlerts();

  /// Emits a stream of registered proximity alerts whenever state changes.
  Stream<List<StationProximityAlert>> watchAlerts();

  /// Saves a new or updated station proximity alert.
  Future<void> saveAlert(StationProximityAlert alert);

  /// Toggles an alert between active and muted.
  Future<void> toggleAlert(String id, bool active);

  /// Permanently removes an alert by its ID.
  Future<void> deleteAlert(String id);

  /// Marks an alert as triggered when the commuter enters its geofence radius.
  Future<void> markTriggered(String id);

  /// Disposes internal resources if applicable.
  void dispose();
}
