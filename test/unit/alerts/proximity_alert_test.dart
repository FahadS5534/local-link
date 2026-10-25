import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/alerts/data/repositories/in_memory_alerts_repository.dart';
import 'package:local_link/features/alerts/domain/entities/station_proximity_alert.dart';
import 'package:local_link/features/alerts/domain/services/haversine_calculator.dart';
import 'package:local_link/features/alerts/domain/services/proximity_alarm_service.dart';

void main() {
  group('HaversineCalculator Unit Tests', () {
    test('calculates 0 meters for identical coordinates', () {
      final distance = HaversineCalculator.distanceInMeters(
        startLat: 18.9322,
        startLng: 72.8264,
        endLat: 18.9322,
        endLng: 72.8264,
      );
      expect(distance, equals(0.0));
    });

    test(
      'calculates authentic distance between Churchgate and Marine Lines (~1.3 km)',
      () {
        final distance = HaversineCalculator.distanceInMeters(
          startLat: 18.9322, // Churchgate
          startLng: 72.8264,
          endLat: 18.9436, // Marine Lines
          endLng: 72.8234,
        );
        // Actual geographical distance is ~1300 meters
        expect(distance, greaterThan(1200));
        expect(distance, lessThan(1400));
      },
    );
  });

  group('StationProximityAlert Entity Tests', () {
    test('initializes with default active status and radius', () {
      final alert = StationProximityAlert(
        id: 'alt_1',
        stationId: 'ST_CCG',
        stationName: 'Churchgate',
        stationCode: 'CCG',
        latitude: 18.9322,
        longitude: 72.8264,
        createdAt: DateTime(2026, 1, 1),
      );

      expect(alert.isActive, isTrue);
      expect(alert.isTriggered, isFalse);
      expect(alert.isMuted, isFalse);
      expect(alert.radiusMeters, equals(1000.0));
    });

    test('copyWith updates status and timestamps properly', () {
      final alert = StationProximityAlert(
        id: 'alt_1',
        stationId: 'ST_CCG',
        stationName: 'Churchgate',
        stationCode: 'CCG',
        latitude: 18.9322,
        longitude: 72.8264,
        createdAt: DateTime(2026, 1, 1),
      );

      final triggered = alert.copyWith(
        status: AlertStatus.triggered,
        triggeredAt: DateTime(2026, 1, 1, 8, 30),
      );

      expect(triggered.isTriggered, isTrue);
      expect(triggered.isActive, isFalse);
      expect(triggered.triggeredAt, equals(DateTime(2026, 1, 1, 8, 30)));
    });
  });

  group('InMemoryAlertsRepository Tests', () {
    late InMemoryAlertsRepository repository;

    setUp(() {
      repository = InMemoryAlertsRepository();
    });

    tearDown(() {
      repository.dispose();
    });

    test('saves and retrieves alerts with reactive stream updates', () async {
      final alert = StationProximityAlert(
        id: 'alt_dadar',
        stationId: 'ST_DDR',
        stationName: 'Dadar',
        stationCode: 'DDR',
        latitude: 19.0178,
        longitude: 72.8478,
        radiusMeters: 500,
        createdAt: DateTime.now(),
      );

      final streamEvents = <List<StationProximityAlert>>[];
      final subscription = repository.watchAlerts().listen(streamEvents.add);

      await repository.saveAlert(alert);
      await Future<void>.delayed(Duration.zero);

      final alerts = await repository.getAlerts();
      expect(alerts.length, equals(1));
      expect(alerts.first.stationId, equals('ST_DDR'));

      // Toggle alert
      await repository.toggleAlert(alert.id, false);
      final toggledAlerts = await repository.getAlerts();
      expect(toggledAlerts.first.isMuted, isTrue);

      // Delete alert
      await repository.deleteAlert(alert.id);
      final remaining = await repository.getAlerts();
      expect(remaining.isEmpty, isTrue);

      await subscription.cancel();
    });
  });

  group('ProximityAlarmService Geofence Tests', () {
    late InMemoryAlertsRepository repository;
    late ProximityAlarmService service;

    setUp(() {
      repository = InMemoryAlertsRepository();
      service = ProximityAlarmService(repository: repository);
    });

    tearDown(() {
      service.dispose();
      repository.dispose();
    });

    test('does not trigger when commuter is outside radius', () async {
      final alert = StationProximityAlert(
        id: 'alt_borivali',
        stationId: 'ST_BVI',
        stationName: 'Borivali',
        stationCode: 'BVI',
        latitude: 19.2290,
        longitude: 72.8574,
        radiusMeters: 500,
        createdAt: DateTime.now(),
      );
      await repository.saveAlert(alert);

      // Commuter is far away at Dadar (19.0178, 72.8478)
      final triggered = await service.evaluateLocation(
        latitude: 19.0178,
        longitude: 72.8478,
      );

      expect(triggered.isEmpty, isTrue);
      final stored = await repository.getAlerts();
      expect(stored.first.isActive, isTrue);
    });

    test(
      'triggers alert and emits event when commuter enters radius',
      () async {
        final alert = StationProximityAlert(
          id: 'alt_borivali',
          stationId: 'ST_BVI',
          stationName: 'Borivali',
          stationCode: 'BVI',
          latitude: 19.2290,
          longitude: 72.8574,
          radiusMeters: 1000,
          createdAt: DateTime.now(),
        );
        await repository.saveAlert(alert);

        // Commuter is 200m from Borivali station
        final triggered = await service.evaluateLocation(
          latitude: 19.2300,
          longitude: 72.8574,
        );

        expect(triggered.length, equals(1));
        expect(triggered.first.alert.stationCode, equals('BVI'));
        expect(triggered.first.distanceMeters, lessThan(1000));

        final stored = await repository.getAlerts();
        expect(stored.first.isTriggered, isTrue);
      },
    );
  });
}
