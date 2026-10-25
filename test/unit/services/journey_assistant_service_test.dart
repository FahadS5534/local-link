import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/assistant/domain/services/journey_assistant_service.dart';
import 'package:local_link/features/routing/domain/services/route_graph_service.dart';
import 'package:local_link/features/timetable/data/database/app_database.dart';
import 'package:local_link/features/timetable/data/datasources/timetable_parser.dart';
import 'package:local_link/features/timetable/data/repositories/drift_timetable_repository.dart';

void main() {
  late AppDatabase db;
  late DriftTimetableRepository timetableRepo;
  late RouteGraphService routeGraphService;
  late JourneyAssistantService assistantService;
  const parser = TimetableParser();

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    timetableRepo = DriftTimetableRepository(db: db);

    final stationsRaw = File(
      'assets/data/mumbai_stations.json',
    ).readAsStringSync();
    final stations = parser.parseStationsJson(stationsRaw);
    final stationMap = {for (final s in stations) s.id: s};

    final tripsRaw = File('assets/data/mumbai_trips.json').readAsStringSync();
    final trips = parser.parseTripsJson(tripsRaw, stationMap);

    await db.seedDatabase(stations: stations, tripsWithStops: trips);

    routeGraphService = RouteGraphService(timetableRepo);
    assistantService = JourneyAssistantService(
      timetableRepo: timetableRepo,
      routeGraphService: routeGraphService,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('JourneyAssistantService Natural Language Tests', () {
    test(
      'extracts origin and destination from English query and finds valid route',
      () async {
        final response = await assistantService.processQuery(
          'How can I get from Bandra to Borivali?',
        );

        expect(response.origin, isNotNull);
        expect(response.destination, isNotNull);
        expect(response.origin!.code, equals('BA'));
        expect(response.destination!.code, equals('BVI'));
        expect(response.recommendedRoutes, isNotEmpty);
        expect(response.isLiveRealtime, isFalse);
      },
    );

    test(
      'extracts stations from Marathi query with Devanagari script (दादर ते ठाणे)',
      () async {
        final response = await assistantService.processQuery(
          'दादर ते ठाणे जलद गाडी कोणती आहे?',
          lang: 'mr',
        );

        expect(response.origin, isNotNull);
        expect(response.destination, isNotNull);
        expect(response.origin!.code, equals('DDR'));
        expect(response.destination!.code, equals('TNA'));
        expect(response.recommendedRoutes, isNotEmpty);
      },
    );

    test('responds to service disruption and Mega Block queries', () async {
      final response = await assistantService.processQuery(
        'Is there any Sunday Mega Block today on Central line?',
      );

      expect(response.intent, equals(AssistantIntentType.disruptionQuery));
      expect(response.message, contains('Mega Block'));
    });

    test(
      'provides helpful fallback prompt on ambiguous or general queries',
      () async {
        final response = await assistantService.processQuery('Hello there');

        expect(response.intent, equals(AssistantIntentType.generalHelp));
        expect(response.message, contains('Ask me travel questions'));
      },
    );
  });
}
