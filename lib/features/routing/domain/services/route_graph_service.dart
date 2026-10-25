import '../../../timetable/domain/entities/route_plan.dart';
import '../../../timetable/domain/failures/timetable_failure.dart';
import '../../../timetable/domain/repositories/timetable_repository.dart';
import '../entities/network_graph.dart';

/// Domain service responsible for computing direct and transfer journeys across railway corridors.
class RouteGraphService {
  final TimetableRepository _timetableRepository;
  RailwayNetworkGraph? _cachedGraph;

  RouteGraphService(this._timetableRepository);

  /// Initializes or retrieves the railway network graph from stations.
  Future<RailwayNetworkGraph> getNetworkGraph() async {
    if (_cachedGraph != null) return _cachedGraph!;
    final stations = await _timetableRepository.getAllStations();
    _cachedGraph = RailwayNetworkGraph(stations);
    return _cachedGraph!;
  }

  /// Plans a journey between [originId] and [destinationId] with optional time and transfer parameters.
  Future<List<RoutePlan>> planJourney({
    required String originId,
    required String destinationId,
    int? departureMinutes,
    int? weekday,
    int transferBufferMinutes = 8,
    int maxResults = 15,
  }) async {
    final origin = await _timetableRepository.getStationById(originId);
    if (origin == null) {
      throw StationNotFoundFailure(originId);
    }

    final destination = await _timetableRepository.getStationById(
      destinationId,
    );
    if (destination == null) {
      throw StationNotFoundFailure(destinationId);
    }

    if (origin.id == destination.id) {
      return const [];
    }

    final graph = await getNetworkGraph();
    final topologicalRoutes = graph.findTopologicalRoutes(
      origin: origin,
      destination: destination,
    );

    if (topologicalRoutes.isEmpty) {
      throw RouteNotFoundFailure(
        originCode: origin.code,
        destinationCode: destination.code,
      );
    }

    final candidatePlans = <RoutePlan>[];

    // 1. Process direct routes
    final directRoutes = await _timetableRepository.findDirectRoutes(
      originId: origin.id,
      destinationId: destination.id,
      afterMinutes: departureMinutes,
      weekday: weekday,
    );
    candidatePlans.addAll(directRoutes);

    // 2. Process single-transfer routes
    final transferTopologies = topologicalRoutes.where((t) => !t.isDirect);
    final visitedInterchanges = <String>{};

    for (final topology in transferTopologies) {
      final transferStation = topology.transferStation;
      if (transferStation == null) continue;

      // Avoid redundant queries for the same interchange junction
      if (!visitedInterchanges.add(transferStation.id)) continue;

      final leg1Routes = await _timetableRepository.findDirectRoutes(
        originId: origin.id,
        destinationId: transferStation.id,
        afterMinutes: departureMinutes,
        weekday: weekday,
      );

      for (final leg1Plan in leg1Routes) {
        if (leg1Plan.legs.isEmpty) continue;
        final leg1 = leg1Plan.legs.first;
        final minConnectingDep = leg1.arrivalMinutes + transferBufferMinutes;

        final leg2Routes = await _timetableRepository.findDirectRoutes(
          originId: transferStation.id,
          destinationId: destination.id,
          afterMinutes: minConnectingDep,
          weekday: weekday,
        );

        for (final leg2Plan in leg2Routes) {
          if (leg2Plan.legs.isEmpty) continue;
          final leg2 = leg2Plan.legs.first;

          // Compute exact transfer buffer
          final actualBuffer = leg2.departureMinutes >= leg1.arrivalMinutes
              ? leg2.departureMinutes - leg1.arrivalMinutes
              : (leg2.departureMinutes + 1440) - leg1.arrivalMinutes;

          candidatePlans.add(
            RoutePlan(
              origin: origin,
              destination: destination,
              transferStation: transferStation,
              transferBufferMinutes: actualBuffer,
              legs: [leg1, leg2],
            ),
          );
        }
      }
    }

    if (candidatePlans.isEmpty) {
      throw RouteNotFoundFailure(
        originCode: origin.code,
        destinationCode: destination.code,
      );
    }

    // Sort plans by arrival time and duration, preferring direct routes when arrival times are close
    candidatePlans.sort((a, b) {
      final aArr = a.legs.last.arrivalMinutes;
      final bArr = b.legs.last.arrivalMinutes;
      if (aArr != bArr) return aArr.compareTo(bArr);

      // Prefer direct if arrival times are identical
      if (a.isDirect != b.isDirect) {
        return a.isDirect ? -1 : 1;
      }

      return a.totalDurationMinutes.compareTo(b.totalDurationMinutes);
    });

    return candidatePlans.take(maxResults).toList();
  }
}
