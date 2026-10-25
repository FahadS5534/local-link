import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../timetable/domain/entities/station.dart';
import '../../timetable/presentation/providers/timetable_providers.dart';
import '../../timetable/presentation/screens/timetable_results_screen.dart';
import 'widgets/station_picker_sheet.dart';

/// Primary search and route planning screen.
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
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => TimetableResultsScreen(
          origin: _origin!,
          destination: _destination!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.searchScreenTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
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
          // Station Selection Card
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
                  // Swap Stations Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: Semantics(
                      button: true,
                      label: l10n.swapStationsTooltip,
                      child: IconButton.filledTonal(
                        tooltip: l10n.swapStationsTooltip,
                        icon: const Icon(Icons.swap_vert),
                        onPressed: _swapStations,
                      ),
                    ),
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
          const SizedBox(height: 20),
          // Action button
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
          const SizedBox(height: 28),
          // Major Junction Stations Header
          Text(
            l10n.majorJunctions,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // Quick Access Popular Junctions Chips
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
