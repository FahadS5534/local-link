import 'dart:async';
import '../../domain/entities/station_proximity_alert.dart';
import '../../domain/repositories/alerts_repository.dart';

/// In-memory implementation of [AlertsRepository] with reactive stream broadcasting.
class InMemoryAlertsRepository implements AlertsRepository {
  final Map<String, StationProximityAlert> _alerts = {};
  final StreamController<List<StationProximityAlert>> _controller =
      StreamController<List<StationProximityAlert>>.broadcast();

  InMemoryAlertsRepository([List<StationProximityAlert>? initialAlerts]) {
    if (initialAlerts != null) {
      for (final alert in initialAlerts) {
        _alerts[alert.id] = alert;
      }
    }
  }

  void _notify() {
    if (!_controller.isClosed) {
      final list = _alerts.values.toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _controller.add(List.unmodifiable(list));
    }
  }

  @override
  Future<List<StationProximityAlert>> getAlerts() async {
    final list = _alerts.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return List.unmodifiable(list);
  }

  @override
  Stream<List<StationProximityAlert>> watchAlerts() async* {
    // Yield current snapshot immediately upon subscription
    final list = _alerts.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    yield List.unmodifiable(list);
    yield* _controller.stream;
  }

  @override
  Future<void> saveAlert(StationProximityAlert alert) async {
    _alerts[alert.id] = alert;
    _notify();
  }

  @override
  Future<void> toggleAlert(String id, bool active) async {
    final existing = _alerts[id];
    if (existing != null) {
      _alerts[id] = existing.copyWith(
        status: active ? AlertStatus.active : AlertStatus.muted,
      );
      _notify();
    }
  }

  @override
  Future<void> deleteAlert(String id) async {
    _alerts.remove(id);
    _notify();
  }

  @override
  Future<void> markTriggered(String id) async {
    final existing = _alerts[id];
    if (existing != null) {
      _alerts[id] = existing.copyWith(
        status: AlertStatus.triggered,
        triggeredAt: DateTime.now(),
      );
      _notify();
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
