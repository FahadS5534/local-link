import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/routing/domain/services/route_graph_service.dart';
import 'package:local_link/features/timetable/data/database/app_database.dart';
import 'package:local_link/features/timetable/data/datasources/timetable_parser.dart';
import 'package:local_link/features/timetable/data/repositories/drift_timetable_repository.dart';
import 'package:local_link/features/timetable/domain/failures/timetable_failure.dart';

void main() {
  late AppDatabase db;
  late DriftTimetableRepository repository;
  late RouteGraphService routePlanner;
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
    routePlanner = RouteGraphService(repository);
  });

  tearDown(() async {
    await db.close();
  });

  group('RouteGraphService Journey Planning', () {
    test('Plans direct journey between Churchgate and Borivali', () async {
      final plans = await routePlanner.planJourney(
        originId: 'ST_CCG',
        destinationId: 'ST_BVI',
      );

      expect(plans, isNotEmpty);
      expect(plans.first.isDirect, isTrue);
      expect(plans.first.origin.code, 'CCG');
      expect(plans.first.destination.code, 'BVI');
      expect(plans.first.legs.length, 1);
    });

    test(
      'Plans transfer journey between Thane and Churchgate via Dadar',
      () async {
        // Thane (Central Main) to Churchgate (Western) requires Dadar interchange
        final plans = await routePlanner.planJourney(
          originId: 'ST_TNA',
          destinationId: 'ST_CCG',
          transferBufferMinutes: 5,
        );

        expect(plans, isNotEmpty);
        final transferPlan = plans.firstWhere((p) => !p.isDirect);
        expect(transferPlan.transferStation?.code, 'DDR');
        expect(transferPlan.legs.length, 2);

        // Leg 1: Thane to Dadar
        expect(transferPlan.legs[0].originStation.code, 'TNA');
        expect(transferPlan.legs[0].destinationStation.code, 'DDR');

        // Leg 2: Dadar to Churchgate
        expect(transferPlan.legs[1].originStation.code, 'DDR');
        expect(transferPlan.legs[1].destinationStation.code, 'CCG');

        // Transfer buffer must be >= requested buffer
        expect(transferPlan.transferBufferMinutes, greaterThanOrEqualTo(5));
      },
    );

    test(
      'Throws StationNotFoundFailure when origin station is unknown',
      () async {
        expect(
          () => routePlanner.planJourney(
            originId: 'ST_NONEXISTENT',
            destinationId: 'ST_CCG',
          ),
          throwsA(isA<StationNotFoundFailure>()),
        );
      },
    );

    test(
      'Throws StationNotFoundFailure when destination station is unknown',
      () async {
        expect(
          () => routePlanner.planJourney(
            originId: 'ST_CCG',
            destinationId: 'ST_NONEXISTENT',
          ),
          throwsA(isA<StationNotFoundFailure>()),
        );
      },
    );

    test('Returns empty list when origin equals destination', () async {
      final plans = await routePlanner.planJourney(
        originId: 'ST_CCG',
        destinationId: 'ST_CCG',
      );
      expect(plans, isEmpty);
    });
  });
}
