import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/alerts/data/repositories/in_memory_alerts_repository.dart';
import 'package:local_link/features/alerts/domain/entities/station_proximity_alert.dart';
import 'package:local_link/features/alerts/presentation/alerts_screen.dart';
import 'package:local_link/features/alerts/presentation/providers/alerts_providers.dart';
import 'package:local_link/features/alerts/presentation/widgets/set_alert_sheet.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('AlertsScreen Widget Tests', () {
    late InMemoryAlertsRepository repository;

    setUp(() {
      repository = InMemoryAlertsRepository();
    });

    tearDown(() {
      repository.dispose();
    });

    testWidgets('renders empty state when no alerts exist', (tester) async {
      await tester.pumpLocalizedWidget(
        const AlertsScreen(),
        overrides: [alertsRepositoryProvider.overrideWithValue(repository)],
      );

      expect(find.text('No active alarms'), findsOneWidget);
      expect(find.text('How Proximity Alarms Work'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('renders alert card when active alert is saved', (
      tester,
    ) async {
      final alert = StationProximityAlert(
        id: 'alt_ccg',
        stationId: 'ST_CCG',
        stationName: 'Churchgate',
        stationCode: 'CCG',
        latitude: 18.9322,
        longitude: 72.8264,
        radiusMeters: 1000,
        createdAt: DateTime.now(),
      );
      await repository.saveAlert(alert);

      await tester.pumpLocalizedWidget(
        const AlertsScreen(),
        overrides: [alertsRepositoryProvider.overrideWithValue(repository)],
      );

      expect(find.text('Churchgate'), findsOneWidget);
      expect(find.text('CCG'), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);
      expect(find.text('1 km'), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
      expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    });

    testWidgets('toggling switch updates alert status', (tester) async {
      final alert = StationProximityAlert(
        id: 'alt_ccg',
        stationId: 'ST_CCG',
        stationName: 'Churchgate',
        stationCode: 'CCG',
        latitude: 18.9322,
        longitude: 72.8264,
        radiusMeters: 1000,
        createdAt: DateTime.now(),
      );
      await repository.saveAlert(alert);

      await tester.pumpLocalizedWidget(
        const AlertsScreen(),
        overrides: [alertsRepositoryProvider.overrideWithValue(repository)],
      );

      // Tap the switch to toggle to muted
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      final stored = await repository.getAlerts();
      expect(stored.first.isMuted, isTrue);
      expect(find.text('Muted'), findsOneWidget);
    });

    testWidgets('tapping delete icon removes alert', (tester) async {
      final alert = StationProximityAlert(
        id: 'alt_ccg',
        stationId: 'ST_CCG',
        stationName: 'Churchgate',
        stationCode: 'CCG',
        latitude: 18.9322,
        longitude: 72.8264,
        radiusMeters: 1000,
        createdAt: DateTime.now(),
      );
      await repository.saveAlert(alert);

      await tester.pumpLocalizedWidget(
        const AlertsScreen(),
        overrides: [alertsRepositoryProvider.overrideWithValue(repository)],
      );

      // Tap delete icon
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      final stored = await repository.getAlerts();
      expect(stored.isEmpty, isTrue);
      expect(find.text('No active alarms'), findsOneWidget);
    });

    testWidgets('tapping FAB opens SetAlertSheet', (tester) async {
      await tester.pumpLocalizedWidget(
        const AlertsScreen(),
        overrides: [alertsRepositoryProvider.overrideWithValue(repository)],
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(SetAlertSheet), findsOneWidget);
      expect(find.text('Set Station Alarm'), findsOneWidget);
      expect(find.text('500 meters'), findsOneWidget);
      expect(find.text('1 kilometer'), findsOneWidget);
      expect(find.text('2 kilometers'), findsOneWidget);
    });
  });
}
