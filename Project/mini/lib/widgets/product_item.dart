import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../pages/edit_product_page.dart';

class ProductItem extends StatelessWidget {
  final String? id, recipeName, ingredients;
  final DateTime? updatedAt;

  // ignore: use_key_in_widget_constructors
  const ProductItem(this.id, this.recipeName, this.ingredients, this.updatedAt,
      {Key? key});

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Products>(context, listen: false);
    String date = DateFormat.yMMMd().add_Hms().format(updatedAt!);
    return Card(
      elevation: 3, // Tingkat elevasi card
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, EditProductPage.route, arguments: id);
        },
        title: Text("Recipe Name: $recipeName"),
        subtitle: Text("Last Edited: $date"),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            prov.deleteRecipe(id!);
          },
        ),
      ),
    );
  }
}
