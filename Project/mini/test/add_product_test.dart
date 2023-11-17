import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:mini/providers/products.dart';
import 'package:mini/pages/add_product_page.dart';

class MockProducts extends Mock implements Products {}

void main() {
  testWidgets('AddProductPage UI Test', (WidgetTester tester) async {
    final MockProducts mockProducts = MockProducts();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<Products>.value(
          value: mockProducts,
          child: const AddProductPage(),
        ),
      ),
    );

    expect(find.text('Add Recipe'), findsOneWidget);
    expect(find.text('Recipe Name'), findsWidgets);
    expect(find.text('Ingredients'), findsWidgets);
    expect(find.text('Save'), findsWidgets);
  });
}
