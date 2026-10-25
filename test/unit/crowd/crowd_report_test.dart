import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/crowd/data/repositories/in_memory_crowd_report_repository.dart';
import 'package:local_link/features/crowd/domain/entities/crowd_report.dart';

void main() {
  group('CoachCrowdReport Freshness Decay Logic (ADR-007)', () {
    final now = DateTime(2026, 10, 25, 9, 0);

    test('Report submitted 5 minutes ago is classified as Fresh', () {
      final report = CoachCrowdReport(
        id: '1',
        tripId: 'WR_90001',
        stationId: 'ST_CCG',
        coachType: CoachType.secondClass,
        crowdDensity: CrowdDensity.heavy,
        timestamp: now.subtract(const Duration(minutes: 5)),
        clientSessionHash: 'hash1',
      );

      expect(report.getFreshness(now), ReportFreshness.fresh);
      expect(report.isFresh(now), isTrue);
    });

    test('Report submitted 20 minutes ago is classified as Expiring', () {
      final report = CoachCrowdReport(
        id: '2',
        tripId: 'WR_90001',
        stationId: 'ST_CCG',
        coachType: CoachType.firstClass,
        crowdDensity: CrowdDensity.medium,
        timestamp: now.subtract(const Duration(minutes: 20)),
        clientSessionHash: 'hash2',
      );

      expect(report.getFreshness(now), ReportFreshness.expiring);
      expect(report.isFresh(now), isTrue);
    });

    test('Report submitted 35 minutes ago is classified as Expired', () {
      final report = CoachCrowdReport(
        id: '3',
        tripId: 'WR_90001',
        stationId: 'ST_CCG',
        coachType: CoachType.ladies,
        crowdDensity: CrowdDensity.superDense,
        timestamp: now.subtract(const Duration(minutes: 35)),
        clientSessionHash: 'hash3',
      );

      expect(report.getFreshness(now), ReportFreshness.expired);
      expect(report.isFresh(now), isFalse);
    });
  });

  group('InMemoryCrowdReportRepository', () {
    late InMemoryCrowdReportRepository repository;
    final now = DateTime(2026, 10, 25, 9, 0);

    setUp(() {
      repository = InMemoryCrowdReportRepository();
    });

    tearDown(() {
      repository.dispose();
    });

    test(
      'getActiveReportsForTrip excludes expired reports older than 30 mins',
      () async {
        final fresh = CoachCrowdReport(
          id: 'r1',
          tripId: 'WR_90001',
          stationId: 'ST_CCG',
          coachType: CoachType.secondClass,
          crowdDensity: CrowdDensity.medium,
          timestamp: now.subtract(const Duration(minutes: 10)),
          clientSessionHash: 'h1',
        );

        final expired = CoachCrowdReport(
          id: 'r2',
          tripId: 'WR_90001',
          stationId: 'ST_CCG',
          coachType: CoachType.ladies,
          crowdDensity: CrowdDensity.heavy,
          timestamp: now.subtract(const Duration(minutes: 45)),
          clientSessionHash: 'h2',
        );

        repository.seedReports([fresh, expired]);

        final active = await repository.getActiveReportsForTrip(
          'WR_90001',
          asOf: now,
        );
        expect(active.length, 1);
        expect(active.first.id, 'r1');
      },
    );

    test('submitReport updates active trip stream', () async {
      final expectation = expectLater(
        repository.watchActiveReportsForTrip('WR_90001', asOf: now),
        emitsInOrder([
          isEmpty, // Initial emission before report
          hasLength(1), // After submitting report
        ]),
      );

      // Allow initial stream yield to execute
      await Future<void>.delayed(const Duration(milliseconds: 20));

      await repository.submitReport(
        CoachCrowdReport(
          id: 'r3',
          tripId: 'WR_90001',
          stationId: 'ST_CCG',
          coachType: CoachType.divyang,
          crowdDensity: CrowdDensity.low,
          timestamp: now.subtract(const Duration(minutes: 2)),
          clientSessionHash: 'h3',
        ),
      );

      await expectation;
    });
  });
}
