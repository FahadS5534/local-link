/// Represents a single station stop for a scheduled train service.
class StopSchedule {
  final String tripId;
  final String stationId;
  final int stopSequence;
  final int arrivalMinutes; // 0 to 1439 (minutes from 00:00)
  final int departureMinutes; // 0 to 1439
  final String? platform;

  const StopSchedule({
    required this.tripId,
    required this.stationId,
    required this.stopSequence,
    required this.arrivalMinutes,
    required this.departureMinutes,
    this.platform,
  });

  /// Formats minutes from midnight into 24-hour "HH:mm" representation.
  static String formatMinutes(int minutes) {
    final clamped = minutes % 1440;
    final hours = (clamped ~/ 60).toString().padLeft(2, '0');
    final mins = (clamped % 60).toString().padLeft(2, '0');
    return '$hours:$mins';
  }

  /// Formatted departure time string (e.g. "08:42").
  String get departureTimeFormatted => formatMinutes(departureMinutes);

  /// Formatted arrival time string (e.g. "08:41").
  String get arrivalTimeFormatted => formatMinutes(arrivalMinutes);

  /// Dwell time in minutes at this station.
  int get dwellTimeMinutes => departureMinutes - arrivalMinutes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StopSchedule &&
          runtimeType == other.runtimeType &&
          tripId == other.tripId &&
          stationId == other.stationId &&
          stopSequence == other.stopSequence;

  @override
  int get hashCode =>
      tripId.hashCode ^ stationId.hashCode ^ stopSequence.hashCode;

  @override
  String toString() =>
      'StopSchedule($tripId, station: $stationId, seq: $stopSequence, dep: $departureTimeFormatted)';
}
