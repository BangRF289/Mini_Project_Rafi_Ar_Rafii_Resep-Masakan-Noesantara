import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini/providers/auth.dart';
import 'package:mini/providers/products.dart';
import 'package:mini/pages/add_product_page.dart';
import 'package:mini/pages/edit_product_page.dart';
import 'package:mini/pages/recomendation_Ai.dart';
import 'package:mini/pages/auth_page.dart';
import 'package:mini/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Products()),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
        routes: {
          AddProductPage.route: (ctx) => const AddProductPage(),
          EditProductPage.route: (ctx) => const EditProductPage(),
          'RecomendationScreen': (_) => const RecomendationScreen(),
          'HomePage': (_) => const HomePage(),
        },
      ),
    );
  }
}
