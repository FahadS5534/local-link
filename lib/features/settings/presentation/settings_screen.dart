import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/l10n/l10n_extension.dart';
import '../../../core/l10n/locale_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';

/// Screen allowing commuters to configure language, theme, and view app information.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final currentLocale = ref.watch(localeProvider);
    final currentThemeMode = ref.watch(themeModeProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsScreenTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language Preference Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.language, color: AppColors.primaryBlue),
                      const SizedBox(width: 8),
                      Text(
                        l10n.languageSetting,
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  RadioGroup<Locale>(
                    groupValue: currentLocale,
                    onChanged: (Locale? val) {
                      if (val != null) {
                        ref.read(localeProvider.notifier).setLocale(val);
                      }
                    },
                    child: Column(
                      children: [
                        RadioListTile<Locale>(
                          value: SupportedLocales.english,
                          title: Text(l10n.english),
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        RadioListTile<Locale>(
                          value: SupportedLocales.marathi,
                          title: Text(l10n.marathi),
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        RadioListTile<Locale>(
                          value: SupportedLocales.hindi,
                          title: Text(l10n.hindi),
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Theme Preference Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.palette_outlined,
                        color: AppColors.primaryBlue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.themeSetting,
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  RadioGroup<ThemeMode>(
                    groupValue: currentThemeMode,
                    onChanged: (ThemeMode? val) {
                      if (val != null) {
                        ref.read(themeModeProvider.notifier).setThemeMode(val);
                      }
                    },
                    child: Column(
                      children: [
                        RadioListTile<ThemeMode>(
                          value: ThemeMode.system,
                          title: Text(l10n.themeSystem),
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        RadioListTile<ThemeMode>(
                          value: ThemeMode.light,
                          title: Text(l10n.themeLight),
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        RadioListTile<ThemeMode>(
                          value: ThemeMode.dark,
                          title: Text(l10n.themeDark),
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // About Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: AppColors.primaryBlue,
                      ),
                      const SizedBox(width: 8),
                      Text(l10n.aboutTitle, style: theme.textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(l10n.appTagline, style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text(
                    '${l10n.versionLabel}: 0.1.0 (Phase 1)',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.freshReportGreen.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: AppColors.freshReportGreen,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.offlineBadge,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.freshReportGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
