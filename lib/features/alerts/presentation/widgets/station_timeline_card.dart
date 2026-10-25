import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Vertical Station Stop Timeline matching Stitch Screen 1.
class StationTimelineCard extends StatelessWidget {
  const StationTimelineCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final stops = [
      const _StopItem(
        stationName: 'Borivali',
        stationCode: 'बोरीवली (BVI)',
        detail: 'Origin • Departed 08:42 AM',
        isCompleted: true,
      ),
      const _StopItem(
        stationName: 'Andheri',
        stationCode: 'अंधेरी (ADH)',
        detail: 'PF 4 • Departed 08:56 AM',
        isCompleted: true,
      ),
      const _StopItem(
        stationName: 'Bandra',
        stationCode: 'वांद्रे (BA)',
        detail: 'PF 3 • Departed 09:07 AM',
        isCompleted: true,
      ),
      const _StopItem(
        stationName: 'Dadar',
        stationCode: 'दादर (DDR)',
        detail: 'PF 3 • Passed 09:15 AM (FOB connected)',
        isCompleted: true,
        isInterchange: true,
      ),
      const _StopItem(
        stationName: 'Mumbai Central',
        stationCode: 'मुंबई सेंट्रल (MMCT)',
        detail: 'PF 2 • Departed 09:23 AM',
        isCompleted: true,
      ),
      const _StopItem(
        stationName: 'Marine Lines',
        stationCode: 'मरीन लाइन्स (MEL)',
        detail: 'Approaching • Alarm Trigger Point (1.8 km)',
        isApproaching: true,
      ),
      const _StopItem(
        stationName: 'Churchgate',
        stationCode: 'चर्चगेट (CCG)',
        detail: 'Target Destination • ETA 09:30 AM (PF 2)',
        isTarget: true,
      ),
    ];

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withAlpha(60)),
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
                    const Icon(
                      Icons.route,
                      size: 20,
                      color: AppColors.stitchPrimary,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Station Stop Timeline',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Live Western Line tracking',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 11,
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
                    color: AppColors.stitchSurfaceContainerLow,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    '14 Stn Dist.',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.stitchPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Timeline Tree
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stops.length,
              itemBuilder: (context, i) {
                final s = stops[i];
                final isLast = i == stops.length - 1;

                final Color dotColor;
                final Widget dotIcon;

                if (s.isTarget) {
                  dotColor = AppColors.stitchPrimary;
                  dotIcon = const Icon(
                    Icons.flag,
                    color: Colors.white,
                    size: 11,
                  );
                } else if (s.isApproaching) {
                  dotColor = AppColors.stitchSecondary;
                  dotIcon = const Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                    size: 11,
                  );
                } else {
                  dotColor = Colors.grey.shade400;
                  dotIcon = const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 10,
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline indicator column
                    Column(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: dotColor,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: dotIcon,
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 38,
                            color: isDark
                                ? Colors.white12
                                : AppColors.stitchSurfaceContainerHigh,
                          ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                s.stationName,
                                style: TextStyle(
                                  fontWeight: s.isTarget || s.isApproaching
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                  fontSize: 13,
                                  color: s.isCompleted
                                      ? (isDark
                                            ? Colors.white60
                                            : Colors.black54)
                                      : (s.isTarget
                                            ? AppColors.stitchPrimary
                                            : (s.isApproaching
                                                  ? AppColors.stitchSecondary
                                                  : null)),
                                  decoration: s.isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                s.stationCode,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            s.detail,
                            style: TextStyle(
                              fontSize: 11,
                              color: s.isApproaching
                                  ? AppColors.stitchSecondary
                                  : theme.colorScheme.onSurfaceVariant,
                              fontWeight: s.isApproaching
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StopItem {
  final String stationName;
  final String stationCode;
  final String detail;
  final bool isCompleted;
  final bool isInterchange;
  final bool isApproaching;
  final bool isTarget;

  const _StopItem({
    required this.stationName,
    required this.stationCode,
    required this.detail,
    this.isCompleted = false,
    this.isInterchange = false,
    this.isApproaching = false,
    this.isTarget = false,
  });
}
