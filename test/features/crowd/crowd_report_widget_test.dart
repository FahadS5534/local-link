import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/crowd/data/repositories/in_memory_crowd_report_repository.dart';
import 'package:local_link/features/crowd/domain/entities/crowd_report.dart';
import 'package:local_link/features/crowd/presentation/providers/crowd_providers.dart';
import 'package:local_link/features/crowd/presentation/widgets/coach_crowding_card.dart';

import '../../helpers/pump_app.dart';

void main() {
  late InMemoryCrowdReportRepository repository;

  setUp(() {
    repository = InMemoryCrowdReportRepository();
  });

  tearDown(() {
    repository.dispose();
  });

  group('CoachCrowdingCard & Submission Widget Tests', () {
    testWidgets('renders coach crowding title, disclaimer, and report button', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(
        const CoachCrowdingCard(tripId: 'WR_90001', stationId: 'ST_CCG'),
        overrides: [
          crowdReportRepositoryProvider.overrideWithValue(repository),
        ],
      );

      expect(find.text('Coach Crowding'), findsOneWidget);
      expect(find.text('Report Crowding'), findsOneWidget);
      expect(
        find.text(
          'Crowdsourced commuter estimate • Not an official railway feed',
        ),
        findsOneWidget,
      );
    });

    testWidgets('displays active reports with freshness badges', (
      tester,
    ) async {
      final now = DateTime.now();
      repository.seedReports([
        CoachCrowdReport(
          id: 'r1',
          tripId: 'WR_90001',
          stationId: 'ST_CCG',
          coachType: CoachType.secondClass,
          crowdDensity: CrowdDensity.heavy,
          timestamp: now.subtract(const Duration(minutes: 5)),
          clientSessionHash: 'hash1',
        ),
      ]);

      await tester.pumpLocalizedWidget(
        const CoachCrowdingCard(tripId: 'WR_90001', stationId: 'ST_CCG'),
        overrides: [
          crowdReportRepositoryProvider.overrideWithValue(repository),
        ],
      );

      // Verify coach report info
      expect(find.text('Second Class: Packed'), findsOneWidget);
      expect(find.text('Fresh'), findsOneWidget);
    });

    testWidgets(
      'tapping Report Crowding opens bottom sheet and allows submission',
      (tester) async {
        await tester.pumpLocalizedWidget(
          const CoachCrowdingCard(tripId: 'WR_90001', stationId: 'ST_CCG'),
          overrides: [
            crowdReportRepositoryProvider.overrideWithValue(repository),
          ],
        );

        // Tap report button
        await tester.tap(find.text('Report Crowding'));
        await tester.pumpAndSettle();

        // Bottom sheet should be visible
        expect(find.text('Select Coach Type'), findsOneWidget);
        expect(find.text('Submit Report'), findsOneWidget);

        // Select Ladies coach
        await tester.tap(find.text('Ladies'));
        await tester.pumpAndSettle();

        // Submit
        await tester.tap(find.text('Submit Report'));
        await tester.pumpAndSettle();

        // Verify bottom sheet closed and success snackbar displayed
        expect(
          find.text('Thank you for helping fellow commuters!'),
          findsOneWidget,
        );
      },
    );
  });
}
