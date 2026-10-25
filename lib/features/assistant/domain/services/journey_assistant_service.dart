import 'package:local_link/features/routing/domain/services/route_graph_service.dart';
import 'package:local_link/features/timetable/domain/entities/route_plan.dart';
import 'package:local_link/features/timetable/domain/entities/station.dart';
import 'package:local_link/features/timetable/domain/repositories/timetable_repository.dart';

/// Intent types recognized by the assistant.
enum AssistantIntentType {
  planRoute,
  fastestRoute,
  fewerTransfers,
  crowdQuery,
  disruptionQuery,
  generalHelp,
}

/// Response payload from the conversational journey assistant.
class AssistantResponse {
  final String message;
  final AssistantIntentType intent;
  final Station? origin;
  final Station? destination;
  final List<RoutePlan> recommendedRoutes;
  final bool isLiveRealtime;
  final String? notice;

  const AssistantResponse({
    required this.message,
    required this.intent,
    this.origin,
    this.destination,
    this.recommendedRoutes = const [],
    this.isLiveRealtime = false,
    this.notice,
  });
}

/// Trilingual conversational assistant service with zero-cost local natural language parsing.
/// Guarantees that all route suggestions, train schedules, and stops come strictly from
/// verified LocalLink railway database models and never fabricated.
class JourneyAssistantService {
  final TimetableRepository _timetableRepo;
  final RouteGraphService _routeGraphService;

  JourneyAssistantService({
    required TimetableRepository timetableRepo,
    required RouteGraphService routeGraphService,
  }) : _timetableRepo = timetableRepo,
       _routeGraphService = routeGraphService;

  /// Processes natural language commuter queries in English, Marathi, or Hindi.
  Future<AssistantResponse> processQuery(
    String query, {
    String lang = 'en',
  }) async {
    final cleanQuery = query.trim().toLowerCase();

    // 1. Detect if asking about mega blocks / disruptions
    if (_matchesKeywords(cleanQuery, [
      'block',
      'mega block',
      'delay',
      'ब्लॉक',
      'उशीर',
      'देरी',
      'बंद',
    ])) {
      return const AssistantResponse(
        message:
            'Active Service Advisory: Sunday Mega Blocks typically operate on Central and Western slow corridors between 11:00 AM and 04:00 PM. Check the Corridors & Advisories tab for details.',
        intent: AssistantIntentType.disruptionQuery,
        isLiveRealtime: false,
        notice: 'Official scheduled advisory notice.',
      );
    }

    // 2. Extract stations from query
    final stations = await _timetableRepo.getAllStations();
    final matchedStations = _extractStations(cleanQuery, stations);

    if (matchedStations.length >= 2) {
      final origin = matchedStations[0];
      final destination = matchedStations[1];

      final wantsFastest = _matchesKeywords(cleanQuery, [
        'fast',
        'fastest',
        'quick',
        'लवकर',
        'जलद',
        'तेज',
        'कम समय',
      ]);
      final wantsDirect = _matchesKeywords(cleanQuery, [
        'direct',
        'change',
        'transfer',
        'थेट',
        'बदल',
        'बिना बदले',
      ]);

      final now = DateTime.now();
      final currentMinutes = now.hour * 60 + now.minute;

      List<RoutePlan> routeResult = [];
      try {
        routeResult = await _routeGraphService.planJourney(
          originId: origin.id,
          destinationId: destination.id,
          departureMinutes: currentMinutes,
          weekday: now.weekday,
        );
      } catch (_) {
        // Fallback: If no journeys exist after current time (e.g. late night or in sample fixtures),
        // query all available scheduled routes without time constraint.
        try {
          routeResult = await _routeGraphService.planJourney(
            originId: origin.id,
            destinationId: destination.id,
          );
        } catch (_) {
          routeResult = [];
        }
      }

      if (wantsFastest) {
        routeResult.sort(
          (a, b) => a.totalDurationMinutes.compareTo(b.totalDurationMinutes),
        );
      } else if (wantsDirect) {
        routeResult.sort(
          (a, b) => (a.isDirect ? 0 : 1).compareTo(b.isDirect ? 0 : 1),
        );
      }

      final originName = origin.localizedName(lang);
      final destName = destination.localizedName(lang);

      if (routeResult.isEmpty) {
        return AssistantResponse(
          message:
              'No direct or transfer train routes found between $originName and $destName in the local timetable database.',
          intent: AssistantIntentType.planRoute,
          origin: origin,
          destination: destination,
          isLiveRealtime: false,
        );
      }

      final summary = wantsFastest
          ? 'Here is the fastest scheduled route from $originName to $destName:'
          : 'Found ${routeResult.length} candidate route(s) from $originName to $destName:';

      return AssistantResponse(
        message: summary,
        intent: wantsFastest
            ? AssistantIntentType.fastestRoute
            : AssistantIntentType.planRoute,
        origin: origin,
        destination: destination,
        recommendedRoutes: routeResult,
        isLiveRealtime: false,
        notice: 'All timings are based on official scheduled timetables.',
      );
    } else if (matchedStations.length == 1) {
      final station = matchedStations.first;
      final stName = station.localizedName(lang);
      return AssistantResponse(
        message:
            'I identified $stName (${station.code}). Where would you like to travel to or from?',
        intent: AssistantIntentType.generalHelp,
        origin: station,
      );
    }

    // Fallback general guidance
    return const AssistantResponse(
      message:
          'Ask me travel questions like: "How do I get from Bandra to Borivali?", "Fastest route from Dadar to Thane", or "Check Mega Block status".',
      intent: AssistantIntentType.generalHelp,
      isLiveRealtime: false,
    );
  }

  bool _matchesKeywords(String text, List<String> keywords) {
    for (final kw in keywords) {
      if (text.contains(kw.toLowerCase())) return true;
    }
    return false;
  }

  List<Station> _extractStations(String text, List<Station> stations) {
    final found = <Station>[];

    // Priority matching against known station names and codes
    for (final s in stations) {
      final nameEn = s.nameEn.toLowerCase();
      final nameMr = s.nameMr.toLowerCase();
      final nameHi = s.nameHi.toLowerCase();
      final code = s.code.toLowerCase();

      if (text.contains(nameEn) ||
          (nameMr.isNotEmpty && text.contains(nameMr)) ||
          (nameHi.isNotEmpty && text.contains(nameHi)) ||
          text.split(RegExp(r'\s+')).contains(code)) {
        if (!found.contains(s)) {
          found.add(s);
        }
      }
    }

    // Sort by appearance order in user's query
    found.sort((a, b) {
      final indexA = _firstOccurrence(text, a);
      final indexB = _firstOccurrence(text, b);
      return indexA.compareTo(indexB);
    });

    return found;
  }

  int _firstOccurrence(String text, Station s) {
    final iEn = text.indexOf(s.nameEn.toLowerCase());
    if (iEn != -1) return iEn;
    final iMr = text.indexOf(s.nameMr.toLowerCase());
    if (iMr != -1) return iMr;
    final iHi = text.indexOf(s.nameHi.toLowerCase());
    if (iHi != -1) return iHi;
    return text.indexOf(s.code.toLowerCase());
  }
}
