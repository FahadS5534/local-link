import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/map/presentation/railway_map_screen.dart';
import 'package:local_link/features/timetable/domain/entities/station.dart';
import 'package:local_link/features/timetable/presentation/providers/timetable_providers.dart';

import '../../helpers/pump_app.dart';

void main() {
  final testStations = [
    const Station(
      id: 'st_ccg',
      nameEn: 'Churchgate',
      nameMr: 'चर्चगेट',
      nameHi: 'चर्चगेट',
      code: 'CCG',
      latitude: 18.9322,
      longitude: 72.8264,
      lines: [RailwayLineId.western],
      isInterchange: false,
    ),
    const Station(
      id: 'st_ddr',
      nameEn: 'Dadar',
      nameMr: 'दादर',
      nameHi: 'दादर',
      code: 'DDR',
      latitude: 19.0178,
      longitude: 72.8478,
      lines: [RailwayLineId.western, RailwayLineId.centralMain],
      isInterchange: true,
    ),
  ];

  group('RailwayMapScreen Widget Tests', () {
    testWidgets(
      'renders map screen, OpenStreetMap disclaimer and line filter chips',
      (tester) async {
        await tester.pumpLocalizedWidget(
          const RailwayMapScreen(),
          overrides: [
            allStationsProvider.overrideWith((ref) async => testStations),
          ],
        );
        await tester.pumpAndSettle();

        // Top bar & line filter chips
        expect(find.text('All Lines'), findsOneWidget);
        expect(find.text('Western'), findsOneWidget);
        expect(find.text('Central'), findsOneWidget);
        expect(find.text('Harbour'), findsOneWidget);
        expect(find.text('Trans-Harbour'), findsOneWidget);

        // Map widget
        expect(find.byType(FlutterMap), findsOneWidget);

        // Attribution & offline ready label
        expect(
          find.textContaining('OpenStreetMap contributors'),
          findsOneWidget,
        );

        // Zoom floating action buttons
        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.byIcon(Icons.remove), findsOneWidget);
        expect(find.byIcon(Icons.my_location), findsOneWidget);
      },
    );
  });
}
