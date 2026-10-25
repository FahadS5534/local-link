import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/timetable/data/database/app_database.dart';
import 'package:local_link/features/timetable/data/datasources/timetable_parser.dart';
import 'package:local_link/features/timetable/data/repositories/drift_timetable_repository.dart';
import 'package:local_link/features/timetable/domain/entities/station.dart';
import 'package:local_link/features/timetable/presentation/providers/timetable_providers.dart';
import 'package:local_link/features/timetable/presentation/screens/timetable_results_screen.dart';

import '../../helpers/pump_app.dart';

void main() {
  late AppDatabase db;
  late DriftTimetableRepository repository;
  late Station churchgate;
  late Station borivali;
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

    churchgate = stations.firstWhere((s) => s.code == 'CCG');
    borivali = stations.firstWhere((s) => s.code == 'BVI');
  });

  tearDown(() async {
    await db.close();
  });

  group('TimetableResultsScreen Widget Tests', () {
    testWidgets('renders route cards with fast/slow chips and duration', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(
        TimetableResultsScreen(origin: churchgate, destination: borivali),
        overrides: [timetableRepositoryProvider.overrideWithValue(repository)],
      );

      expect(find.text('CCG to BVI'), findsOneWidget);
      expect(find.text('FAST'), findsWidgets);
      expect(find.text('SLOW'), findsWidgets);
      expect(find.text('46 min'), findsOneWidget);
    });

    testWidgets('tapping View All Stops expands intermediate stop list', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(
        TimetableResultsScreen(origin: churchgate, destination: borivali),
        overrides: [timetableRepositoryProvider.overrideWithValue(repository)],
      );

      expect(find.text('View All Stops'), findsWidgets);

      // Tap the first View All Stops button
      await tester.tap(find.text('View All Stops').first);
      await tester.pumpAndSettle();

      // Now should show Hide Stops
      expect(find.text('Hide Stops'), findsOneWidget);
    });

    testWidgets(
      'switching to Marathi renders Devanagari route headers and badges',
      (tester) async {
        await tester.pumpLocalizedWidget(
          TimetableResultsScreen(origin: churchgate, destination: borivali),
          locale: const Locale('mr'),
          overrides: [
            timetableRepositoryProvider.overrideWithValue(repository),
          ],
        );

        // Verify Marathi station names in header
        expect(find.text('चर्चगेट → बोरिवली'), findsOneWidget);
        // Verify Marathi fast train badge
        expect(find.text('जलद'), findsWidgets);
        // Verify Marathi filter chips
        expect(find.text('सर्व'), findsOneWidget);
        expect(find.text('धीमी'), findsWidgets);
      },
    );
  });
}
