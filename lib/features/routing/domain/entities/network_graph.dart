import '../../../timetable/domain/entities/station.dart';

/// Represents a potential topological journey segment between two stations.
class NetworkPathSegment {
  final Station origin;
  final Station destination;
  final RailwayLineId line;

  const NetworkPathSegment({
    required this.origin,
    required this.destination,
    required this.line,
  });

  @override
  String toString() => '${origin.code} -> ${destination.code} (${line.name})';
}

/// Represents a complete topological route proposal (direct or with an interchange).
class TopologicalRoute {
  final Station origin;
  final Station destination;
  final List<NetworkPathSegment> segments;
  final Station? transferStation;

  const TopologicalRoute({
    required this.origin,
    required this.destination,
    required this.segments,
    this.transferStation,
  });

  bool get isDirect => segments.length == 1;

  @override
  String toString() {
    if (isDirect) {
      return 'Direct: ${segments.first}';
    }
    return 'Transfer via ${transferStation?.code}: ${segments.map((s) => s.toString()).join(' | ')}';
  }
}

/// In-memory graph of Mumbai Suburban Railway corridors and interchange stations.
class RailwayNetworkGraph {
  final Map<String, Station> _stationById;
  final Map<String, Station> _stationByCode;
  final Map<RailwayLineId, List<Station>> _stationsByLine;
  final List<Station> _interchanges;

  RailwayNetworkGraph(List<Station> stations)
    : _stationById = {for (final s in stations) s.id: s},
      _stationByCode = {for (final s in stations) s.code: s},
      _stationsByLine = {},
      _interchanges = stations.where((s) => s.isInterchange).toList() {
    for (final s in stations) {
      for (final line in s.lines) {
        _stationsByLine.putIfAbsent(line, () => []).add(s);
      }
    }
  }

  /// Get station by ID.
  Station? getStationById(String id) => _stationById[id];

  /// Get station by railway code.
  Station? getStationByCode(String code) =>
      _stationByCode[code.trim().toUpperCase()];

  /// All interchange hubs in the network.
  List<Station> get interchangeStations => List.unmodifiable(_interchanges);

  /// Find common lines shared by two stations.
  Set<RailwayLineId> commonLines(Station a, Station b) {
    final setA = a.lines.toSet();
    return setA.intersection(b.lines.toSet());
  }

  /// Finds all valid topological routes (direct and single-transfer) between [origin] and [destination].
  List<TopologicalRoute> findTopologicalRoutes({
    required Station origin,
    required Station destination,
  }) {
    if (origin.id == destination.id) {
      return const [];
    }

    final routes = <TopologicalRoute>[];

    // 1. Direct routes (if both stations share at least one line)
    final sharedLines = commonLines(origin, destination);
    for (final line in sharedLines) {
      routes.add(
        TopologicalRoute(
          origin: origin,
          destination: destination,
          segments: [
            NetworkPathSegment(
              origin: origin,
              destination: destination,
              line: line,
            ),
          ],
        ),
      );
    }

    // 2. Single-transfer interchange routes
    // Find all interchange stations that can bridge origin line and destination line
    final originLines = origin.lines.toSet();
    final destLines = destination.lines.toSet();

    for (final interchange in _interchanges) {
      // Transfer station cannot be the origin or destination
      if (interchange.id == origin.id || interchange.id == destination.id) {
        continue;
      }

      final leg1Lines = originLines.intersection(interchange.lines.toSet());
      final leg2Lines = destLines.intersection(interchange.lines.toSet());

      if (leg1Lines.isNotEmpty && leg2Lines.isNotEmpty) {
        // Can bridge with this interchange!
        for (final l1 in leg1Lines) {
          for (final l2 in leg2Lines) {
            // Only add transfer if it's across different lines or provides an alternative
            if (l1 != l2 || sharedLines.isEmpty) {
              routes.add(
                TopologicalRoute(
                  origin: origin,
                  destination: destination,
                  transferStation: interchange,
                  segments: [
                    NetworkPathSegment(
                      origin: origin,
                      destination: interchange,
                      line: l1,
                    ),
                    NetworkPathSegment(
                      origin: interchange,
                      destination: destination,
                      line: l2,
                    ),
                  ],
                ),
              );
            }
          }
        }
      }
    }

    return routes;
  }
}
