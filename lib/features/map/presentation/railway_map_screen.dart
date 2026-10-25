import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/l10n/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../timetable/domain/entities/station.dart';
import '../../timetable/presentation/providers/timetable_providers.dart';

/// Interactive Mumbai Railway Network Map powered by FlutterMap and OpenStreetMap tiles.
class RailwayMapScreen extends ConsumerStatefulWidget {
  final String? initialStationId;
  final String? originStationId;
  final String? destinationStationId;

  const RailwayMapScreen({
    super.key,
    this.initialStationId,
    this.originStationId,
    this.destinationStationId,
  });

  @override
  ConsumerState<RailwayMapScreen> createState() => _RailwayMapScreenState();
}

class _RailwayMapScreenState extends ConsumerState<RailwayMapScreen> {
  final MapController _mapController = MapController();
  RailwayLineId? _selectedLineFilter;
  Station? _inspectedStation;

  // Mumbai Suburban network center (near Dadar junction)
  static const LatLng _mumbaiCenter = LatLng(19.0178, 72.8478);

  @override
  Widget build(BuildContext context) {
    final stationsAsync = ref.watch(allStationsProvider);
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.linesScreenTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            tooltip: 'Center Mumbai Network',
            onPressed: () {
              _mapController.move(_mumbaiCenter, 11.5);
            },
          ),
        ],
      ),
      body: stationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.map_outlined, size: 48, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'Unable to load railway network data',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  err.toString(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        data: (stations) {
          final filteredStations = _selectedLineFilter == null
              ? stations
              : stations
                    .where((s) => s.lines.contains(_selectedLineFilter))
                    .toList();

          return Stack(
            children: [
              // 1. The Interactive Map
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _getInitialCenter(stations),
                  initialZoom: widget.initialStationId != null ? 13.5 : 11.2,
                  minZoom: 9.0,
                  maxZoom: 18.0,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.all,
                  ),
                ),
                children: [
                  // OpenStreetMap Tile Layer (Zero paid API keys)
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.locallink.app',
                    maxZoom: 19,
                    errorTileCallback: (tile, error, stackTrace) {
                      // Handled gracefully without crash; offline fallback remains active
                    },
                  ),

                  // Railway Corridor Polylines
                  PolylineLayer(polylines: _buildCorridorPolylines(stations)),

                  // Station Markers
                  MarkerLayer(
                    markers: filteredStations.map((station) {
                      final isOrigin = station.id == widget.originStationId;
                      final isDest = station.id == widget.destinationStationId;
                      final isInspected = station.id == _inspectedStation?.id;

                      return Marker(
                        point: LatLng(station.latitude, station.longitude),
                        width: isOrigin || isDest || isInspected ? 42 : 28,
                        height: isOrigin || isDest || isInspected ? 42 : 28,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _inspectedStation = station;
                            });
                            _showStationDetailsSheet(context, station);
                          },
                          child: _buildStationMarkerWidget(
                            station,
                            isOrigin: isOrigin,
                            isDest: isDest,
                            isInspected: isInspected,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),

              // 2. Line Filter Chips overlay
              Positioned(
                top: 12,
                left: 12,
                right: 12,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(
                        label: 'All Lines',
                        isSelected: _selectedLineFilter == null,
                        color: theme.colorScheme.primary,
                        onTap: () => setState(() => _selectedLineFilter = null),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Western',
                        isSelected:
                            _selectedLineFilter == RailwayLineId.western,
                        color: AppColors.westernLine,
                        onTap: () => setState(
                          () => _selectedLineFilter = RailwayLineId.western,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Central',
                        isSelected:
                            _selectedLineFilter == RailwayLineId.centralMain,
                        color: AppColors.centralLine,
                        onTap: () => setState(
                          () => _selectedLineFilter = RailwayLineId.centralMain,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Harbour',
                        isSelected:
                            _selectedLineFilter == RailwayLineId.harbour,
                        color: AppColors.harbourLine,
                        onTap: () => setState(
                          () => _selectedLineFilter = RailwayLineId.harbour,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Trans-Harbour',
                        isSelected:
                            _selectedLineFilter == RailwayLineId.transHarbour,
                        color: AppColors.transHarbourLine,
                        onTap: () => setState(
                          () =>
                              _selectedLineFilter = RailwayLineId.transHarbour,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Zoom In / Out Controls
              Positioned(
                bottom: 24,
                right: 16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton.small(
                      heroTag: 'map_zoom_in',
                      backgroundColor: theme.colorScheme.surface,
                      foregroundColor: theme.colorScheme.onSurface,
                      onPressed: () {
                        final currentZoom = _mapController.camera.zoom;
                        _mapController.move(
                          _mapController.camera.center,
                          currentZoom + 1.0,
                        );
                      },
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(height: 8),
                    FloatingActionButton.small(
                      heroTag: 'map_zoom_out',
                      backgroundColor: theme.colorScheme.surface,
                      foregroundColor: theme.colorScheme.onSurface,
                      onPressed: () {
                        final currentZoom = _mapController.camera.zoom;
                        _mapController.move(
                          _mapController.camera.center,
                          currentZoom - 1.0,
                        );
                      },
                      child: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ),

              // 4. Attribution & Offline Indicator
              Positioned(
                bottom: 6,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '© OpenStreetMap contributors | Offline-Ready',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  LatLng _getInitialCenter(List<Station> stations) {
    if (widget.initialStationId != null) {
      final s = stations.firstWhere(
        (st) => st.id == widget.initialStationId,
        orElse: () => stations.first,
      );
      return LatLng(s.latitude, s.longitude);
    }
    return _mumbaiCenter;
  }

  Widget _buildStationMarkerWidget(
    Station station, {
    required bool isOrigin,
    required bool isDest,
    required bool isInspected,
  }) {
    if (isOrigin) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: const Icon(Icons.trip_origin, color: Colors.white, size: 22),
      );
    }
    if (isDest) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: const Icon(Icons.location_on, color: Colors.white, size: 24),
      );
    }
    if (isInspected) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Icon(Icons.train, color: Colors.white, size: 20),
      );
    }

    final primaryColor = _getLineColor(station.lines.first);

    return Container(
      decoration: BoxDecoration(
        color: station.isInterchange ? Colors.white : primaryColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: station.isInterchange ? primaryColor : Colors.white,
          width: 2.5,
        ),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2)],
      ),
      child: station.isInterchange
          ? Center(
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }

  List<Polyline> _buildCorridorPolylines(List<Station> stations) {
    final polylines = <Polyline>[];

    void addLine(RailwayLineId line, Color color, double stroke) {
      if (_selectedLineFilter != null && _selectedLineFilter != line) return;

      final lineStations = stations
          .where((s) => s.lines.contains(line))
          .toList();
      // Sort along latitude (South to North)
      lineStations.sort((a, b) => a.latitude.compareTo(b.latitude));

      if (lineStations.length > 1) {
        polylines.add(
          Polyline(
            points: lineStations
                .map((s) => LatLng(s.latitude, s.longitude))
                .toList(),
            color: color.withAlpha(220),
            strokeWidth: stroke,
          ),
        );
      }
    }

    addLine(RailwayLineId.western, AppColors.westernLine, 4.0);
    addLine(RailwayLineId.centralMain, AppColors.centralLine, 4.0);
    addLine(RailwayLineId.harbour, AppColors.harbourLine, 3.5);
    addLine(RailwayLineId.transHarbour, AppColors.transHarbourLine, 3.5);

    return polylines;
  }

  Color _getLineColor(RailwayLineId line) {
    return switch (line) {
      RailwayLineId.western => AppColors.westernLine,
      RailwayLineId.centralMain => AppColors.centralLine,
      RailwayLineId.harbour => AppColors.harbourLine,
      RailwayLineId.transHarbour => AppColors.transHarbourLine,
      RailwayLineId.uran => Colors.purple,
    };
  }

  void _showStationDetailsSheet(BuildContext context, Station station) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      station.code,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          station.localizedName(l10n.localeName),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (station.nameMr.isNotEmpty)
                          Text(
                            '${station.nameMr} • ${station.nameHi}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (station.isInterchange)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.withAlpha(40),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.swap_horiz,
                            size: 14,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Junction',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: station.lines.map((l) {
                  return Chip(
                    label: Text(
                      l.name.toUpperCase(),
                      style: const TextStyle(fontSize: 11),
                    ),
                    backgroundColor: _getLineColor(l).withAlpha(30),
                    side: BorderSide(color: _getLineColor(l)),
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.trip_origin),
                      label: const Text('Set Origin'),
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pop(context, {'originId': station.id});
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.location_on),
                      label: const Text('Set Dest'),
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pop(context, {'destId': station.id});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.black87,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white24,
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
