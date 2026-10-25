import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/search/presentation/search_screen.dart';
import 'package:local_link/features/timetable/data/database/app_database.dart';
import 'package:local_link/features/timetable/data/datasources/timetable_parser.dart';
import 'package:local_link/features/timetable/data/repositories/drift_timetable_repository.dart';
import 'package:local_link/features/timetable/presentation/providers/timetable_providers.dart';

import '../../helpers/pump_app.dart';

void main() {
  late AppDatabase db;
  late DriftTimetableRepository repository;
  const parser = TimetableParser();

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftTimetableRepository(db: db);

    final stationsRaw = File(
      'assets/data/mumbai_stations.json',
    ).readAsStringSync();
    final stations = parser.parseStationsJson(stationsRaw);
    final stationMap = {for (final s in stations) s.id: s};

    final tripsRaw = File('assets/data/mumbai_trips.json').readAsStringSync();
    final trips = parser.parseTripsJson(tripsRaw, stationMap);

    await db.seedDatabase(stations: stations, tripsWithStops: trips);
  });

  tearDown(() async {
    await db.close();
  });

  group('SearchScreen Flow Widget Tests', () {
    testWidgets('renders origin, destination, and swap button', (tester) async {
      await tester.pumpLocalizedWidget(
        const SearchScreen(),
        overrides: [timetableRepositoryProvider.overrideWithValue(repository)],
      );

      expect(find.text('Find Trains'), findsOneWidget);
      expect(find.byIcon(Icons.swap_vert), findsOneWidget);
      expect(find.text('Search Routes'), findsOneWidget);
    });

    testWidgets('swapping stations interchanges origin and destination', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(
        const SearchScreen(),
        overrides: [timetableRepositoryProvider.overrideWithValue(repository)],
      );

      final cardFinder = find.byType(Card);

      // Initial: Churchgate (CCG) -> Borivali (BVI) inside selection card
      expect(
        find.descendant(
          of: cardFinder,
          matching: find.text('Churchgate (CCG)'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(of: cardFinder, matching: find.text('Borivali (BVI)')),
        findsOneWidget,
      );

      // Tap swap button
      await tester.tap(find.byIcon(Icons.swap_vert));
      await tester.pumpAndSettle();

      // After swap: Borivali is first, Churchgate is second
      expect(
        find.descendant(of: cardFinder, matching: find.text('Borivali (BVI)')),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cardFinder,
          matching: find.text('Churchgate (CCG)'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('tapping a major junction chip updates destination station', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(
        const SearchScreen(),
        overrides: [timetableRepositoryProvider.overrideWithValue(repository)],
      );

      final cardFinder = find.byType(Card);

      // Tap Dadar junction ActionChip
      await tester.tap(find.widgetWithText(ActionChip, 'Dadar (DDR)'));
      await tester.pumpAndSettle();

      // Destination in selection card should now be Dadar (DDR)
      expect(
        find.descendant(of: cardFinder, matching: find.text('Dadar (DDR)')),
        findsOneWidget,
      );
    });

    testWidgets('tapping search button pushes timetable results', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(
        const SearchScreen(),
        overrides: [timetableRepositoryProvider.overrideWithValue(repository)],
      );

      // Tap Search Routes
      await tester.tap(find.text('Search Routes'));
      await tester.pumpAndSettle();

      // Should show TimetableResultsScreen with route title
      expect(find.text('CCG to BVI'), findsOneWidget);
    });
  });
}
