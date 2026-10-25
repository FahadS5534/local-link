/// Identifiers for Mumbai Suburban Railway corridors.
enum RailwayLineId { western, centralMain, harbour, transHarbour, uran }

/// Represents a suburban railway station in the Mumbai Metropolitan Region.
class Station {
  final String id;
  final String code;
  final String nameEn;
  final String nameHi;
  final String nameMr;
  final double latitude;
  final double longitude;
  final List<RailwayLineId> lines;
  final bool isInterchange;

  const Station({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameHi,
    required this.nameMr,
    required this.latitude,
    required this.longitude,
    required this.lines,
    this.isInterchange = false,
  });

  /// Returns the localized station name based on locale code ('en', 'hi', 'mr').
  String localizedName(String languageCode) {
    switch (languageCode) {
      case 'hi':
        return nameHi;
      case 'mr':
        return nameMr;
      case 'en':
      default:
        return nameEn;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Station &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          code == other.code;

  @override
  int get hashCode => id.hashCode ^ code.hashCode;

  @override
  String toString() => 'Station($code, $nameEn, lines: $lines)';
}
