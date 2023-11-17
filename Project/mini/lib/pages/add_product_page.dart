import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class AddProductPage extends StatefulWidget {
  static const route = "/add-product";

  const AddProductPage({Key? key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();

  void save(String title, String ingredients) {
    Provider.of<Products>(context, listen: false)
        .addRecipe(title, ingredients)
        .then((_) {
      Navigator.pop(context);
    }).catchError((onError) {
      print(onError);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("ERROR"),
            content: Text("Error: $onError"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Recipe"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () =>
                save(titleController.text, ingredientsController.text),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                TextField(
                  autocorrect: false,
                  autofocus: true,
                  controller: titleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Recipe Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  autocorrect: false,
                  controller: ingredientsController,
                  textInputAction: TextInputAction.done,
                  maxLines: 6,
                  decoration: InputDecoration(
                    labelText: "Ingredients",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () =>
                  save(titleController.text, ingredientsController.text),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
