import 'dart:math' as math;

/// Utility service to calculate geographical distances on Earth using the Haversine formula.
class HaversineCalculator {
  /// Mean radius of the Earth in meters.
  static const double earthRadiusMeters = 6371000.0;

  /// Calculates the spherical distance in meters between two geographical points.
  static double distanceInMeters({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  }) {
    final dLat = _degreesToRadians(endLat - startLat);
    final dLng = _degreesToRadians(endLng - startLng);

    final lat1Rad = _degreesToRadians(startLat);
    final lat2Rad = _degreesToRadians(endLat);

    final a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1Rad) *
            math.cos(lat2Rad) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadiusMeters * c;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180.0);
  }
}
