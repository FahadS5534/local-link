import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../timetable/domain/entities/route_plan.dart';
import '../../../timetable/presentation/providers/timetable_providers.dart';
import '../../domain/services/route_graph_service.dart';

/// Provider for the route pathfinding service.
final routeGraphServiceProvider = Provider<RouteGraphService>((ref) {
  final repository = ref.watch(timetableRepositoryProvider);
  return RouteGraphService(repository);
});

/// Query parameter record for route planning.
typedef RouteQueryParams = ({
  String originId,
  String destinationId,
  int? departureMinutes,
  int? weekday,
  int transferBufferMinutes,
});

/// Family provider to plan journeys between two stations.
final journeyPlannerProvider =
    FutureProvider.family<List<RoutePlan>, RouteQueryParams>((
      ref,
      params,
    ) async {
      final service = ref.watch(routeGraphServiceProvider);
      return service.planJourney(
        originId: params.originId,
        destinationId: params.destinationId,
        departureMinutes: params.departureMinutes,
        weekday: params.weekday,
        transferBufferMinutes: params.transferBufferMinutes,
      );
    });
