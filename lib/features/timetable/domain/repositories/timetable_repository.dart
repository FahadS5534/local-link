import '../entities/route_plan.dart';
import '../entities/station.dart';
import '../entities/stop_schedule.dart';

/// Contract for offline timetable and station repository.
abstract interface class TimetableRepository {
  /// Fetches all Mumbai Suburban stations.
  Future<List<Station>> getAllStations();

  /// Searches stations across all 3 languages (English, Marathi, Hindi) and code.
  Future<List<Station>> searchStations(String query);

  /// Look up station by code (e.g. 'DDR', 'CSMT').
  Future<Station?> getStationByCode(String code);

  /// Look up station by stable ID (e.g. 'ST_DDR').
  Future<Station?> getStationById(String id);

  /// Finds direct routes between two stations on the same line after [afterMinutes].
  Future<List<RoutePlan>> findDirectRoutes({
    required String originId,
    required String destinationId,
    int? afterMinutes,
    int? weekday,
  });

  /// Fetches the complete sequence of stops for a scheduled trip.
  Future<List<StopSchedule>> getStopsForTrip(String tripId);

  /// Pre-populates the local SQLite database from bundled assets if empty.
  Future<void> initializeSeedData();
}
