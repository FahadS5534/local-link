import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/crowd_report.dart';
import '../providers/crowd_providers.dart';
import 'submit_crowd_report_sheet.dart';

/// Interactive card presenting real-time coach crowding observations and reports.
class CoachCrowdingCard extends ConsumerWidget {
  final String tripId;
  final String stationId;

  const CoachCrowdingCard({
    super.key,
    required this.tripId,
    required this.stationId,
  });

  Color _densityColor(CrowdDensity density) {
    switch (density) {
      case CrowdDensity.low:
        return AppColors.freshReportGreen;
      case CrowdDensity.medium:
        return AppColors.centralLine;
      case CrowdDensity.heavy:
        return AppColors.expiringReportAmber;
      case CrowdDensity.superDense:
        return AppColors.westernLine;
    }
  }

  String _densityLabel(BuildContext context, CrowdDensity density) {
    final l10n = context.l10n;
    switch (density) {
      case CrowdDensity.low:
        return l10n.densityLow;
      case CrowdDensity.medium:
        return l10n.densityMedium;
      case CrowdDensity.heavy:
        return l10n.densityHeavy;
      case CrowdDensity.superDense:
        return l10n.densitySuperDense;
    }
  }

  String _coachLabel(BuildContext context, CoachType coach) {
    final l10n = context.l10n;
    switch (coach) {
      case CoachType.secondClass:
        return l10n.coachSecondClass;
      case CoachType.firstClass:
        return l10n.coachFirstClass;
      case CoachType.ladies:
        return l10n.coachLadies;
      case CoachType.divyang:
        return l10n.coachDivyang;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final reportsAsync = ref.watch(tripCrowdReportsProvider(tripId));

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withAlpha(60)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Title + Report Action Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.people_outline, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      l10n.crowdReportTitle,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add_circle_outline, size: 16),
                  label: Text(l10n.reportCrowdButton),
                  onPressed: () {
                    SubmitCrowdReportSheet.show(
                      context,
                      tripId: tripId,
                      stationId: stationId,
                    );
                  },
                ),
              ],
            ),
            // Active Reports List or Empty fallback
            reportsAsync.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              error: (err, stack) => Text(
                'Crowd sync unavailable (offline)',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
              data: (reports) {
                if (reports.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      'No recent reports • Tap "Report Crowding" to share with commuters',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  );
                }

                return Column(
                  children: reports.map((r) {
                    final color = _densityColor(r.crowdDensity);
                    final freshness = r.getFreshness();
                    final isExpiring = freshness == ReportFreshness.expiring;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: color.withAlpha(15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${_coachLabel(context, r.coachType)}: ${_densityLabel(context, r.crowdDensity)}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          // Freshness badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isExpiring
                                  ? AppColors.expiringReportAmber.withAlpha(30)
                                  : AppColors.freshReportGreen.withAlpha(30),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              isExpiring ? l10n.expiringBadge : l10n.freshBadge,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isExpiring
                                    ? AppColors.expiringReportAmber
                                    : AppColors.freshReportGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 6),
            // Disclaimer
            Text(
              l10n.crowdDisclaimer,
              style: TextStyle(fontSize: 10, color: theme.colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}
