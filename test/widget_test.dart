import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/main.dart';

void main() {
  testWidgets('LocalLinkApp launches and displays Search tab as default', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: LocalLinkApp()));
    await tester.pumpAndSettle();

    // Verify top app bar title
    expect(find.text('Find Trains'), findsOneWidget);

    // Verify offline badge
    expect(find.text('100% Offline Ready'), findsOneWidget);

    // Verify origin and destination picker tiles
    expect(find.text('Select Origin Station'), findsOneWidget);
    expect(find.text('Select Destination Station'), findsOneWidget);

    // Verify bottom navigation bar destinations
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byIcon(Icons.alt_route_outlined), findsOneWidget);
    expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
  });
}
