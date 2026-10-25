import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/core/l10n/locale_provider.dart';
import 'package:local_link/core/theme/theme_provider.dart';
import 'package:local_link/main.dart';

void main() {
  testWidgets(
    'Selecting Marathi switches UI strings to Marathi in Devanagari script',
    (WidgetTester tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const LocalLinkApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to Settings
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();

      // Tap Marathi option
      await tester.tap(find.text('मराठी (Marathi)'));
      await tester.pumpAndSettle();

      // Verify locale changed in Riverpod state
      expect(container.read(localeProvider), const Locale('mr'));

      // Verify UI updated to Marathi
      expect(find.text('प्राधान्ये'), findsOneWidget); // Settings title
      expect(find.text('अ‍ॅप भाषा'), findsOneWidget); // App language label
      expect(find.text('थीम स्वरूप'), findsOneWidget); // Theme label
      expect(find.text('शोधा'), findsOneWidget); // Search nav label
    },
  );

  testWidgets(
    'Selecting Hindi switches UI strings to Hindi in Devanagari script',
    (WidgetTester tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const LocalLinkApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to Settings
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();

      // Tap Hindi option
      await tester.tap(find.text('हिन्दी (Hindi)'));
      await tester.pumpAndSettle();

      // Verify locale changed in Riverpod state
      expect(container.read(localeProvider), const Locale('hi'));

      // Verify UI updated to Hindi
      expect(find.text('प्राथमिकताएं'), findsOneWidget); // Settings title
      expect(find.text('ऐप भाषा'), findsOneWidget); // App language label
      expect(find.text('थीम रूप-रंग'), findsOneWidget); // Theme label
      expect(find.text('खोजें'), findsOneWidget); // Search nav label
    },
  );

  testWidgets('Selecting Dark Mode updates themeMode state', (
    WidgetTester tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const LocalLinkApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Navigate to Settings
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    // Select Dark Mode
    await tester.tap(find.text('Dark Mode'));
    await tester.pumpAndSettle();

    // Verify theme mode changed
    expect(container.read(themeModeProvider), ThemeMode.dark);
  });
}
