import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 15-Car Local Train Coach Composition Visualizer matching Stitch Screen 1.
class CoachCompositionCard extends StatelessWidget {
  final int activeCoachIndex;
  final String activeCoachClass;
  final String fobAdvice;

  const CoachCompositionCard({
    super.key,
    this.activeCoachIndex = 8,
    this.activeCoachClass = 'Gen',
    this.fobAdvice =
        'Aligns perfectly with Dadar Center Foot Over Bridge (FOB)',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // 15-car coach config: index -> (label, type, color, textColor)
    const coaches = [
      _CoachInfo(number: 1, type: 'L', name: 'Ladies', isLadies: true),
      _CoachInfo(number: 2, type: 'II', name: 'General'),
      _CoachInfo(number: 3, type: 'I', name: 'First Class', isFirstClass: true),
      _CoachInfo(number: 4, type: 'D', name: 'Divyang', isDivyang: true),
      _CoachInfo(number: 5, type: 'II', name: 'General'),
      _CoachInfo(number: 6, type: 'II', name: 'General'),
      _CoachInfo(number: 7, type: 'L', name: 'Ladies', isLadies: true),
      _CoachInfo(number: 8, type: 'II', name: 'General', isUserCoach: true),
      _CoachInfo(number: 9, type: 'I', name: 'First Class', isFirstClass: true),
      _CoachInfo(number: 10, type: 'II', name: 'General'),
      _CoachInfo(number: 11, type: 'II', name: 'General'),
      _CoachInfo(number: 12, type: 'L', name: 'Ladies', isLadies: true),
      _CoachInfo(number: 13, type: 'II', name: 'General'),
      _CoachInfo(number: 14, type: 'II', name: 'General'),
      _CoachInfo(number: 15, type: 'D', name: 'Divyang', isDivyang: true),
    ];

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withAlpha(60)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.view_carousel_outlined,
                      size: 20,
                      color: AppColors.stitchPrimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Coach Composition (15-Car)',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.stitchSecondary.withAlpha(20),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'You: C$activeCoachIndex ($activeCoachClass)',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.stitchSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              fobAdvice,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),

            // Horizontal Scrollable Rake
            SizedBox(
              height: 54,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: coaches.length + 1,
                separatorBuilder: (_, _) => const SizedBox(width: 4),
                itemBuilder: (context, i) {
                  if (i == 0) {
                    // Front Engine
                    return Container(
                      width: 36,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.stitchPrimaryContainer,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'ENG',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  final c = coaches[i - 1];
                  final isCurrent = c.number == activeCoachIndex;

                  final Color bgColor;
                  final Color textColor;

                  if (isCurrent) {
                    bgColor = AppColors.stitchPrimary;
                    textColor = Colors.white;
                  } else if (c.isLadies) {
                    bgColor = isDark
                        ? const Color(0xFF5C1D24)
                        : const Color(0xFFFFDAD5);
                    textColor = isDark
                        ? const Color(0xFFFFB4AB)
                        : const Color(0xFF8A1A16);
                  } else if (c.isFirstClass) {
                    bgColor = isDark
                        ? const Color(0xFF6B1D1D)
                        : const Color(0xFFFFDAD6);
                    textColor = isDark
                        ? const Color(0xFFFFB3B3)
                        : const Color(0xFF93000A);
                  } else if (c.isDivyang) {
                    bgColor = isDark
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFE2E8F0);
                    textColor = isDark
                        ? Colors.white70
                        : const Color(0xFF334155);
                  } else {
                    bgColor = isDark
                        ? const Color(0xFF1E2B45)
                        : const Color(0xFFDEE8FF);
                    textColor = isDark
                        ? Colors.white70
                        : const Color(0xFF0C1C31);
                  }

                  return Container(
                    width: isCurrent ? 38 : 34,
                    height: isCurrent ? 50 : 44,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(6),
                      border: isCurrent
                          ? Border.all(
                              color: AppColors.stitchSecondary,
                              width: 1.5,
                            )
                          : null,
                      boxShadow: isCurrent
                          ? [
                              BoxShadow(
                                color: AppColors.stitchPrimary.withAlpha(80),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'C${c.number}',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Text(
                          isCurrent ? 'YOU' : c.type,
                          style: TextStyle(
                            fontSize: isCurrent ? 8 : 9,
                            fontWeight: isCurrent
                                ? FontWeight.w900
                                : FontWeight.w600,
                            color: isCurrent
                                ? const Color(0xFF96BAE9)
                                : textColor.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Legend Row
            const Wrap(
              spacing: 12,
              runSpacing: 4,
              children: [
                _LegendItem(color: Color(0xFFFFDAD5), label: 'Ladies (L)'),
                _LegendItem(color: Color(0xFFFFDAD6), label: 'First Class (I)'),
                _LegendItem(color: Color(0xFFDEE8FF), label: 'General (II)'),
                _LegendItem(color: Color(0xFFE2E8F0), label: 'Divyang (D)'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CoachInfo {
  final int number;
  final String type;
  final String name;
  final bool isLadies;
  final bool isFirstClass;
  final bool isDivyang;
  final bool isUserCoach;

  const _CoachInfo({
    required this.number,
    required this.type,
    required this.name,
    this.isLadies = false,
    this.isFirstClass = false,
    this.isDivyang = false,
    this.isUserCoach = false,
  });
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}
