import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini/pages/home_page.dart';
// Ganti dengan path yang sesuai

void main() {
  testWidgets('HomePage UI Test', (WidgetTester tester) async {
    // Bangun widget HomePage
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );

    // Verifikasi apakah judul AppBar sesuai
    expect(find.text('All Recipes'), findsOneWidget);

    // Verifikasi apakah ada CarouselSlider
    expect(find.byType(CarouselSlider), findsOneWidget);
  });
}
