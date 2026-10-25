import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/assistant/presentation/assistant_screen.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('AssistantScreen Widget Tests', () {
    testWidgets('renders initial greeting message and quick prompt chips', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(const AssistantScreen());

      // Greeting message
      expect(find.text('Journey Assistant'), findsOneWidget);
      expect(find.textContaining('Namaskar!'), findsOneWidget);

      // Prompt chips
      expect(find.text('Bandra to Borivali'), findsOneWidget);
      expect(find.text('Fastest route to Dadar'), findsOneWidget);
      expect(find.text('Thane to CSMT'), findsOneWidget);

      // Input field and send button
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.send_rounded), findsOneWidget);
    });

    testWidgets('typing and submitting a question adds user chat bubble', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(const AssistantScreen());

      await tester.enterText(
        find.byType(TextField),
        'How to go from Bandra to Borivali?',
      );
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pumpAndSettle();

      expect(find.text('How to go from Bandra to Borivali?'), findsOneWidget);
    });
  });
}
