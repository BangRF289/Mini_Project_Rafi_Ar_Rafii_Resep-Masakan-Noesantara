import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini/pages/recomendation_Ai.dart';

void main() {
  testWidgets('RecomendationScreen UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(
      const MaterialApp(
        home: RecomendationScreen(),
      ),
    );

    // Verify if the title is displayed
    expect(find.text('Spices Recommendation'), findsOneWidget);

    // Example: Tap on the ElevatedButton and test if the CircularProgressIndicator appears
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Wait for the animation to complete

    // Check if CircularProgressIndicator appears
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // You can add more test cases for other widgets and interactions here
  });
}
