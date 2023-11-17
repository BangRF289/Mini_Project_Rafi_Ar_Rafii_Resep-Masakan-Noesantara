import 'package:flutter/material.dart';

class Product {
  String? id, recipeName, ingredients, imageUrl;
  DateTime? createdAt, updatedAt;

  Product({
    @required this.id,
    @required this.recipeName,
    @required this.ingredients,
    this.imageUrl,
    @required this.createdAt,
    this.updatedAt,
  });
}
