import 'station.dart';
import 'stop_schedule.dart';
import 'train_trip.dart';

/// Represents a single train leg of a planned journey.
class RouteLeg {
  final TrainTrip trip;
  final Station originStation;
  final Station destinationStation;
  final int departureMinutes;
  final int arrivalMinutes;
  final List<StopSchedule> intermediateStops;
  final int skippedStopCount;

  const RouteLeg({
    required this.trip,
    required this.originStation,
    required this.destinationStation,
    required this.departureMinutes,
    required this.arrivalMinutes,
    required this.intermediateStops,
    this.skippedStopCount = 0,
  });

  /// Total travel duration in minutes for this leg.
  int get durationMinutes => arrivalMinutes >= departureMinutes
      ? arrivalMinutes - departureMinutes
      : (arrivalMinutes + 1440) - departureMinutes; // Wraps past midnight

  String get departureTimeFormatted =>
      StopSchedule.formatMinutes(departureMinutes);
  String get arrivalTimeFormatted => StopSchedule.formatMinutes(arrivalMinutes);
}

/// Represents a complete journey plan between an origin and a destination station.
class RoutePlan {
  final Station origin;
  final Station destination;
  final List<RouteLeg> legs;
  final Station? transferStation;
  final int? transferBufferMinutes;

  const RoutePlan({
    required this.origin,
    required this.destination,
    required this.legs,
    this.transferStation,
    this.transferBufferMinutes,
  });

  /// True if this is a direct single-train journey.
  bool get isDirect => legs.length == 1;

  /// Total door-to-door journey duration including transfer buffers.
  int get totalDurationMinutes {
    if (legs.isEmpty) return 0;
    var total = 0;
    for (final leg in legs) {
      total += leg.durationMinutes;
    }
    if (transferBufferMinutes != null) {
      total += transferBufferMinutes!;
    }
    return total;
  }
}
