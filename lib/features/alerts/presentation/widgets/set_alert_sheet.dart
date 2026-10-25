import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../search/presentation/widgets/station_picker_sheet.dart';
import '../../../timetable/domain/entities/station.dart';
import '../../domain/entities/station_proximity_alert.dart';
import '../providers/alerts_providers.dart';

/// Modal bottom sheet allowing commuters to create or customize a station proximity alarm.
class SetAlertSheet extends ConsumerStatefulWidget {
  final Station? preselectedStation;

  const SetAlertSheet({super.key, this.preselectedStation});

  static Future<void> show(
    BuildContext context, {
    Station? preselectedStation,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SetAlertSheet(preselectedStation: preselectedStation),
    );
  }

  @override
  ConsumerState<SetAlertSheet> createState() => _SetAlertSheetState();
}

class _SetAlertSheetState extends ConsumerState<SetAlertSheet> {
  Station? _selectedStation;
  double _radiusMeters = 1000.0;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedStation = widget.preselectedStation;
  }

  Future<void> _pickStation() async {
    final l10n = context.l10n;
    final picked = await StationPickerSheet.show(
      context,
      title: l10n.selectStationTitle,
      currentSelection: _selectedStation,
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedStation = picked;
      });
    }
  }

  Future<void> _saveAlert() async {
    final station = _selectedStation;
    if (station == null) return;

    setState(() => _isSaving = true);

    final alert = StationProximityAlert(
      id: 'alert_${station.id}_${DateTime.now().millisecondsSinceEpoch}',
      stationId: station.id,
      stationName: station.nameEn,
      stationCode: station.code,
      latitude: station.latitude,
      longitude: station.longitude,
      radiusMeters: _radiusMeters,
      createdAt: DateTime.now(),
    );

    await ref.read(alertsRepositoryProvider).saveAlert(alert);

    if (mounted) {
      final l10n = context.l10n;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.alertCreatedSuccess),
          backgroundColor: AppColors.primaryBlue,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Header
            Row(
              children: [
                const Icon(
                  Icons.alarm_add_rounded,
                  color: AppColors.primaryBlue,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.setStationAlert,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Station Selector Card
            InkWell(
              onTap: _pickStation,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                  ),
                  color: theme.colorScheme.surface,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.place_outlined,
                      color: AppColors.primaryBlue,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _selectedStation != null
                                ? '${_selectedStation!.nameEn} (${_selectedStation!.code})'
                                : l10n.selectStationTitle,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: _selectedStation != null
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: _selectedStation != null
                                  ? theme.textTheme.bodyLarge?.color
                                  : Colors.grey,
                            ),
                          ),
                          if (_selectedStation != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              '${_selectedStation!.nameMr} • ${_selectedStation!.nameHi}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Radius Selection Section
            Text(
              l10n.alertRadius,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SegmentedButton<double>(
              segments: [
                ButtonSegment(
                  value: 500.0,
                  label: Text(l10n.radius500m),
                  icon: const Icon(Icons.near_me_outlined, size: 16),
                ),
                ButtonSegment(
                  value: 1000.0,
                  label: Text(l10n.radius1000m),
                  icon: const Icon(Icons.location_on_outlined, size: 16),
                ),
                ButtonSegment(
                  value: 2000.0,
                  label: Text(l10n.radius2000m),
                  icon: const Icon(Icons.radar_outlined, size: 16),
                ),
              ],
              selected: {_radiusMeters},
              onSelectionChanged: (set) {
                if (set.isNotEmpty) {
                  setState(() => _radiusMeters = set.first);
                }
              },
            ),
            const SizedBox(height: 28),
            // Submit Button
            FilledButton.icon(
              onPressed: (_selectedStation == null || _isSaving)
                  ? null
                  : _saveAlert,
              icon: _isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.notifications_active),
              label: Text(l10n.addAlert),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
