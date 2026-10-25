/// Severity levels for official or verified railway service advisories.
enum AdvisorySeverity {
  info,
  warning,
  critical;

  static AdvisorySeverity fromString(String raw) {
    switch (raw.toLowerCase()) {
      case 'critical':
      case 'severe':
        return AdvisorySeverity.critical;
      case 'warning':
        return AdvisorySeverity.warning;
      case 'info':
      default:
        return AdvisorySeverity.info;
    }
  }
}

/// Official or verified railway service advisory (e.g. Mega Block, Sunday timetable, maintenance).
class ServiceAdvisory {
  final String id;
  final String lineId;
  final String titleEn;
  final String titleMr;
  final String titleHi;
  final String descriptionEn;
  final String descriptionMr;
  final String descriptionHi;
  final AdvisorySeverity severity;
  final DateTime effectiveFrom;
  final DateTime effectiveUntil;
  final bool isVerified;

  const ServiceAdvisory({
    required this.id,
    required this.lineId,
    required this.titleEn,
    required this.titleMr,
    required this.titleHi,
    required this.descriptionEn,
    required this.descriptionMr,
    required this.descriptionHi,
    required this.severity,
    required this.effectiveFrom,
    required this.effectiveUntil,
    this.isVerified = true,
  });

  /// True if the advisory is currently within its effective active window.
  bool isActive([DateTime? now]) {
    final current = now ?? DateTime.now();
    return current.isAfter(effectiveFrom) && current.isBefore(effectiveUntil);
  }

  /// Localized title based on language code ('en', 'mr', 'hi').
  String localizedTitle(String langCode) {
    switch (langCode.toLowerCase()) {
      case 'mr':
        return titleMr.isNotEmpty ? titleMr : titleEn;
      case 'hi':
        return titleHi.isNotEmpty ? titleHi : titleEn;
      case 'en':
      default:
        return titleEn;
    }
  }

  /// Localized description based on language code.
  String localizedDescription(String langCode) {
    switch (langCode.toLowerCase()) {
      case 'mr':
        return descriptionMr.isNotEmpty ? descriptionMr : descriptionEn;
      case 'hi':
        return descriptionHi.isNotEmpty ? descriptionHi : descriptionEn;
      case 'en':
      default:
        return descriptionEn;
    }
  }
}
