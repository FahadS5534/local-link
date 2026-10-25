import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../domain/entities/station_proximity_alert.dart';
import 'providers/alerts_providers.dart';
import 'widgets/set_alert_sheet.dart';

/// Screen managing station proximity alarms and geofences.
class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final alertsAsync = ref.watch(alertsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.alertsScreenTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alarm),
            tooltip: l10n.addAlert,
            onPressed: () => SetAlertSheet.show(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => SetAlertSheet.show(context),
        icon: const Icon(Icons.alarm_add_rounded),
        label: Text(l10n.addAlert),
      ),
      body: alertsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error loading alerts: $err')),
        data: (alerts) {
          if (alerts.isEmpty) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _EmptyAlertsCard(
                  onAddPressed: () => SetAlertSheet.show(context),
                ),
                const SizedBox(height: 24),
                const _HowItWorksCard(),
              ],
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
            itemCount: alerts.length + 1,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              if (index == alerts.length) {
                return const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: _HowItWorksCard(),
                );
              }

              final alert = alerts[index];
              return _AlertCard(alert: alert);
            },
          );
        },
      ),
    );
  }
}

class _AlertCard extends ConsumerWidget {
  final StationProximityAlert alert;

  const _AlertCard({required this.alert});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Color statusColor;
    final String statusLabel;

    switch (alert.status) {
      case AlertStatus.active:
        statusColor = AppColors.freshReportGreen;
        statusLabel = l10n.alertActive;
        break;
      case AlertStatus.triggered:
        statusColor = AppColors.expiringReportAmber;
        statusLabel = l10n.alertTriggered(alert.stationName);
        break;
      case AlertStatus.muted:
        statusColor = Colors.grey;
        statusLabel = l10n.alertMuted;
        break;
    }

    final radiusText = alert.radiusMeters >= 1000
        ? '${(alert.radiusMeters / 1000).toStringAsFixed(alert.radiusMeters % 1000 == 0 ? 0 : 1)} km'
        : '${alert.radiusMeters.toInt()} m';

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: alert.isActive
              ? AppColors.primaryBlue.withAlpha(80)
              : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: alert.isActive
                      ? AppColors.primaryBlue.withAlpha(25)
                      : Colors.grey.withAlpha(25),
                  child: Icon(
                    alert.isTriggered
                        ? Icons.notifications_active
                        : (alert.isActive
                              ? Icons.alarm_on_rounded
                              : Icons.alarm_off_rounded),
                    color: alert.isActive ? AppColors.primaryBlue : Colors.grey,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              alert.stationName,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkSurface
                                  : AppColors.lightSurface,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: isDark
                                    ? AppColors.darkBorder
                                    : AppColors.lightBorder,
                              ),
                            ),
                            child: Text(
                              alert.stationCode,
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            statusLabel,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.radar, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            radiusText,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: alert.isActive,
                  activeTrackColor: AppColors.primaryBlue,
                  onChanged: (val) {
                    ref
                        .read(alertsRepositoryProvider)
                        .toggleAlert(alert.id, val);
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                  ),
                  tooltip: l10n.deleteAlert,
                  onPressed: () async {
                    await ref
                        .read(alertsRepositoryProvider)
                        .deleteAlert(alert.id);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.alertDeletedSuccess),
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyAlertsCard extends StatelessWidget {
  final VoidCallback onAddPressed;

  const _EmptyAlertsCard({required this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: AppColors.primaryBlue.withAlpha(25),
            child: const Icon(
              Icons.notifications_active_outlined,
              size: 36,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.noActiveAlerts, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            l10n.alertsDescription,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: onAddPressed,
            icon: const Icon(Icons.alarm_add_rounded),
            label: Text(l10n.addAlert),
          ),
        ],
      ),
    );
  }
}

class _HowItWorksCard extends StatelessWidget {
  const _HowItWorksCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 20,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: 8),
                Text(
                  'How Proximity Alarms Work',
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 12),
            const _BenefitRow(
              icon: Icons.battery_charging_full,
              title: 'Battery Efficient',
              description:
                  'Uses low-power geofencing only for your active journey.',
            ),
            const SizedBox(height: 10),
            const _BenefitRow(
              icon: Icons.lock_outline,
              title: '100% Private',
              description:
                  'GPS coordinates are evaluated strictly on your device.',
            ),
            const SizedBox(height: 10),
            const _BenefitRow(
              icon: Icons.volume_up,
              title: 'Loud Awakening',
              description:
                  'Audible tone and distinct vibration wake you before your stop.',
            ),
          ],
        ),
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _BenefitRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(description, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
