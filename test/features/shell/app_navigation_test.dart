import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/main.dart';

void main() {
  testWidgets('Bottom navigation switches seamlessly between all 4 tabs', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: LocalLinkApp()));
    await tester.pumpAndSettle();

    // 1. Initially on Search tab
    expect(find.text('Find Trains'), findsOneWidget);

    // 2. Tap "Lines" navigation destination
    await tester.tap(find.byIcon(Icons.alt_route_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Suburban Corridors'), findsOneWidget);
    expect(find.text('Western Line'), findsOneWidget);
    expect(find.text('Central Line (Main)'), findsOneWidget);
    expect(find.text('Harbour Line'), findsOneWidget);
    expect(find.text('Trans-Harbour Line'), findsOneWidget);

    // 3. Tap "Alerts" navigation destination
    await tester.tap(find.byIcon(Icons.notifications_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Station Alarms'), findsOneWidget);
    expect(find.text('No active alarms'), findsOneWidget);
    expect(find.text('How Proximity Alarms Work'), findsOneWidget);

    // 4. Tap "Settings" navigation destination
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Preferences'), findsOneWidget);
    expect(find.text('App Language'), findsOneWidget);
    expect(find.text('Theme Appearance'), findsOneWidget);
    expect(find.text('About LocalLink'), findsOneWidget);

    // 5. Tap back to "Search" navigation destination
    await tester.tap(find.byIcon(Icons.search_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Find Trains'), findsOneWidget);
  });
}
