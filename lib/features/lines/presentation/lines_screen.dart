import 'package:flutter/material.dart';
import '../../../core/l10n/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../map/presentation/railway_map_screen.dart';

/// Screen displaying Mumbai Suburban Railway corridors and interactive map.
class LinesScreen extends StatelessWidget {
  const LinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.linesScreenTitle),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.view_list_rounded), text: 'Corridors'),
              Tab(icon: Icon(Icons.map_rounded), text: 'Interactive Map'),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _LineCard(
                  title: l10n.westernLineTitle,
                  corridor: 'Churchgate — Dahanu Road',
                  color: AppColors.westernLine,
                  stationCount: 36,
                  interchanges: const [
                    'Dadar (Central)',
                    'Andheri (Metro 1)',
                    'Bandra (Harbour)',
                  ],
                ),
                const SizedBox(height: 16),
                _LineCard(
                  title: l10n.centralLineTitle,
                  corridor: 'CSMT — Kalyan / Kasara / Khopoli',
                  color: AppColors.centralLine,
                  stationCount: 26,
                  interchanges: const [
                    'Dadar (Western)',
                    'Kurla (Harbour)',
                    'Thane (Trans-Harbour)',
                  ],
                ),
                const SizedBox(height: 16),
                _LineCard(
                  title: l10n.harbourLineTitle,
                  corridor: 'CSMT — Panvel & Goregaon',
                  color: AppColors.harbourLine,
                  stationCount: 35,
                  interchanges: const [
                    'Vadala Road (Goregaon branch)',
                    'Kurla (Central)',
                  ],
                ),
                const SizedBox(height: 16),
                _LineCard(
                  title: l10n.transHarbourLineTitle,
                  corridor: 'Thane — Vashi / Nerul / Panvel',
                  color: AppColors.transHarbourLine,
                  stationCount: 10,
                  interchanges: const ['Thane (Central)', 'Vashi (Harbour)'],
                ),
              ],
            ),
            const RailwayMapScreen(),
          ],
        ),
      ),
    );
  }
}

class _LineCard extends StatelessWidget {
  final String title;
  final String corridor;
  final Color color;
  final int stationCount;
  final List<String> interchanges;

  const _LineCard({
    required this.title,
    required this.corridor,
    required this.color,
    required this.stationCount,
    required this.interchanges,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: AppColors.stitchSurfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.stitchTransitHairline),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 1)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 5, color: color),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.stitchOnSurface,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: color.withAlpha(20),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '$stationCount Stations',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        corridor,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.stitchOnSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: interchanges.map((interchange) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.stitchSurfaceContainerLow,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: AppColors.stitchTransitHairline,
                              ),
                            ),
                            child: Text(
                              interchange,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.stitchOnSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
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
