import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class Products with ChangeNotifier {
  String urlMaster = "https://auth-project2-6f0c9-default-rtdb.firebaseio.com/";
  final List<Product> _allProducts = [];

  List<Product> get allProducts => _allProducts;

  Future<void> addRecipe(String recipeName, String ingredients) async {
    Uri url = Uri.parse("$urlMaster/products.json");
    DateTime dateNow = DateTime.now();
    try {
      var response = await http.post(
        url,
        body: json.encode({
          "recipeName": recipeName,
          "ingredients": ingredients,
          "createdAt": dateNow.toIso8601String(),
          "updatedAt": dateNow.toIso8601String(),
        }),
      );

      if (response.statusCode >= 300 || response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        final responseData = json.decode(response.body);
        Product data = Product(
          id: responseData["name"].toString(),
          recipeName: recipeName,
          ingredients: ingredients,
          createdAt: dateNow,
          updatedAt: dateNow,
        );

        _allProducts.add(data);
        notifyListeners();
      }
    } catch (err) {
      rethrow;
    }
  }

  void editRecipe(String id, String recipeName, String ingredients) async {
    Uri url = Uri.parse("$urlMaster/products/$id.json");
    DateTime date = DateTime.now();
    try {
      var response = await http.patch(
        url,
        body: json.encode({
          "recipeName": recipeName,
          "ingredients": ingredients,
          "updatedAt": date.toIso8601String(),
        }),
      );

      if (response.statusCode >= 300 || response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        Product edit = _allProducts.firstWhere((element) => element.id == id);
        edit.recipeName = recipeName;
        edit.ingredients = ingredients;
        edit.updatedAt = date;
        notifyListeners();
      }
    } catch (err) {
      rethrow;
    }
  }

  void deleteRecipe(String id) async {
    Uri url = Uri.parse("$urlMaster/products/$id.json");

    try {
      var response = await http.delete(url);

      if (response.statusCode >= 300 || response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        _allProducts.removeWhere((element) => element.id == id);
        notifyListeners();
      }
    } catch (err) {
      rethrow;
    }
  }

  Product selectById(String id) {
    return _allProducts.firstWhere((element) => element.id == id);
  }

  Future<void> initializeData() async {
    Uri url = Uri.parse("$urlMaster/products.json");

    try {
      var response = await http.get(url);

      if (response.statusCode >= 300 || response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        var data = json.decode(response.body) as Map<String, dynamic>;
        // ignore: unnecessary_null_comparison
        if (data != null) {
          data.forEach(
            (key, value) {
              Product prod = Product(
                id: key,
                recipeName: value["recipeName"],
                ingredients: value["ingredients"],
                createdAt: DateTime.parse(value["createdAt"]),
                updatedAt: DateTime.parse(value["updatedAt"]),
              );
              _allProducts.add(prod);
            },
          );
        }
      }
    } catch (err) {
      rethrow;
    }
  }
}
