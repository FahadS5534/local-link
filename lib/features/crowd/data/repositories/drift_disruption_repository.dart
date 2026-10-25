import 'dart:async';
import 'package:drift/drift.dart';
import 'package:local_link/features/timetable/data/database/app_database.dart';
import 'package:local_link/features/timetable/domain/entities/station.dart';
import '../../domain/entities/disruption_report.dart';
import '../../domain/entities/service_advisory.dart';
import '../../domain/repositories/disruption_repository.dart';

/// Repository managing community disruption reports and persistent SQLite service advisories.
class DriftDisruptionRepository implements DisruptionRepository {
  final AppDatabase _db;
  final List<DisruptionReport> _communityReports = [];
  final _disruptionsController = StreamController<void>.broadcast();

  DriftDisruptionRepository(this._db) {
    // Seed standard Mumbai Sunday Mega Block notice for commuters
    _seedDefaultAdvisories();
  }

  void _seedDefaultAdvisories() async {
    final existing = await _db.select(_db.serviceAdvisoriesTable).get();
    if (existing.isEmpty) {
      final now = DateTime.now();
      await saveAdvisories([
        ServiceAdvisory(
          id: 'ADV_MEGA_BLOCK_CR',
          lineId: 'central',
          titleEn: 'Sunday Mega Block: Matunga — Mulund',
          titleMr: 'रविवार मेगा ब्लॉक: माटुंगा — मुलुंड',
          titleHi: 'रविवार मेगा ब्लॉक: माटुंगा — मुलुंड',
          descriptionEn:
              'Up and Down slow line services diverted onto fast lines between Matunga and Mulund (11:00 to 16:00).',
          descriptionMr:
              'माटुंगा ते मुलुंड दरम्यान धीम्या मार्गावरील गाड्या जलद मार्गावर वळवल्या जातील (११:०० ते १६:००).',
          descriptionHi:
              'माटुंगा और मुलुंड के बीच धीमी लाइन सेवाएं फास्ट लाइन पर डायवर्ट रहेंगी (11:00 से 16:00).',
          severity: AdvisorySeverity.warning,
          effectiveFrom: now.subtract(const Duration(days: 1)),
          effectiveUntil: now.add(const Duration(days: 7)),
          isVerified: true,
        ),
      ]);
    }
  }

  @override
  Future<List<DisruptionReport>> getActiveDisruptions({
    RailwayLineId? lineId,
    DateTime? asOf,
  }) async {
    final now = asOf ?? DateTime.now();
    return _communityReports
        .where((r) => (lineId == null || r.lineId == lineId) && r.isActive(now))
        .toList();
  }

  @override
  Stream<List<DisruptionReport>> watchActiveDisruptions({
    RailwayLineId? lineId,
  }) async* {
    yield await getActiveDisruptions(lineId: lineId);
    await for (final _ in _disruptionsController.stream) {
      yield await getActiveDisruptions(lineId: lineId);
    }
  }

  @override
  Future<void> submitDisruption(DisruptionReport report) async {
    _communityReports.add(report);
    _disruptionsController.add(null);
  }

  @override
  Future<void> upvoteDisruption(String id) async {
    final index = _communityReports.indexWhere((r) => r.id == id);
    if (index != -1) {
      final existing = _communityReports[index];
      _communityReports[index] = existing.copyWith(
        upvotes: existing.upvotes + 1,
      );
      _disruptionsController.add(null);
    }
  }

  @override
  Future<List<ServiceAdvisory>> getActiveAdvisories({
    String? lineId,
    DateTime? asOf,
  }) async {
    final now = asOf ?? DateTime.now();
    final query = _db.select(_db.serviceAdvisoriesTable)
      ..where(
        (tbl) =>
            tbl.effectiveFrom.isSmallerOrEqualValue(now) &
            tbl.effectiveUntil.isBiggerOrEqualValue(now),
      );

    if (lineId != null && lineId.isNotEmpty) {
      query.where((tbl) => tbl.lineId.equals(lineId));
    }

    final rows = await query.get();
    return rows.map((row) {
      return ServiceAdvisory(
        id: row.id,
        lineId: row.lineId,
        titleEn: row.titleEn,
        titleMr: row.titleMr,
        titleHi: row.titleHi,
        descriptionEn: row.descriptionEn,
        descriptionMr: row.descriptionMr,
        descriptionHi: row.descriptionHi,
        severity: AdvisorySeverity.fromString(row.severity),
        effectiveFrom: row.effectiveFrom,
        effectiveUntil: row.effectiveUntil,
        isVerified: row.isVerified,
      );
    }).toList();
  }

  @override
  Future<void> saveAdvisories(List<ServiceAdvisory> advisories) async {
    await _db.transaction(() async {
      for (final adv in advisories) {
        await _db
            .into(_db.serviceAdvisoriesTable)
            .insertOnConflictUpdate(
              ServiceAdvisoriesTableCompanion.insert(
                id: adv.id,
                lineId: adv.lineId,
                titleEn: adv.titleEn,
                titleMr: adv.titleMr,
                titleHi: adv.titleHi,
                descriptionEn: adv.descriptionEn,
                descriptionMr: adv.descriptionMr,
                descriptionHi: adv.descriptionHi,
                severity: adv.severity.name,
                effectiveFrom: adv.effectiveFrom,
                effectiveUntil: adv.effectiveUntil,
                isVerified: Value(adv.isVerified),
              ),
            );
      }
    });
  }

  void dispose() {
    _disruptionsController.close();
  }
}
