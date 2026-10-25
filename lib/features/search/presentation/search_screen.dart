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

/// Primary search and commuter dashboard screen aligned with Stitch Workspace Design.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  Station? _origin;
  Station? _destination;
  String _selectedCorridor = 'all';
  int _selectedServiceFilterIndex = 0;

  @override
  void initState() {
    super.initState();
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
                color: AppColors.stitchTertiary,
              ),
              label: Text(
                l10n.offlineBadge,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.stitchTertiary,
                ),
              ),
              backgroundColor: AppColors.stitchTertiaryFixed.withAlpha(80),
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 4),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. Verified Timetable Offline Ribbon
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.stitchSurfaceContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.offline_pin,
                      size: 16,
                      color: AppColors.stitchTertiary,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Timetable: Offline (Nov 2024 V2.4) • Verified',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.stitchOnSurface,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.stitchTertiary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Active',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.stitchTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2. Active Service Advisory / Disruption Alert Banner
          advisoriesAsync.when(
            data: (advisories) {
              if (advisories.isEmpty) {
                return const SizedBox.shrink();
              }
              final adv = advisories.first;
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.stitchSurfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.stitchSecondary),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 4,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.stitchSecondary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: AppColors.stitchSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            adv.localizedTitle(locale),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: AppColors.stitchSecondary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            adv.localizedDescription(locale),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.stitchOnSurface,
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

          // 3. Primary Station Selection Card (Targeted by search_flow_test.dart)
          Card(
            elevation: 1,
            color: AppColors.stitchSurfaceContainerLowest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.stitchTransitHairline),
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
                    corridorBadge: 'WR',
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
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.stitchPrimary,
                            foregroundColor: Colors.white,
                          ),
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
                    corridorBadge: 'WR',
                    onTap: _selectDestination,
                  ),
                  const SizedBox(height: 14),
                  // Service Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _ServicePill(
                          label: 'All Trains',
                          isSelected: _selectedServiceFilterIndex == 0,
                          onTap: () =>
                              setState(() => _selectedServiceFilterIndex = 0),
                        ),
                        const SizedBox(width: 8),
                        _ServicePill(
                          label: 'Fast Only (जलद)',
                          isSelected: _selectedServiceFilterIndex == 1,
                          onTap: () =>
                              setState(() => _selectedServiceFilterIndex = 1),
                        ),
                        const SizedBox(width: 8),
                        _ServicePill(
                          label: 'AC Local',
                          icon: Icons.ac_unit,
                          isSelected: _selectedServiceFilterIndex == 2,
                          onTap: () =>
                              setState(() => _selectedServiceFilterIndex = 2),
                        ),
                        const SizedBox(width: 8),
                        _ServicePill(
                          label: 'Ladies Special',
                          isSelected: _selectedServiceFilterIndex == 3,
                          onTap: () =>
                              setState(() => _selectedServiceFilterIndex = 3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          // 4. Search Action CTA button (Targeted by search_flow_test.dart)
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: _origin != null && _destination != null
                  ? _onSearch
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.stitchPrimaryContainer,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
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
          const SizedBox(height: 14),

          // 5. Major Junction Stations (ActionChips for search_flow_test.dart within viewport)
          Text(
            l10n.majorJunctions,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.stitchPrimary,
            ),
          ),
          const SizedBox(height: 10),
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
            ],
          ),
          const SizedBox(height: 18),

          // 6. Corridor Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _CorridorFilterTab(
                  label: 'All Lines (सर्व)',
                  icon: Icons.hub,
                  isSelected: _selectedCorridor == 'all',
                  onTap: () => setState(() => _selectedCorridor = 'all'),
                ),
                const SizedBox(width: 8),
                _CorridorFilterTab(
                  label: 'WR Western',
                  dotColor: AppColors.westernLine,
                  isSelected: _selectedCorridor == 'WR',
                  onTap: () => setState(() => _selectedCorridor = 'WR'),
                ),
                const SizedBox(width: 8),
                _CorridorFilterTab(
                  label: 'CR Central Main',
                  dotColor: AppColors.stitchCentralOrange,
                  isSelected: _selectedCorridor == 'CR',
                  onTap: () => setState(() => _selectedCorridor = 'CR'),
                ),
                const SizedBox(width: 8),
                _CorridorFilterTab(
                  label: 'HR Harbour',
                  dotColor: AppColors.stitchHarbourCyan,
                  isSelected: _selectedCorridor == 'HR',
                  onTap: () => setState(() => _selectedCorridor = 'HR'),
                ),
                const SizedBox(width: 8),
                _CorridorFilterTab(
                  label: 'TH Trans-Harbour',
                  dotColor: AppColors.stitchTransHarbourPurple,
                  isSelected: _selectedCorridor == 'TH',
                  onTap: () => setState(() => _selectedCorridor = 'TH'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 7. Highlighted Station Dossier Card: Dadar Interchange Node
          _buildStationDossierCard(),
          const SizedBox(height: 16),

          // 8. Departure Time Planner
          _buildDeparturePlannerCard(),
          const SizedBox(height: 16),

          // 9. Next Upcoming Departure Widget
          _buildUpcomingDepartureWidget(),
          const SizedBox(height: 16),

          // 10. Saved Commute Shortcuts
          _buildSavedCommutesSection(savedJourneysAsync),
          const SizedBox(height: 16),

          // 11. Network Line Status Grid
          _buildNetworkLineStatusGrid(),
          const SizedBox(height: 16),

          // 12. Recent Search History
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
                        child: const Text('Clear All'),
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

  /// Builds the Dadar Interchange Node Dossier Card (Stitch Screen 4 lines 51-104)
  Widget _buildStationDossierCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.stitchSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.stitchTransitHairline),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.stitchSecondary,
                    AppColors.stitchCentralOrange,
                    AppColors.stitchPrimary,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Dadar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.stitchOnSurface,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'दादर',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.stitchOnSurfaceVariant,
                            ),
                          ),
                          SizedBox(width: 8),
                          _CodeBadge(code: 'DDR'),
                        ],
                      ),
                      Row(
                        children: [
                          _LineTag(code: 'WR', color: AppColors.westernLine),
                          SizedBox(width: 4),
                          Text('+', style: TextStyle(color: Colors.grey)),
                          SizedBox(width: 4),
                          _LineTag(
                            code: 'CR',
                            color: AppColors.stitchCentralOrange,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Icon(
                        Icons.sync_alt,
                        size: 15,
                        color: AppColors.stitchSecondary,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Primary Network Interchange',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.stitchSecondary,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        '• PFs 1-14',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.stitchOnSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.stitchSurfaceContainerLow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.stairs,
                              size: 16,
                              color: AppColors.stitchPrimary,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Bridge Navigation Tip (उत्तर पूल)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.stitchPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'North FOB connects WR PF 1-3 to CR PF 5-8 without descending into ticket hall congestion. Elevated skywalk direct to Tilak Bridge exit.',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.stitchOnSurfaceVariant,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildAmenityTile(
                          icon: Icons.confirmation_number,
                          title: '12 ATVMs',
                          subtitle: 'Zero Queue',
                          iconColor: AppColors.stitchPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildAmenityTile(
                          icon: Icons.stairs,
                          title: '4 Escalators',
                          subtitle: 'Central / North',
                          iconColor: AppColors.stitchPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildAmenityTile(
                          icon: Icons.groups,
                          title: 'Very Heavy',
                          subtitle: 'Rush Hour',
                          iconColor: AppColors.stitchSecondary,
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
    );
  }

  Widget _buildAmenityTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.stitchSurfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(height: 3),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.stitchOnSurface,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 9,
              color: AppColors.stitchOnSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the Departure Time Planner Card (Stitch Screen 4 lines 106-135)
  Widget _buildDeparturePlannerCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.stitchSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.stitchTransitHairline),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.more_time,
                    size: 18,
                    color: AppColors.stitchPrimary,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Plan Departure (प्रवास वेळ)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.stitchOnSurface,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: _swapStations,
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.stitchSurfaceContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.swap_vert,
                        size: 14,
                        color: AppColors.stitchPrimary,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Reverse Route',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.stitchPrimary,
                        ),
                      ),
                    ],
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
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.stitchPrimary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.stitchTertiaryFixed,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Depart Now',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Next train in 2 min',
                        style: TextStyle(fontSize: 10, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.stitchSurfaceContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: AppColors.stitchPrimary,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '08:45 AM',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.stitchPrimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Tap to pick slot',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.stitchOnSurfaceVariant,
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
    );
  }

  /// Builds Next Upcoming Departure Widget (Stitch Home lines 88-140)
  Widget _buildUpcomingDepartureWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.stitchSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.stitchTransitHairline),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.stitchTertiary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'NEXT DEPARTURE • BVI → CCG',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: AppColors.stitchOnSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.stitchSecondaryFixed,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Fast (जलद)',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.stitchSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '08:42',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.stitchPrimary,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'AM',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.stitchOnSurfaceVariant,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    '(in 6 mins)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.stitchSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.stitchSurfaceContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'PF 3',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.stitchPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  _TagBadge(text: '15 Cars'),
                  SizedBox(width: 6),
                  _TagBadge(text: '110 km/h'),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.stitchSecondaryFixed.withAlpha(120),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 3,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.stitchSecondary,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        const SizedBox(width: 2),
                        Container(
                          width: 3,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.stitchSecondary,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        const SizedBox(width: 2),
                        Container(
                          width: 3,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.stitchSecondary.withAlpha(100),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        const SizedBox(width: 2),
                        Container(
                          width: 3,
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppColors.stitchSecondary.withAlpha(50),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Moderate (मध्यम) • 42 reports',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.stitchSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 8),
          const Text(
            'Fast Stoppages:',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.stitchOnSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BVI',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.stitchPrimary,
                ),
              ),
              Text('→', style: TextStyle(color: Colors.grey, fontSize: 11)),
              Text(
                'ADH',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text('→', style: TextStyle(color: Colors.grey, fontSize: 11)),
              Text(
                'BA',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text('→', style: TextStyle(color: Colors.grey, fontSize: 11)),
              Text(
                'DDR',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text('→', style: TextStyle(color: Colors.grey, fontSize: 11)),
              Text(
                'BCT',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text('→', style: TextStyle(color: Colors.grey, fontSize: 11)),
              Text(
                'CCG',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.stitchPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds Saved Commute Shortcuts (Stitch Home lines 142-206)
  Widget _buildSavedCommutesSection(
    AsyncValue<List<SavedJourney>> savedJourneysAsync,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Saved Commutes (माझे मार्ग)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.stitchOnSurface,
              ),
            ),
            Text(
              'Frequent',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.stitchPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        savedJourneysAsync.when(
          data: (savedList) {
            if (savedList.isNotEmpty) {
              return Column(
                children: savedList.map((j) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _CommuteCard(
                      title: j.label,
                      subtitle: 'Custom commute • 45 min',
                      lineCode: 'WR',
                      eta: 'Now',
                      icon: Icons.work,
                      onTap: () =>
                          _loadRoute(j.originStationId, j.destinationStationId),
                    ),
                  );
                }).toList(),
              );
            }
            return Column(
              children: [
                _CommuteCard(
                  title: 'Borivali ⇄ Churchgate',
                  subtitle: 'Daily Work • Fast Local • 48 min',
                  lineCode: 'WR',
                  eta: '3 min',
                  icon: Icons.work,
                  onTap: () => _initDefaults(),
                ),
                const SizedBox(height: 8),
                _CommuteCard(
                  title: 'Thane ⇄ CSMT',
                  subtitle: 'Central Fast • 42 min',
                  lineCode: 'CR',
                  eta: '7 min',
                  icon: Icons.train,
                  onTap: () => _loadRoute('ST_TNA', 'ST_CSMT'),
                ),
                const SizedBox(height: 8),
                _CommuteCard(
                  title: 'Andheri ⇄ Wadala Rd',
                  subtitle: 'Harbour Link • 34 min',
                  lineCode: 'HR',
                  eta: '11 min',
                  icon: Icons.hub,
                  onTap: () => _loadRoute('ST_ADH', 'ST_VDLR'),
                ),
              ],
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (e, s) => const SizedBox.shrink(),
        ),
      ],
    );
  }

  /// Builds Network Line Status Grid (Stitch Home lines 208-242)
  Widget _buildNetworkLineStatusGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Network Line Status',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.stitchOnSurface,
              ),
            ),
            Text(
              'Live updates',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.stitchOnSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildStatusCard(
                code: 'WR',
                name: 'Western',
                status: 'Normal (+2m)',
                isNormal: true,
                color: AppColors.westernLine,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildStatusCard(
                code: 'CR',
                name: 'Central',
                status: 'Normal (+4m)',
                isNormal: true,
                color: AppColors.stitchCentralOrange,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildStatusCard(
                code: 'HR',
                name: 'Harbour',
                status: 'Block Kurla PF7',
                isNormal: false,
                color: AppColors.stitchHarbourCyan,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusCard({
    required String code,
    required String name,
    required String status,
    required bool isNormal,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.stitchSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.stitchTransitHairline),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                code,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: isNormal
                      ? AppColors.stitchTertiary
                      : AppColors.stitchSecondary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            name,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.stitchOnSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            status,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isNormal
                  ? AppColors.stitchTertiary
                  : AppColors.stitchSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// Subordinate Helper Components matching Stitch Design System
// -------------------------------------------------------------

class _StationPickerTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String stationCode;
  final String stationName;
  final String corridorBadge;
  final VoidCallback onTap;

  const _StationPickerTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.stationCode,
    required this.stationName,
    required this.corridorBadge,
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
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.stitchSurfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: AppColors.stitchOnSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$stationName ($stationCode)',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.stitchOnSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.stitchSecondaryFixed,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  corridorBadge,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.stitchSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServicePill extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ServicePill({
    required this.label,
    this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.stitchPrimary
              : AppColors.stitchSurfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 14,
                color: isSelected ? Colors.white : AppColors.stitchPrimary,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : AppColors.stitchOnSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CorridorFilterTab extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? dotColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _CorridorFilterTab({
    required this.label,
    this.icon,
    this.dotColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.stitchPrimary
              : AppColors.stitchSurfaceContainerLowest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.stitchPrimary
                : AppColors.stitchTransitHairline,
          ),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 14,
                color: isSelected ? Colors.white : AppColors.stitchPrimary,
              ),
              const SizedBox(width: 4),
            ],
            if (dotColor != null) ...[
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.stitchOnSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommuteCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String lineCode;
  final String eta;
  final IconData icon;
  final VoidCallback onTap;

  const _CommuteCard({
    required this.title,
    required this.subtitle,
    required this.lineCode,
    required this.eta,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.stitchSurfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.stitchTransitHairline),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.stitchSurfaceContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 20, color: AppColors.stitchPrimary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.stitchOnSurface,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.stitchSecondaryFixed,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          lineCode,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: AppColors.stitchSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.stitchOnSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  eta,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.stitchPrimary,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: AppColors.stitchOnSurfaceVariant,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TagBadge extends StatelessWidget {
  final String text;

  const _TagBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.stitchSurfaceContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.stitchOnSurfaceVariant,
        ),
      ),
    );
  }
}

class _CodeBadge extends StatelessWidget {
  final String code;

  const _CodeBadge({required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: AppColors.stitchSurfaceContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: AppColors.stitchPrimary,
        ),
      ),
    );
  }
}

class _LineTag extends StatelessWidget {
  final String code;
  final Color color;

  const _LineTag({required this.code, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 0.8),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
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
