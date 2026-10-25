import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/core/l10n/generated/app_localizations.dart';
import 'package:local_link/core/theme/app_theme.dart';

extension PumpAppExtension on WidgetTester {
  /// Pumps a widget wrapped with ProviderScope, AppTheme, and AppLocalizations delegates.
  Future<void> pumpLocalizedWidget(
    Widget widget, {
    List<Override> overrides = const [],
    Locale locale = const Locale('en'),
    ThemeMode themeMode = ThemeMode.light,
  }) async {
    await pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          home: Scaffold(body: widget),
        ),
      ),
    );
    await pumpAndSettle();
  }
}
