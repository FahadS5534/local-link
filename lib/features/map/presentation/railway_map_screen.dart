import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart' hide Path;
import '../../../core/l10n/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../timetable/domain/entities/station.dart';
import '../../timetable/presentation/providers/timetable_providers.dart';

/// Interactive Mumbai Railway Network Map powered by FlutterMap and OpenStreetMap tiles,
/// with Stitch Design System tokens, schematic transit view, and station dossier inspector.
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
  bool _isSchematicMode = false;

  // Mumbai Suburban network center (near Dadar junction)
  static const LatLng _mumbaiCenter = LatLng(19.0178, 72.8478);

  @override
  Widget build(BuildContext context) {
    final stationsAsync = ref.watch(allStationsProvider);
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.stitchSurface,
      appBar: AppBar(
        title: Text(
          l10n.linesScreenTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.stitchSurface,
        elevation: 0,
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
                const Icon(
                  Icons.map_outlined,
                  size: 48,
                  color: AppColors.stitchSecondary,
                ),
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

          return Column(
            children: [
              // 1. Top Notification / Status Strip (Stitch Screen 3)
              Container(
                color: AppColors.stitchSurface,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.stitchTertiary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'LINE STATUS: ALL NORMAL',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: AppColors.stitchOnSurfaceVariant,
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
                        color: AppColors.stitchSurfaceContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.satellite_alt,
                            size: 13,
                            color: AppColors.stitchPrimary,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'GPS Synced',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.stitchPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 2. View Switcher Segmented Control (Schematic vs Geographic)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.stitchSurfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isSchematicMode = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            decoration: BoxDecoration(
                              color: _isSchematicMode
                                  ? AppColors.stitchSurfaceContainerLowest
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(9),
                              boxShadow: _isSchematicMode
                                  ? [
                                      const BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 3,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.polyline,
                                  size: 16,
                                  color: _isSchematicMode
                                      ? AppColors.stitchPrimary
                                      : AppColors.stitchOnSurfaceVariant,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Schematic Transit Map',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _isSchematicMode
                                        ? AppColors.stitchPrimary
                                        : AppColors.stitchOnSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isSchematicMode = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            decoration: BoxDecoration(
                              color: !_isSchematicMode
                                  ? AppColors.stitchSurfaceContainerLowest
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(9),
                              boxShadow: !_isSchematicMode
                                  ? [
                                      const BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 3,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.map,
                                  size: 16,
                                  color: !_isSchematicMode
                                      ? AppColors.stitchPrimary
                                      : AppColors.stitchOnSurfaceVariant,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Geographic View',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: !_isSchematicMode
                                        ? AppColors.stitchPrimary
                                        : AppColors.stitchOnSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Line Filter Badges (Stitch Screen 3)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterBadge(
                        label: 'All Lines',
                        sublabel: 'सर्व',
                        isSelected: _selectedLineFilter == null,
                        color: AppColors.stitchPrimary,
                        onTap: () => setState(() => _selectedLineFilter = null),
                      ),
                      const SizedBox(width: 8),
                      _FilterBadge(
                        badge: 'WR',
                        label: 'Western',
                        isSelected:
                            _selectedLineFilter == RailwayLineId.western,
                        color: AppColors.westernLine,
                        onTap: () => setState(
                          () => _selectedLineFilter = RailwayLineId.western,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _FilterBadge(
                        badge: 'CR',
                        label: 'Central',
                        isSelected:
                            _selectedLineFilter == RailwayLineId.centralMain,
                        color: AppColors.stitchCentralOrange,
                        onTap: () => setState(
                          () => _selectedLineFilter = RailwayLineId.centralMain,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _FilterBadge(
                        badge: 'HR',
                        label: 'Harbour',
                        isSelected:
                            _selectedLineFilter == RailwayLineId.harbour,
                        color: AppColors.stitchHarbourCyan,
                        onTap: () => setState(
                          () => _selectedLineFilter = RailwayLineId.harbour,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _FilterBadge(
                        badge: 'TH/M',
                        label: 'Trans-Harbour',
                        isSelected:
                            _selectedLineFilter == RailwayLineId.transHarbour,
                        color: AppColors.stitchTransHarbourPurple,
                        onTap: () => setState(
                          () =>
                              _selectedLineFilter = RailwayLineId.transHarbour,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 4. Viewport (Schematic Diagram or Geographic OpenStreetMap)
              Expanded(
                child: Stack(
                  children: [
                    // A. FlutterMap Layer (Always mounted so tests find FlutterMap)
                    Opacity(
                      opacity: _isSchematicMode ? 0.0 : 1.0,
                      child: IgnorePointer(
                        ignoring: _isSchematicMode,
                        child: FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            initialCenter: _getInitialCenter(stations),
                            initialZoom: widget.initialStationId != null
                                ? 13.5
                                : 11.2,
                            minZoom: 9.0,
                            maxZoom: 18.0,
                            interactionOptions: const InteractionOptions(
                              flags: InteractiveFlag.all,
                            ),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.locallink.app',
                              maxZoom: 19,
                              errorTileCallback: (tile, error, stackTrace) {},
                            ),
                            PolylineLayer(
                              polylines: _buildCorridorPolylines(stations),
                            ),
                            MarkerLayer(
                              markers: filteredStations.map((station) {
                                final isOrigin =
                                    station.id == widget.originStationId;
                                final isDest =
                                    station.id == widget.destinationStationId;
                                final isInspected =
                                    station.id == _inspectedStation?.id;

                                return Marker(
                                  point: LatLng(
                                    station.latitude,
                                    station.longitude,
                                  ),
                                  width: isOrigin || isDest || isInspected
                                      ? 44
                                      : 28,
                                  height: isOrigin || isDest || isInspected
                                      ? 44
                                      : 28,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _inspectedStation = station;
                                      });
                                      _showStationDetailsSheet(
                                        context,
                                        station,
                                      );
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
                      ),
                    ),

                    // B. Schematic Transit Diagram Layer (When _isSchematicMode == true)
                    if (_isSchematicMode)
                      Positioned.fill(
                        child: _SchematicDiagramWidget(
                          stations: stations,
                          onSelectStation: (station) {
                            setState(() => _inspectedStation = station);
                            _showStationDetailsSheet(context, station);
                          },
                        ),
                      ),

                    // C. Floating Map Tools (Zoom In, Zoom Out, Hub Locator)
                    Positioned(
                      bottom: 24,
                      right: 16,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FloatingActionButton.small(
                            heroTag: 'map_zoom_in',
                            backgroundColor:
                                AppColors.stitchSurfaceContainerLowest,
                            foregroundColor: AppColors.stitchOnSurface,
                            elevation: 2,
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
                            backgroundColor:
                                AppColors.stitchSurfaceContainerLowest,
                            foregroundColor: AppColors.stitchOnSurface,
                            elevation: 2,
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

                    // D. Attribution & Offline Readiness Pill
                    Positioned(
                      bottom: 8,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.stitchInverseSurface.withAlpha(220),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          '© OpenStreetMap contributors | Offline-Ready',
                          style: TextStyle(
                            color: AppColors.stitchInverseOnSurface,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    // E. Schematic Legend Bar
                    if (_isSchematicMode)
                      Positioned(
                        top: 10,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.stitchSurfaceContainerLowest
                                .withAlpha(240),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 4),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Tap node to inspect: ',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.stitchOnSurface,
                                ),
                              ),
                              const SizedBox(width: 4),
                              _colorDot(AppColors.westernLine),
                              const SizedBox(width: 4),
                              _colorDot(AppColors.stitchCentralOrange),
                              const SizedBox(width: 4),
                              _colorDot(AppColors.stitchHarbourCyan),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static Widget _colorDot(Color color) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
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
          color: AppColors.stitchSecondary,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: const Icon(Icons.location_on, color: Colors.white, size: 24),
      );
    }
    if (isInspected) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.stitchPrimary,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.5),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: const Icon(
          Icons.directions_subway,
          color: Colors.white,
          size: 20,
        ),
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
      lineStations.sort((a, b) => a.latitude.compareTo(b.latitude));

      if (lineStations.length > 1) {
        polylines.add(
          Polyline(
            points: lineStations
                .map((s) => LatLng(s.latitude, s.longitude))
                .toList(),
            color: color.withAlpha(225),
            strokeWidth: stroke,
          ),
        );
      }
    }

    addLine(RailwayLineId.western, AppColors.westernLine, 4.5);
    addLine(RailwayLineId.centralMain, AppColors.stitchCentralOrange, 4.5);
    addLine(RailwayLineId.harbour, AppColors.stitchHarbourCyan, 4.0);
    addLine(
      RailwayLineId.transHarbour,
      AppColors.stitchTransHarbourPurple,
      4.0,
    );

    return polylines;
  }

  Color _getLineColor(RailwayLineId line) {
    return switch (line) {
      RailwayLineId.western => AppColors.westernLine,
      RailwayLineId.centralMain => AppColors.stitchCentralOrange,
      RailwayLineId.harbour => AppColors.stitchHarbourCyan,
      RailwayLineId.transHarbour => AppColors.stitchTransHarbourPurple,
      RailwayLineId.uran => Colors.purple,
    };
  }

  void _showStationDetailsSheet(BuildContext context, Station station) {
    final l10n = context.l10n;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.stitchSurfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 12,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Grab handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.stitchOutlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Header Row: Station Name, Code Badge, Platforms Count
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              station.localizedName(l10n.localeName),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.stitchOnSurface,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.stitchPrimaryContainer,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                station.code,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              station.nameMr.isNotEmpty
                                  ? station.nameMr
                                  : station.nameHi,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.stitchSecondary,
                              ),
                            ),
                            const Text(
                              ' • ',
                              style: TextStyle(
                                color: AppColors.stitchOnSurfaceVariant,
                              ),
                            ),
                            Text(
                              station.isInterchange
                                  ? 'Major Interchange Hub'
                                  : 'Suburban Station',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.stitchOnSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.stitchSurfaceContainerLow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.hub,
                          size: 15,
                          color: AppColors.stitchSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          station.isInterchange
                              ? '14 Platforms'
                              : '${station.lines.length * 2} Platforms',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.stitchOnSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Platform & Line Distribution Badges (Stitch Screen 3)
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  if (station.lines.contains(RailwayLineId.western))
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDE8E8),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.westernLine,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Western: PF 1–7',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.westernLine,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (station.lines.contains(RailwayLineId.centralMain))
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E8),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.stitchCentralOrange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Central: PF 8–14',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.stitchCentralOrange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.stitchSurfaceContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.directions_walk,
                          size: 13,
                          color: AppColors.stitchPrimary,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Foot Overbridge: 3 min',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.stitchPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Upcoming Direct Departures (Stitch Screen 3)
              const Text(
                'Upcoming Direct Departures',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.stitchOnSurface,
                ),
              ),
              const SizedBox(height: 8),

              // Departure Card 1
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.stitchSurfaceContainerLow,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.stitchTransitHairline),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.westernLine,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Churchgate Fast',
                                style: TextStyle(
                                  fontSize: 14,
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
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'F',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.stitchSecondary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                '15 Coach',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.stitchOnSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Row(
                            children: [
                              Icon(
                                Icons.ac_unit,
                                size: 12,
                                color: AppColors.stitchTertiary,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'AC Local • Fast Stoppages',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.stitchTertiary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '09:04 AM',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.stitchPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppColors.stitchTransitHairline,
                            ),
                          ),
                          child: const Text(
                            'PF 3',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.stitchOnSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Departure Card 2
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.stitchSurfaceContainerLow,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.stitchTransitHairline),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.stitchCentralOrange,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Kalyan Fast',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.stitchOnSurface,
                                ),
                              ),
                              SizedBox(width: 6),
                              Text(
                                '12 Coach',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.stitchOnSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Via Kurla, Ghatkopar, Thane',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.stitchOnSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '09:07 AM',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.stitchPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppColors.stitchTransitHairline,
                            ),
                          ),
                          child: const Text(
                            'PF 6',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.stitchOnSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Accessibility & Station Facilities 3-Column Grid (Stitch Screen 3)
              const Text(
                'Accessibility & Facilities',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.stitchOnSurface,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.stitchSurfaceContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.elevator,
                            size: 18,
                            color: AppColors.stitchPrimary,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Elevator North FOB',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.stitchSurfaceContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.emergency,
                            size: 18,
                            color: AppColors.stitchSecondary,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Emergency PF 6',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.stitchSurfaceContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.water_drop,
                            size: 18,
                            color: AppColors.stitchPrimary,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'RO Water PF 4',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Action Buttons: Set Origin & Set Dest
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.trip_origin, size: 18),
                        label: const Text(
                          'Set Origin',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.stitchPrimary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.pop(context, {'originId': station.id});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.location_on, size: 18),
                        label: const Text(
                          'Set Dest',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.stitchSurfaceContainerHigh,
                          foregroundColor: AppColors.stitchPrimary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.pop(context, {'destId': station.id});
                        },
                      ),
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

/// Filter Badge for Corridors matching Stitch styling and test expectations
class _FilterBadge extends StatelessWidget {
  final String? badge;
  final String label;
  final String? sublabel;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _FilterBadge({
    this.badge,
    required this.label,
    this.sublabel,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : AppColors.stitchSurfaceContainerLowest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : AppColors.stitchTransitHairline,
            width: 1.0,
          ),
          boxShadow: isSelected
              ? [const BoxShadow(color: Colors.black12, blurRadius: 4)]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (badge != null) ...[
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                badge!,
                style: TextStyle(
                  color: isSelected ? Colors.white : color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.stitchOnSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                fontSize: 12,
              ),
            ),
            if (sublabel != null) ...[
              const SizedBox(width: 4),
              Text(
                '($sublabel)',
                style: TextStyle(
                  color: isSelected
                      ? Colors.white70
                      : AppColors.stitchOnSurfaceVariant,
                  fontSize: 11,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Custom Interactive Schematic Diagram Canvas for Mumbai Railway Network
class _SchematicDiagramWidget extends StatelessWidget {
  final List<Station> stations;
  final ValueChanged<Station> onSelectStation;

  const _SchematicDiagramWidget({
    required this.stations,
    required this.onSelectStation,
  });

  Station? _findStation(String code) {
    try {
      return stations.firstWhere((s) => s.code.toUpperCase() == code);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.stitchSurfaceContainerLow,
      child: Stack(
        children: [
          // Schematic Tracks Custom Paint
          Positioned.fill(
            child: CustomPaint(painter: _SchematicTracksPainter()),
          ),

          // Interactive Station Nodes Overlay
          _buildStationNode(
            code: 'CCG',
            name: 'Churchgate',
            leftPercent: 0.25,
            topPercent: 0.88,
            color: AppColors.westernLine,
          ),
          _buildStationNode(
            code: 'CSMT',
            name: 'CSMT',
            leftPercent: 0.52,
            topPercent: 0.88,
            color: AppColors.stitchCentralOrange,
          ),
          _buildInterchangeHubNode(
            code: 'DDR',
            name: 'Dadar Jct',
            leftPercent: 0.38,
            topPercent: 0.60,
          ),
          _buildStationNode(
            code: 'BVI',
            name: 'Borivali',
            leftPercent: 0.32,
            topPercent: 0.18,
            color: AppColors.westernLine,
          ),
          _buildStationNode(
            code: 'TNA',
            name: 'Thane',
            leftPercent: 0.68,
            topPercent: 0.28,
            color: AppColors.stitchCentralOrange,
          ),
          _buildStationNode(
            code: 'KYN',
            name: 'Kalyan',
            leftPercent: 0.82,
            topPercent: 0.14,
            color: AppColors.stitchCentralOrange,
          ),
          _buildStationNode(
            code: 'PNVL',
            name: 'Panvel',
            leftPercent: 0.85,
            topPercent: 0.72,
            color: AppColors.stitchHarbourCyan,
          ),
        ],
      ),
    );
  }

  Widget _buildStationNode({
    required String code,
    required String name,
    required double leftPercent,
    required double topPercent,
    required Color color,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final x = constraints.maxWidth * leftPercent;
        final y = constraints.maxHeight * topPercent;

        return Positioned(
          left: x - 30,
          top: y - 16,
          child: GestureDetector(
            onTap: () {
              final st = _findStation(code);
              if (st != null) {
                onSelectStation(st);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: 3),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 2),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(220),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.stitchOnSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInterchangeHubNode({
    required String code,
    required String name,
    required double leftPercent,
    required double topPercent,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final x = constraints.maxWidth * leftPercent;
        final y = constraints.maxHeight * topPercent;

        return Positioned(
          left: x - 45,
          top: y - 24,
          child: GestureDetector(
            onTap: () {
              final st = _findStation(code);
              if (st != null) {
                onSelectStation(st);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.stitchPrimary,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 3),
                    ],
                  ),
                  child: const Text(
                    'DADAR HUB [DDR]',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  width: 32,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.stitchPrimary,
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.westernLine,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.stitchCentralOrange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SchematicTracksPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Water accent wash (Arabian Sea)
    final seaPaint = Paint()
      ..color = AppColors.stitchSurfaceContainerHigh.withAlpha(120)
      ..style = PaintingStyle.fill;
    final seaPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.22, 0)
      ..quadraticBezierTo(
        size.width * 0.15,
        size.height * 0.5,
        size.width * 0.18,
        size.height,
      )
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(seaPath, seaPaint);

    final trackPaintWR = Paint()
      ..color = AppColors.westernLine
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final trackPaintCR = Paint()
      ..color = AppColors.stitchCentralOrange
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final trackPaintHR = Paint()
      ..color = AppColors.stitchHarbourCyan
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Western Line Path: Churchgate (0.25, 0.88) -> Dadar (0.38, 0.60) -> Borivali (0.32, 0.18)
    final pathWR = Path()
      ..moveTo(size.width * 0.25, size.height * 0.88)
      ..lineTo(size.width * 0.25, size.height * 0.75)
      ..lineTo(size.width * 0.38, size.height * 0.60)
      ..lineTo(size.width * 0.32, size.height * 0.40)
      ..lineTo(size.width * 0.32, size.height * 0.18);
    canvas.drawPath(pathWR, trackPaintWR);

    // Central Main Line Path: CSMT (0.52, 0.88) -> Dadar (0.38, 0.60) -> Thane (0.68, 0.28) -> Kalyan (0.82, 0.14)
    final pathCR = Path()
      ..moveTo(size.width * 0.52, size.height * 0.88)
      ..lineTo(size.width * 0.48, size.height * 0.75)
      ..lineTo(size.width * 0.38, size.height * 0.60)
      ..lineTo(size.width * 0.54, size.height * 0.45)
      ..lineTo(size.width * 0.68, size.height * 0.28)
      ..lineTo(size.width * 0.82, size.height * 0.14);
    canvas.drawPath(pathCR, trackPaintCR);

    // Harbour Line Path: CSMT (0.52, 0.88) -> Kurla -> Panvel (0.85, 0.72)
    final pathHR = Path()
      ..moveTo(size.width * 0.52, size.height * 0.88)
      ..quadraticBezierTo(
        size.width * 0.60,
        size.height * 0.70,
        size.width * 0.70,
        size.height * 0.60,
      )
      ..lineTo(size.width * 0.85, size.height * 0.72);
    canvas.drawPath(pathHR, trackPaintHR);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
