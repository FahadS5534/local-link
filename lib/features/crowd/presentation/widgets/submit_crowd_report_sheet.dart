import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/crowd_report.dart';
import '../providers/crowd_providers.dart';

/// Interactive modal sheet to submit real-time coach crowding observations.
class SubmitCrowdReportSheet extends ConsumerStatefulWidget {
  final String tripId;
  final String stationId;

  const SubmitCrowdReportSheet({
    super.key,
    required this.tripId,
    required this.stationId,
  });

  static Future<void> show(
    BuildContext context, {
    required String tripId,
    required String stationId,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) =>
          SubmitCrowdReportSheet(tripId: tripId, stationId: stationId),
    );
  }

  @override
  ConsumerState<SubmitCrowdReportSheet> createState() =>
      _SubmitCrowdReportSheetState();
}

class _SubmitCrowdReportSheetState
    extends ConsumerState<SubmitCrowdReportSheet> {
  CoachType _selectedCoach = CoachType.secondClass;
  CrowdDensity _selectedDensity = CrowdDensity.medium;
  bool _isSubmitting = false;

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

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);

    final report = CoachCrowdReport(
      id: 'rpt_${DateTime.now().millisecondsSinceEpoch}',
      tripId: widget.tripId,
      stationId: widget.stationId,
      coachType: _selectedCoach,
      crowdDensity: _selectedDensity,
      timestamp: DateTime.now(),
      clientSessionHash: 'anon_${DateTime.now().microsecond}',
    );

    await ref.read(crowdReportRepositoryProvider).submitReport(report);

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.reportSuccess),
          backgroundColor: AppColors.freshReportGreen,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Title
          Text(
            l10n.reportCrowdButton,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Coach Category Selection
          Text(
            'Select Coach Type',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: CoachType.values.map((coach) {
              final isSelected = _selectedCoach == coach;
              return ChoiceChip(
                label: Text(_coachLabel(context, coach)),
                selected: isSelected,
                onSelected: (val) {
                  if (val) setState(() => _selectedCoach = coach);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          // Crowd Density Level Selection
          Text(
            'Current Crowding Level',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: CrowdDensity.values.map((density) {
              final isSelected = _selectedDensity == density;
              final color = _densityColor(density);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: InkWell(
                  onTap: () => setState(() => _selectedDensity = density),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 48),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? color.withAlpha(25) : null,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? color
                            : theme.colorScheme.outlineVariant,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _densityLabel(context, density),
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        if (isSelected) ...[
                          Icon(Icons.check_circle, color: color, size: 20),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          // Disclaimer
          Text(
            l10n.crowdDisclaimer,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 20),
          // Submit Action Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              child: _isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      l10n.submitReport,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
