import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Live train approach countdown and destination alarm armed card matching Stitch Screen 1.
class LiveAlarmTrackerCard extends StatefulWidget {
  final String trainNumber;
  final String trainRoute;
  final String targetStationName;
  final String targetStationCode;
  final String triggerStation;
  final double distanceKm;
  final int minutesRemaining;

  const LiveAlarmTrackerCard({
    super.key,
    this.trainNumber = 'VR90021 Fast',
    this.trainRoute = 'Virar → Churchgate',
    this.targetStationName = 'Churchgate',
    this.targetStationCode = 'CCG',
    this.triggerStation = 'Marine Lines (1 stop prior)',
    this.distanceKm = 1.8,
    this.minutesRemaining = 3,
  });

  @override
  State<LiveAlarmTrackerCard> createState() => _LiveAlarmTrackerCardState();
}

class _LiveAlarmTrackerCardState extends State<LiveAlarmTrackerCard> {
  bool _chimeEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // 1. Live Trip Approach Countdown Card
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: theme.colorScheme.outlineVariant.withAlpha(60),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.stitchSecondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.trainNumber,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.stitchPrimary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '• ${widget.trainRoute}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.stitchPrimary.withAlpha(20),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'APPROACHING',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.stitchPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E293B)
                              : AppColors.stitchSurfaceContainerLow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Next Stop Trigger',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${widget.distanceKm} km to Marine Lines',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E293B)
                              : AppColors.stitchSurfaceContainerLow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Estimated Arrival',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Next Stop in ${widget.minutesRemaining} min',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: AppColors.stitchSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // 2. Destination Alarm System Card (Section 8 Safe Commute)
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: AppColors.stitchSecondary.withAlpha(80),
              width: 1.2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.stitchSecondary.withAlpha(25),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_active,
                            color: AppColors.stitchSecondary,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Destination Alarm ACTIVE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Target: ${widget.targetStationName} (${widget.targetStationCode})',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.stitchSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.stitchTertiaryFixed,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'ARMED',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF002111),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1E293B)
                        : AppColors.stitchSurfaceContainerLow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.alarm_on,
                                size: 16,
                                color: AppColors.stitchSecondary,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Trigger proximity:',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Text(
                            widget.triggerStation,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.my_location,
                                size: 16,
                                color: AppColors.stitchTertiary,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Location Accuracy:',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Text(
                            'High Accuracy (±14m)',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.stitchTertiary,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.headphones,
                                size: 16,
                                color: AppColors.stitchPrimary,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Vibrate & Earphone Chime',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () =>
                                setState(() => _chimeEnabled = !_chimeEnabled),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 40,
                              height: 22,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: _chimeEnabled
                                    ? AppColors.stitchPrimary
                                    : Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: _chimeEnabled
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
