import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/alerts/data/repositories/in_memory_alerts_repository.dart';
import 'package:local_link/features/alerts/domain/entities/station_proximity_alert.dart';
import 'package:local_link/features/alerts/domain/services/proximity_alarm_service.dart';

void main() {
  late InMemoryAlertsRepository repository;
  late ProximityAlarmService alarmService;

  setUp(() {
    repository = InMemoryAlertsRepository();
    alarmService = ProximityAlarmService(repository: repository);
  });

  tearDown(() {
    alarmService.dispose();
  });

  group('ProximityAlarmService Route Sequence Progression Tests', () {
    test(
      'advances stop sequence along route and triggers alert at configured stops before destination',
      () async {
        // Journey: Churchgate (0) -> Marine Lines (1) -> Charni Road (2) -> Grant Road (3)
        // Alert set for Grant Road (ST_GTR), alert 1 stop before (at Charni Road, ST_CYR)
        final alert = StationProximityAlert(
          id: 'alert_seq_1',
          stationId: 'ST_GTR',
          stationName: 'Grant Road',
          stationCode: 'GTR',
          latitude: 18.9633,
          longitude: 72.8156,
          orderedRouteStationIds: const [
            'ST_CCG',
            'ST_MEL',
            'ST_CYR',
            'ST_GTR',
          ],
          stopsBeforeAlert: 1,
          currentStopIndex: 0,
          createdAt: DateTime.now(),
        );

        await repository.saveAlert(alert);

        final coords = {
          'ST_CCG': (lat: 18.9322, lng: 72.8264),
          'ST_MEL': (lat: 18.9438, lng: 72.8236),
          'ST_CYR': (lat: 18.9519, lng: 72.8189),
          'ST_GTR': (lat: 18.9633, lng: 72.8156),
        };

        // 1. Commuter moves to Marine Lines (ST_MEL, index 1)
        final event1 = await alarmService.evaluateRouteProgression(
          alertId: alert.id,
          stationCoordinates: coords,
          currentLat: 18.9438,
          currentLng: 72.8236,
        );

        // Remaining stops: 2, stopsBeforeAlert: 1 -> Not yet triggered
        expect(event1, isNull);

        final alertAfterMel = (await repository.getAlerts()).first;
        expect(alertAfterMel.currentStopIndex, equals(1));
        expect(alertAfterMel.remainingStops, equals(2));
        expect(alertAfterMel.isActive, isTrue);

        // 2. Commuter moves to Charni Road (ST_CYR, index 2)
        final event2 = await alarmService.evaluateRouteProgression(
          alertId: alert.id,
          stationCoordinates: coords,
          currentLat: 18.9519,
          currentLng: 72.8189,
        );

        // Remaining stops: 1, stopsBeforeAlert: 1 -> TRIGGER!
        expect(event2, isNotNull);
        expect(event2!.triggerReason, equals('SEQUENCE_THRESHOLD'));
        expect(event2.remainingStops, equals(1));

        final alertAfterCyr = (await repository.getAlerts()).first;
        expect(alertAfterCyr.isTriggered, isTrue);

        // 3. Repeated coordinate updates do NOT re-trigger (duplicate prevention)
        final eventDuplicate = await alarmService.evaluateRouteProgression(
          alertId: alert.id,
          stationCoordinates: coords,
          currentLat: 18.9519,
          currentLng: 72.8189,
        );
        expect(eventDuplicate, isNull);
      },
    );

    test(
      'manual stop progression allows commuter to advance stops in low-GPS environments',
      () async {
        final alert = StationProximityAlert(
          id: 'alert_manual_1',
          stationId: 'ST_BVI',
          stationName: 'Borivali',
          stationCode: 'BVI',
          latitude: 19.2290,
          longitude: 72.8570,
          orderedRouteStationIds: const ['ST_ADH', 'ST_KLE', 'ST_BVI'],
          stopsBeforeAlert: 1,
          currentStopIndex: 0,
          createdAt: DateTime.now(),
        );

        await repository.saveAlert(alert);

        // Advance stop 1 manually (to Kandivali)
        final triggerEvent = await alarmService.advanceStopManually(alert.id);

        expect(triggerEvent, isNotNull);
        expect(triggerEvent!.remainingStops, equals(1));
        expect(triggerEvent.alert.stationCode, equals('BVI'));
      },
    );
  });
}
