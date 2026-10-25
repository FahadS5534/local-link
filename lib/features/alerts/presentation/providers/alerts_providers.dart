import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/in_memory_alerts_repository.dart';
import '../../domain/entities/station_proximity_alert.dart';
import '../../domain/repositories/alerts_repository.dart';
import '../../domain/services/proximity_alarm_service.dart';

/// Provider for the proximity alarms repository.
final alertsRepositoryProvider = Provider<AlertsRepository>((ref) {
  final repo = InMemoryAlertsRepository();
  ref.onDispose(() => repo.dispose());
  return repo;
});

/// Stream provider emitting reactive list of registered proximity alerts.
final alertsStreamProvider = StreamProvider<List<StationProximityAlert>>((ref) {
  final repository = ref.watch(alertsRepositoryProvider);
  return repository.watchAlerts();
});

/// Provider for the proximity alarm evaluation service.
final proximityAlarmServiceProvider = Provider<ProximityAlarmService>((ref) {
  final repository = ref.watch(alertsRepositoryProvider);
  final service = ProximityAlarmService(repository: repository);
  ref.onDispose(() => service.dispose());
  return service;
});

/// Provider computing count of active proximity alerts.
final activeAlertsCountProvider = Provider<int>((ref) {
  final alertsAsync = ref.watch(alertsStreamProvider);
  return alertsAsync.maybeWhen(
    data: (alerts) => alerts.where((a) => a.isActive).length,
    orElse: () => 0,
  );
});
