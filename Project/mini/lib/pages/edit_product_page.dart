import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class EditProductPage extends StatelessWidget {
  static const route = "/edit-product";

  const EditProductPage({Key? key});

  @override
  Widget build(BuildContext context) {
    String prodId = ModalRoute.of(context)!.settings.arguments as String;
    var prov = Provider.of<Products>(context, listen: false);
    var selectedProduct = prov.selectById(prodId);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recipe Detail",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Recipe Name:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${selectedProduct.recipeName}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Ingredients:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${selectedProduct.ingredients}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Go Back'),
            ),
          ),
        ],
      ),
    );
  }
}
