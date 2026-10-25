import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../commute/domain/entities/journey_history_entry.dart';
import '../../commute/domain/entities/saved_journey.dart';
import '../../commute/presentation/providers/commute_providers.dart';
import '../../crowd/presentation/providers/crowd_providers.dart';
import '../../timetable/domain/entities/station.dart';
import '../../timetable/presentation/providers/timetable_providers.dart';
import '../../timetable/presentation/screens/timetable_results_screen.dart';
import 'widgets/station_picker_sheet.dart';

/// Primary search and commuter dashboard screen.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  Station? _origin;
  Station? _destination;

  @override
  void initState() {
    super.initState();
    // Default initial stations for quick start
    _initDefaults();
  }

  Future<void> _initDefaults() async {
    final repo = ref.read(timetableRepositoryProvider);
    final ccg = await repo.getStationByCode('CCG');
    final bvi = await repo.getStationByCode('BVI');
    if (mounted) {
      setState(() {
        _origin = ccg;
        _destination = bvi;
      });
    }
  }

  void _swapStations() {
    setState(() {
      final temp = _origin;
      _origin = _destination;
      _destination = temp;
    });
  }

  Future<void> _selectOrigin() async {
    final selected = await StationPickerSheet.show(
      context,
      title: context.l10n.originPlaceholder,
      currentSelection: _origin,
    );
    if (selected != null && mounted) {
      setState(() => _origin = selected);
    }
  }

  Future<void> _selectDestination() async {
    final selected = await StationPickerSheet.show(
      context,
      title: context.l10n.destinationPlaceholder,
      currentSelection: _destination,
    );
    if (selected != null && mounted) {
      setState(() => _destination = selected);
    }
  }

  void _onSearch() {
    if (_origin == null || _destination == null) return;

    // Record into local search history
    ref
        .read(savedJourneysRepositoryProvider)
        .recordJourneyHistory(
          JourneyHistoryEntry(
            id: 'hist_${DateTime.now().millisecondsSinceEpoch}',
            originStationId: _origin!.id,
            destinationStationId: _destination!.id,
            estimatedDurationMinutes: 45,
            queriedAt: DateTime.now(),
          ),
        );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => TimetableResultsScreen(
          origin: _origin!,
          destination: _destination!,
        ),
      ),
    );
  }

  Future<void> _saveCurrentJourney() async {
    if (_origin == null || _destination == null) return;

    final id = 'saved_${_origin!.code}_${_destination!.code}';
    final journey = SavedJourney(
      id: id,
      label: '${_origin!.code} ⇄ ${_destination!.code}',
      originStationId: _origin!.id,
      destinationStationId: _destination!.id,
      isPinned: true,
      createdAt: DateTime.now(),
    );

    await ref.read(savedJourneysRepositoryProvider).saveJourney(journey);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Saved ${_origin!.code} → ${_destination!.code} to My Commutes!',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _loadRoute(String originId, String destId) async {
    final repo = ref.read(timetableRepositoryProvider);
    final o = await repo.getStationById(originId);
    final d = await repo.getStationById(destId);
    if (o != null && d != null && mounted) {
      setState(() {
        _origin = o;
        _destination = d;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);

    final savedJourneysAsync = ref.watch(savedJourneysStreamProvider);
    final historyAsync = ref.watch(journeyHistoryStreamProvider);
    final advisoriesAsync = ref.watch(activeAdvisoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.searchScreenTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.smart_toy_outlined),
            tooltip: 'Journey Assistant',
            onPressed: () => context.push('/assistant'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Chip(
              avatar: const Icon(
                Icons.offline_pin,
                size: 16,
                color: AppColors.freshReportGreen,
              ),
              label: Text(
                l10n.offlineBadge,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.freshReportGreen,
                ),
              ),
              backgroundColor: AppColors.freshReportGreen.withAlpha(25),
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 4),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. Active Service Advisory / Disruption Alert Banner
          advisoriesAsync.when(
            data: (advisories) {
              if (advisories.isEmpty) return const SizedBox.shrink();
              final adv = advisories.first;
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade700, width: 1.2),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.amber.shade800,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            adv.localizedTitle(locale),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.amber.shade900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            adv.localizedDescription(locale),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (error, stack) => const SizedBox.shrink(),
          ),

          // 2. Station Selection Card
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
                children: [
                  // Origin Station Input Tile
                  _StationPickerTile(
                    icon: Icons.trip_origin,
                    iconColor: AppColors.westernLine,
                    label: l10n.originPlaceholder,
                    stationCode: _origin?.code ?? 'CCG',
                    stationName: _origin?.localizedName(locale) ?? 'Churchgate',
                    onTap: _selectOrigin,
                  ),
                  const Divider(height: 16),
                  // Swap Stations Button & Save Journey action
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton.outlined(
                        tooltip: 'Save to My Commutes',
                        icon: const Icon(Icons.bookmark_add_outlined, size: 20),
                        onPressed: _origin != null && _destination != null
                            ? _saveCurrentJourney
                            : null,
                      ),
                      Semantics(
                        button: true,
                        label: l10n.swapStationsTooltip,
                        child: IconButton.filledTonal(
                          tooltip: l10n.swapStationsTooltip,
                          icon: const Icon(Icons.swap_vert),
                          onPressed: _swapStations,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 16),
                  // Destination Station Input Tile
                  _StationPickerTile(
                    icon: Icons.place,
                    iconColor: AppColors.centralLine,
                    label: l10n.destinationPlaceholder,
                    stationCode: _destination?.code ?? 'BVI',
                    stationName:
                        _destination?.localizedName(locale) ?? 'Borivali',
                    onTap: _selectDestination,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),

          // 3. Search Action button
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: _origin != null && _destination != null
                  ? _onSearch
                  : null,
              icon: const Icon(Icons.directions_subway),
              label: Text(
                l10n.searchButtonLabel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 4. Saved Journeys ("My Commutes")
          savedJourneysAsync.when(
            data: (savedList) {
              if (savedList.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Saved Commutes',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.star, size: 18, color: Colors.amber),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: savedList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemBuilder: (context, i) {
                        final j = savedList[i];
                        return ActionChip(
                          avatar: const Icon(
                            Icons.directions_railway,
                            size: 16,
                          ),
                          label: Text(j.label),
                          onPressed: () => _loadRoute(
                            j.originStationId,
                            j.destinationStationId,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (error, stack) => const SizedBox.shrink(),
          ),

          // 5. Major Junction Stations Header & Chips
          Text(
            l10n.majorJunctions,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _JunctionChip(
                code: 'DDR',
                name: 'Dadar',
                lines: const ['WR', 'CR'],
                onTap: () async {
                  final repo = ref.read(timetableRepositoryProvider);
                  final station = await repo.getStationByCode('DDR');
                  if (station != null && mounted) {
                    setState(() => _destination = station);
                  }
                },
              ),
              _JunctionChip(
                code: 'CSMT',
                name: 'CSMT',
                lines: const ['CR', 'HR'],
                onTap: () async {
                  final repo = ref.read(timetableRepositoryProvider);
                  final station = await repo.getStationByCode('CSMT');
                  if (station != null && mounted) {
                    setState(() => _destination = station);
                  }
                },
              ),
              _JunctionChip(
                code: 'CCG',
                name: 'Churchgate',
                lines: const ['WR'],
                onTap: () async {
                  final repo = ref.read(timetableRepositoryProvider);
                  final station = await repo.getStationByCode('CCG');
                  if (station != null && mounted) {
                    setState(() => _destination = station);
                  }
                },
              ),
              _JunctionChip(
                code: 'BVI',
                name: 'Borivali',
                lines: const ['WR'],
                onTap: () async {
                  final repo = ref.read(timetableRepositoryProvider);
                  final station = await repo.getStationByCode('BVI');
                  if (station != null && mounted) {
                    setState(() => _destination = station);
                  }
                },
              ),
              _JunctionChip(
                code: 'TNA',
                name: 'Thane',
                lines: const ['CR', 'T-HR'],
                onTap: () async {
                  final repo = ref.read(timetableRepositoryProvider);
                  final station = await repo.getStationByCode('TNA');
                  if (station != null && mounted) {
                    setState(() => _destination = station);
                  }
                },
              ),
              _JunctionChip(
                code: 'KYN',
                name: 'Kalyan',
                lines: const ['CR'],
                onTap: () async {
                  final repo = ref.read(timetableRepositoryProvider);
                  final station = await repo.getStationByCode('KYN');
                  if (station != null && mounted) {
                    setState(() => _destination = station);
                  }
                },
              ),
              _JunctionChip(
                code: 'CLA',
                name: 'Kurla',
                lines: const ['CR', 'HR'],
                onTap: () async {
                  final repo = ref.read(timetableRepositoryProvider);
                  final station = await repo.getStationByCode('CLA');
                  if (station != null && mounted) {
                    setState(() => _destination = station);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 6. Recent Journey History
          historyAsync.when(
            data: (historyList) {
              if (historyList.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Searches',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(savedJourneysRepositoryProvider)
                              .clearJourneyHistory();
                        },
                        child: const Text(
                          'Clear',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ...historyList.take(4).map((entry) {
                    return ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.history, size: 20),
                      title: Text(
                        '${entry.originStationId.replaceFirst('ST_', '')} → ${entry.destinationStationId.replaceFirst('ST_', '')}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.chevron_right, size: 18),
                      onTap: () => _loadRoute(
                        entry.originStationId,
                        entry.destinationStationId,
                      ),
                    );
                  }),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (error, stack) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _StationPickerTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String stationCode;
  final String stationName;
  final VoidCallback onTap;

  const _StationPickerTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.stationCode,
    required this.stationName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$label: $stationName ($stationCode)',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: const BoxConstraints(minHeight: 56),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$stationName ($stationCode)',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class _JunctionChip extends StatelessWidget {
  final String code;
  final String name;
  final List<String> lines;
  final VoidCallback onTap;

  const _JunctionChip({
    required this.code,
    required this.name,
    required this.lines,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$name junction ($code)',
      child: ActionChip(
        avatar: CircleAvatar(
          radius: 10,
          backgroundColor: lines.contains('WR')
              ? AppColors.westernLine
              : AppColors.centralLine,
          child: Text(
            lines.first,
            style: const TextStyle(
              fontSize: 8,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        label: Text('$name ($code)'),
        onPressed: onTap,
      ),
    );
  }
}
