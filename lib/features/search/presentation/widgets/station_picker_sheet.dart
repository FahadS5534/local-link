import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../timetable/domain/entities/station.dart';
import '../../../timetable/presentation/providers/timetable_providers.dart';

/// Modal bottom sheet allowing commuters to search and select a station.
class StationPickerSheet extends ConsumerStatefulWidget {
  final String title;
  final Station? currentSelection;

  const StationPickerSheet({
    super.key,
    required this.title,
    this.currentSelection,
  });

  static Future<Station?> show(
    BuildContext context, {
    required String title,
    Station? currentSelection,
  }) {
    return showModalBottomSheet<Station>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) =>
          StationPickerSheet(title: title, currentSelection: currentSelection),
    );
  }

  @override
  ConsumerState<StationPickerSheet> createState() => _StationPickerSheetState();
}

class _StationPickerSheetState extends ConsumerState<StationPickerSheet> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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

  String _lineBadge(RailwayLineId line) {
    switch (line) {
      case RailwayLineId.western:
        return 'WR';
      case RailwayLineId.centralMain:
        return 'CR';
      case RailwayLineId.harbour:
        return 'HR';
      case RailwayLineId.transHarbour:
        return 'T-HR';
      case RailwayLineId.uran:
        return 'UR';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);

    // Watch station search results or all stations
    final stationsAsync = _searchQuery.isEmpty
        ? ref.watch(allStationsProvider)
        : ref.watch(stationSearchProvider(_searchQuery));

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: 'Close',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Search Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Semantics(
                label: l10n.stationSearchPlaceholder,
                textField: true,
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: l10n.stationSearchPlaceholder,
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (val) {
                    setState(() => _searchQuery = val.trim());
                  },
                ),
              ),
            ),
            const Divider(height: 1),
            // Station List
            Expanded(
              child: stationsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) =>
                    Center(child: Text('Error loading stations: $err')),
                data: (stations) {
                  if (stations.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.noTrainsFound,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: stations.length,
                    separatorBuilder: (ctx, i) =>
                        const Divider(height: 1, indent: 64),
                    itemBuilder: (ctx, index) {
                      final station = stations[index];
                      final isSelected =
                          widget.currentSelection?.id == station.id;

                      return Semantics(
                        button: true,
                        selected: isSelected,
                        label:
                            '${station.localizedName(locale)}, ${station.code}',
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(station),
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 56),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            color: isSelected
                                ? theme.colorScheme.primaryContainer.withAlpha(
                                    50,
                                  )
                                : null,
                            child: Row(
                              children: [
                                // Station Code Badge
                                Container(
                                  width: 48,
                                  height: 48,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: theme
                                        .colorScheme
                                        .surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    station.code,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                // Localized name and corridor badges
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        station.localizedName(locale),
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      if (locale != 'en') ...[
                                        Text(
                                          station.nameEn,
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                color:
                                                    theme.colorScheme.outline,
                                              ),
                                        ),
                                      ],
                                      const SizedBox(height: 4),
                                      Wrap(
                                        spacing: 4,
                                        children: station.lines.map((l) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _lineColor(
                                                l,
                                              ).withAlpha(30),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              _lineBadge(l),
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: _lineColor(l),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                if (station.isInterchange) ...[
                                  Chip(
                                    label: const Text(
                                      'Junction',
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    padding: EdgeInsets.zero,
                                    backgroundColor:
                                        theme.colorScheme.secondaryContainer,
                                    side: BorderSide.none,
                                  ),
                                ],
                                if (isSelected) ...[
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.check_circle,
                                    color: theme.colorScheme.primary,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
