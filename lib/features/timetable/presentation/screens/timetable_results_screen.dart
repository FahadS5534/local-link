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

/// Displays timetable results and journey options between origin and destination.
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
          // Filter Chips (All, Fast, Slow)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                FilterChip(
                  label: Text(l10n.filterAll),
                  selected: _filter == ServiceFilter.all,
                  onSelected: (val) {
                    if (val) setState(() => _filter = ServiceFilter.all);
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.filterFast),
                  selected: _filter == ServiceFilter.fast,
                  onSelected: (val) {
                    if (val) setState(() => _filter = ServiceFilter.fast);
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.filterSlow),
                  selected: _filter == ServiceFilter.slow,
                  onSelected: (val) {
                    if (val) setState(() => _filter = ServiceFilter.slow);
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Route list
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
                // Apply filter
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
                  separatorBuilder: (ctx, i) => const SizedBox(height: 12),
                  itemBuilder: (ctx, index) {
                    final plan = filtered[index];
                    return _RoutePlanCard(
                      plan: plan,
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
  final Color lineColor;

  const _RoutePlanCard({required this.plan, required this.lineColor});

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

    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withAlpha(80)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Line header bar
          Container(height: 4, color: widget.lineColor),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Fast/Slow badge, Direct/Transfer badge, Duration
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isFast
                            ? AppColors.westernLine.withAlpha(25)
                            : AppColors.centralLine.withAlpha(25),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isFast ? l10n.fastTrainBadge : l10n.slowTrainBadge,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: isFast
                              ? AppColors.westernLine
                              : AppColors.centralLine,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: plan.isDirect
                            ? AppColors.freshReportGreen.withAlpha(25)
                            : AppColors.harbourLine.withAlpha(30),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        plan.isDirect
                            ? l10n.directRouteBadge
                            : l10n.transferRouteBadge,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: plan.isDirect
                              ? AppColors.freshReportGreen
                              : AppColors.harbourLine,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Total Duration
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          l10n.durationFormat(plan.totalDurationMinutes),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // Departure & Arrival times row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.legs.first.departureTimeFormatted,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          plan.origin.localizedName(locale),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 24,
                      color: Colors.grey,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          plan.legs.last.arrivalTimeFormatted,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          plan.destination.localizedName(locale),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                // Transfer junction info banner if applicable
                if (!plan.isDirect && plan.transferStation != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer.withAlpha(70),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.swap_horiz, size: 16),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${l10n.transferAt(plan.transferStation!.localizedName(locale))} (${plan.transferBufferMinutes ?? 8} min buffer)',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                // Train number and Expand Stops toggle
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
                // Expanded stops view
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
    );
  }
}
