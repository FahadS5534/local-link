import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../crowd/presentation/widgets/coach_crowding_card.dart';
import '../../../routing/presentation/providers/routing_providers.dart';
import '../../../timetable/domain/entities/route_plan.dart';
import '../../../timetable/domain/entities/station.dart';
import '../widgets/intermediate_stops_widget.dart';

enum ServiceFilter { all, fast, slow }

/// Displays timetable results and journey options between origin and destination aligned with Stitch design.
class TimetableResultsScreen extends ConsumerStatefulWidget {
  final Station origin;
  final Station destination;

  const TimetableResultsScreen({
    super.key,
    required this.origin,
    required this.destination,
  });

  @override
  ConsumerState<TimetableResultsScreen> createState() =>
      _TimetableResultsScreenState();
}

class _TimetableResultsScreenState
    extends ConsumerState<TimetableResultsScreen> {
  ServiceFilter _filter = ServiceFilter.all;

  Color _lineColor(RailwayLineId line) {
    switch (line) {
      case RailwayLineId.western:
        return AppColors.westernLine;
      case RailwayLineId.centralMain:
        return AppColors.centralLine;
      case RailwayLineId.harbour:
        return AppColors.harbourLine;
      case RailwayLineId.transHarbour:
      case RailwayLineId.uran:
        return AppColors.transHarbourLine;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);

    final params = (
      originId: widget.origin.id,
      destinationId: widget.destination.id,
      departureMinutes: null,
      weekday: null,
      transferBufferMinutes: 8,
    );

    final routesAsync = ref.watch(journeyPlannerProvider(params));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.origin.localizedName(locale)} → ${widget.destination.localizedName(locale)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '${widget.origin.code} to ${widget.destination.code}',
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 1. Route Selector Sticky Headplate (Stitch Screen 2 lines 12-28)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: AppColors.stitchSurfaceContainerLow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColors.stitchSecondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.origin.code} ➔ ${widget.destination.code}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.stitchOnSurface,
                          ),
                        ),
                        Text(
                          '${widget.origin.localizedName(locale)} ➔ ${widget.destination.localizedName(locale)} • Suburban Rail',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.stitchOnSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.stitchSurfaceContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.swap_vert,
                    size: 20,
                    color: AppColors.stitchPrimary,
                  ),
                ),
              ],
            ),
          ),

          // 2. Filter Chips (All, Fast, Slow)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                FilterChip(
                  label: Text(l10n.filterAll),
                  selected: _filter == ServiceFilter.all,
                  selectedColor: AppColors.stitchPrimary,
                  labelStyle: TextStyle(
                    color: _filter == ServiceFilter.all
                        ? Colors.white
                        : AppColors.stitchOnSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  onSelected: (val) {
                    if (val) setState(() => _filter = ServiceFilter.all);
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.filterFast),
                  selected: _filter == ServiceFilter.fast,
                  selectedColor: AppColors.stitchPrimary,
                  labelStyle: TextStyle(
                    color: _filter == ServiceFilter.fast
                        ? Colors.white
                        : AppColors.stitchOnSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  onSelected: (val) {
                    if (val) setState(() => _filter = ServiceFilter.fast);
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.filterSlow),
                  selected: _filter == ServiceFilter.slow,
                  selectedColor: AppColors.stitchPrimary,
                  labelStyle: TextStyle(
                    color: _filter == ServiceFilter.slow
                        ? Colors.white
                        : AppColors.stitchOnSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  onSelected: (val) {
                    if (val) setState(() => _filter = ServiceFilter.slow);
                  },
                ),
              ],
            ),
          ),

          // 3. Time Window Selector Banner (Stitch Screen 2 lines 30-39)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.stitchSurfaceContainerLowest,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.stitchTransitHairline),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      size: 16,
                      color: AppColors.stitchPrimary,
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Morning Peak Window',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.stitchOnSurface,
                          ),
                        ),
                        Text(
                          '08:30 AM – 09:30 AM • Regular frequency',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.stitchOnSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.stitchSurfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Active',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.stitchPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Divider(height: 1),

          // 4. Route list
          Expanded(
            child: routesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.train_outlined,
                        size: 64,
                        color: theme.colorScheme.outline,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.noTrainsFound,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              data: (plans) {
                final filtered = plans.where((p) {
                  if (_filter == ServiceFilter.all) return true;
                  final isFast = p.legs.any((l) => l.trip.isFast);
                  if (_filter == ServiceFilter.fast) return isFast;
                  return !isFast;
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        l10n.noTrainsFound,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  separatorBuilder: (ctx, i) => const SizedBox(height: 14),
                  itemBuilder: (ctx, index) {
                    final plan = filtered[index];
                    return _RoutePlanCard(
                      plan: plan,
                      index: index,
                      lineColor: _lineColor(plan.legs.first.trip.lineId),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RoutePlanCard extends StatefulWidget {
  final RoutePlan plan;
  final int index;
  final Color lineColor;

  const _RoutePlanCard({
    required this.plan,
    required this.index,
    required this.lineColor,
  });

  @override
  State<_RoutePlanCard> createState() => _RoutePlanCardState();
}

class _RoutePlanCardState extends State<_RoutePlanCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);
    final plan = widget.plan;
    final isFast = plan.legs.any((l) => l.trip.isFast);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.stitchSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.stitchTransitHairline),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 5,
              child: Container(color: widget.lineColor),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Recommended Pill + On Schedule + Alarm icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: isFast
                                  ? AppColors.stitchSecondaryFixed
                                  : AppColors.stitchSurfaceContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                if (isFast) ...[
                                  const Icon(
                                    Icons.bolt,
                                    size: 13,
                                    color: AppColors.stitchSecondary,
                                  ),
                                  const SizedBox(width: 3),
                                ],
                                Text(
                                  isFast
                                      ? l10n.fastTrainBadge
                                      : l10n.slowTrainBadge,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: isFast
                                        ? AppColors.stitchSecondary
                                        : AppColors.stitchPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.stitchTertiaryFixed.withAlpha(
                                80,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 12,
                                  color: AppColors.stitchTertiary,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  'On Schedule (वेळेवर)',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.stitchTertiary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Alarm set for ${plan.destination.localizedName(locale)}!',
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.add_alarm,
                            size: 18,
                            color: AppColors.stitchOnSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Departure / Duration Bridge / Arrival Matrix
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Departure block
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan.legs.first.departureTimeFormatted,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.stitchPrimary,
                            ),
                          ),
                          Text(
                            plan.origin.localizedName(locale),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.stitchOnSurfaceVariant,
                            ),
                          ),
                        ],
                      ),

                      // Graphical Duration Bridge
                      Column(
                        children: [
                          Text(
                            l10n.durationFormat(plan.totalDurationMinutes),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.stitchPrimary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: AppColors.stitchSecondary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                width: 44,
                                height: 2,
                                color: AppColors.stitchSecondaryContainer,
                              ),
                              Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: AppColors.stitchPrimary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${plan.legs.first.intermediateStops.length + 1} stops',
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.stitchOnSurfaceVariant,
                            ),
                          ),
                        ],
                      ),

                      // Arrival & Platform Box
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            plan.legs.last.arrivalTimeFormatted,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.stitchOnSurface,
                            ),
                          ),
                          Text(
                            plan.destination.localizedName(locale),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.stitchOnSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.stitchSurfaceContainerHigh,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'PF ${plan.legs.first.trip.trainNumber.hashCode % 4 + 1}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.stitchPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Train Attributes & 4-tier Crowd Meter Row
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.stitchSurfaceContainerLow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                color: isFast
                                    ? AppColors.stitchSecondary
                                    : AppColors.stitchPrimary,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                isFast ? 'F' : 'S',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isFast
                                  ? '${l10n.fastTrainBadge} LOCAL'
                                  : '${l10n.slowTrainBadge} LOCAL',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.stitchOnSurface,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              '• 15 Coach',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.stitchOnSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        // 4-tier Crowd Meter with micro bars
                        Row(
                          children: [
                            Text(
                              isFast ? 'Heavy (गर्दी)' : 'Moderate (मध्यम)',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isFast
                                    ? AppColors.stitchSecondary
                                    : AppColors.stitchPrimary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 2.5,
                                  height: 6,
                                  color: AppColors.stitchSecondary,
                                ),
                                const SizedBox(width: 1.5),
                                Container(
                                  width: 2.5,
                                  height: 10,
                                  color: AppColors.stitchSecondary,
                                ),
                                const SizedBox(width: 1.5),
                                Container(
                                  width: 2.5,
                                  height: 12,
                                  color: isFast
                                      ? AppColors.stitchSecondary
                                      : Colors.grey.shade300,
                                ),
                                const SizedBox(width: 1.5),
                                Container(
                                  width: 2.5,
                                  height: 14,
                                  color: isFast
                                      ? AppColors.stitchSecondary.withAlpha(100)
                                      : Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Expand Stops Toggle button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Train #${plan.legs.first.trip.trainNumber}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                      TextButton.icon(
                        icon: Icon(
                          _expanded ? Icons.expand_less : Icons.expand_more,
                          size: 18,
                        ),
                        label: Text(
                          _expanded
                              ? l10n.hideIntermediateStops
                              : l10n.viewIntermediateStops,
                        ),
                        onPressed: () {
                          setState(() => _expanded = !_expanded);
                        },
                      ),
                    ],
                  ),

                  // Expanded Stops View
                  if (_expanded) ...[
                    const Divider(height: 16),
                    for (var i = 0; i < plan.legs.length; i++) ...[
                      if (plan.legs.length > 1) ...[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            'Leg ${i + 1}: ${plan.legs[i].originStation.nameEn} → ${plan.legs[i].destinationStation.nameEn}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                      IntermediateStopsWidget(
                        stops: plan.legs[i].intermediateStops,
                        isFast: plan.legs[i].trip.isFast,
                      ),
                      if (i < plan.legs.length - 1) const SizedBox(height: 8),
                    ],
                    const SizedBox(height: 12),
                    CoachCrowdingCard(
                      tripId: plan.legs.first.trip.id,
                      stationId: plan.origin.id,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
