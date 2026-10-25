import 'station.dart';

/// Direction of travel in the Mumbai suburban network:
/// - UP: Heading towards the city terminus (Churchgate on WR, CSMT on CR/HR).
/// - DOWN: Heading away from the city terminus into the suburbs.
enum TrainDirection { up, down }

/// Category of service for a suburban train rake.
enum ServiceType { slow, fast, acSlow, acFast, ladiesSpecial }

/// Represents an individual scheduled train service.
class TrainTrip {
  final String id;
  final String trainNumber;
  final RailwayLineId lineId;
  final TrainDirection direction;
  final ServiceType serviceType;
  final String sourceStationId;
  final String destinationStationId;
  final int
  operatingDaysMask; // Bit 0 = Monday (1), Bit 6 = Sunday (64). 127 = Daily.

  const TrainTrip({
    required this.id,
    required this.trainNumber,
    required this.lineId,
    required this.direction,
    required this.serviceType,
    required this.sourceStationId,
    required this.destinationStationId,
    this.operatingDaysMask = 127,
  });

  /// Returns true if this trip operates on the specified [weekday] (1 = Mon ... 7 = Sun).
  bool runsOnWeekday(int weekday) {
    if (weekday < 1 || weekday > 7) return false;
    final bit = 1 << (weekday - 1);
    return (operatingDaysMask & bit) != 0;
  }

  /// Whether this service skips minor stations (Fast or AC Fast).
  bool get isFast =>
      serviceType == ServiceType.fast || serviceType == ServiceType.acFast;

  /// Whether this is an air-conditioned local rake.
  bool get isAc =>
      serviceType == ServiceType.acSlow || serviceType == ServiceType.acFast;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainTrip && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'TrainTrip($id, No: $trainNumber, $lineId, $direction, $serviceType)';
}
