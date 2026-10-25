import 'station.dart';

/// Represents a suburban railway corridor (e.g. Western Line, Central Line Main).
class RailwayLine {
  final RailwayLineId id;
  final String nameEn;
  final String nameHi;
  final String nameMr;
  final int colorHex;
  final String northernTerminusCode;
  final String southernTerminusCode;

  const RailwayLine({
    required this.id,
    required this.nameEn,
    required this.nameHi,
    required this.nameMr,
    required this.colorHex,
    required this.northernTerminusCode,
    required this.southernTerminusCode,
  });

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
      other is RailwayLine &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
