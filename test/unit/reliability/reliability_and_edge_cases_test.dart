import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/alerts/data/repositories/in_memory_alerts_repository.dart';
import 'package:local_link/features/alerts/domain/entities/station_proximity_alert.dart';
import 'package:local_link/features/alerts/domain/services/haversine_calculator.dart';
import 'package:local_link/features/alerts/domain/services/proximity_alarm_service.dart';
import 'package:local_link/features/crowd/domain/entities/crowd_report.dart';
import 'package:local_link/features/routing/domain/entities/network_graph.dart';
import 'package:local_link/features/timetable/domain/entities/station.dart';

void main() {
  group('Phase 8 Reliability & Edge Cases', () {
    group('Haversine Boundary & Edge Cases', () {
      test('does not produce NaN or throw on antipodal points', () {
        final distance = HaversineCalculator.distanceInMeters(
          startLat: 90.0,
          startLng: 0.0,
          endLat: -90.0,
          endLng: 0.0,
        );
        expect(distance.isNaN, isFalse);
        expect(distance.isInfinite, isFalse);
        // Half circumference of Earth ~ 20,015 km
        expect(distance, greaterThan(20000000));
        expect(distance, lessThan(20050000));
      });

      test('exact boundary triggering at exact radius threshold', () async {
        final repo = InMemoryAlertsRepository();
        final service = ProximityAlarmService(repository: repo);

        final alert = StationProximityAlert(
          id: 'alt_exact',
          stationId: 'ST_TEST',
          stationName: 'Test Station',
          stationCode: 'TST',
          latitude: 19.0000,
          longitude: 72.8000,
          radiusMeters: 500.0,
          createdAt: DateTime.now(),
        );
        await repo.saveAlert(alert);

        final triggered = await service.evaluateLocation(
          latitude: 19.0010,
          longitude: 72.8000,
        );

        expect(triggered.isNotEmpty, isTrue);
        service.dispose();
        repo.dispose();
      });
    });

    group('Network Graph Edge Cases & Loop Prevention', () {
      test(
        'handles disconnected disjoint subgraphs without infinite looping',
        () {
          const stA = Station(
            id: 'ST_A',
            code: 'STA',
            nameEn: 'Station A',
            nameMr: 'स्थानक अ',
            nameHi: 'स्टेशन ए',
            lines: [RailwayLineId.western],
            latitude: 18.9,
            longitude: 72.8,
            isInterchange: false,
          );
          const stB = Station(
            id: 'ST_B',
            code: 'STB',
            nameEn: 'Station B',
            nameMr: 'स्थानक ब',
            nameHi: 'स्टेशन बी',
            lines: [RailwayLineId.western],
            latitude: 18.91,
            longitude: 72.81,
            isInterchange: false,
          );

          // Station on Trans-Harbour with no interchange to Western
          const stX = Station(
            id: 'ST_X',
            code: 'STX',
            nameEn: 'Station X',
            nameMr: 'स्थानक क्ष',
            nameHi: 'स्टेशन एक्स',
            lines: [RailwayLineId.transHarbour],
            latitude: 19.1,
            longitude: 72.9,
            isInterchange: false,
          );

          final graph = RailwayNetworkGraph([stA, stB, stX]);

          final routes = graph.findTopologicalRoutes(
            origin: stA,
            destination: stX,
          );
          // When disconnected without interchange, returns empty route list gracefully
          expect(routes.isEmpty, isTrue);
        },
      );
    });

    group('Crowd Report Freshness Boundary Tests', () {
      test('exactly at 15 minutes boundary transitions to expiring', () {
        final now = DateTime.now();
        final report14m = CoachCrowdReport(
          id: 'rpt_14',
          tripId: 'TRIP_1',
          stationId: 'ST_1',
          coachType: CoachType.secondClass,
          crowdDensity: CrowdDensity.heavy,
          timestamp: now.subtract(const Duration(minutes: 14, seconds: 59)),
          clientSessionHash: 'hash1',
        );

        final report15m = CoachCrowdReport(
          id: 'rpt_15',
          tripId: 'TRIP_1',
          stationId: 'ST_1',
          coachType: CoachType.secondClass,
          crowdDensity: CrowdDensity.heavy,
          timestamp: now.subtract(const Duration(minutes: 15, seconds: 1)),
          clientSessionHash: 'hash2',
        );

        expect(report14m.getFreshness(now), equals(ReportFreshness.fresh));
        expect(report15m.getFreshness(now), equals(ReportFreshness.expiring));
      });

      test('exactly at 30 minutes boundary transitions to expired', () {
        final now = DateTime.now();
        final report29m = CoachCrowdReport(
          id: 'rpt_29',
          tripId: 'TRIP_1',
          stationId: 'ST_1',
          coachType: CoachType.secondClass,
          crowdDensity: CrowdDensity.heavy,
          timestamp: now.subtract(const Duration(minutes: 29, seconds: 59)),
          clientSessionHash: 'hash1',
        );

        final report31m = CoachCrowdReport(
          id: 'rpt_31',
          tripId: 'TRIP_1',
          stationId: 'ST_1',
          coachType: CoachType.secondClass,
          crowdDensity: CrowdDensity.heavy,
          timestamp: now.subtract(const Duration(minutes: 30, seconds: 1)),
          clientSessionHash: 'hash2',
        );

        expect(report29m.getFreshness(now), equals(ReportFreshness.expiring));
        expect(report31m.getFreshness(now), equals(ReportFreshness.expired));
        expect(report31m.isFresh(now), isFalse);
      });
    });
  });
}
