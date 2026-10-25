import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../timetable/domain/entities/stop_schedule.dart';

/// Interactive widget displaying the sequential stops of a train trip.
class IntermediateStopsWidget extends StatelessWidget {
  final List<StopSchedule> stops;
  final bool isFast;

  const IntermediateStopsWidget({
    super.key,
    required this.stops,
    this.isFast = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    if (stops.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.linear_scale, size: 18),
              const SizedBox(width: 8),
              Text(
                l10n.stopsCount(stops.length),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: stops.length,
            itemBuilder: (ctx, index) {
              final stop = stops[index];
              final isFirst = index == 0;
              final isLast = index == stops.length - 1;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    // Timeline track
                    Column(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isFirst || isLast
                                ? theme.colorScheme.primary
                                : theme.colorScheme.outlineVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // Station details
                    Expanded(
                      child: Text(
                        stop.stationId.replaceFirst('ST_', ''),
                        style: TextStyle(
                          fontWeight: (isFirst || isLast)
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    // Platform badge if available
                    if (stop.platform != null) ...[
                      Text(
                        'P${stop.platform}',
                        style: TextStyle(
                          fontSize: 11,
                          color: theme.colorScheme.outline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    // Time
                    Text(
                      stop.departureTimeFormatted,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
