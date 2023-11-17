import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../providers/products.dart';

import '../pages/add_product_page.dart';
import '../widgets/product_item.dart';

class HomePage extends StatefulWidget {
  static const route = "/home";

  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;
  bool isLoading = false;
  int _selectedIndex = 0; // Indeks terpilih pada BottomNavigationBar

  @override
  void didChangeDependencies() {
    if (isInit) {
      isLoading = true;
      Provider.of<Products>(context, listen: false)
          .initializeData()
          .then((value) {
        setState(() {
          isLoading = false;
        });
      }).catchError(
        (err) {
          print(err);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error Occurred"),
                content: Text(err.toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Okay"),
                  ),
                ],
              );
            },
          );
        },
      );

      isInit = false;
    }
    super.didChangeDependencies();
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      // Navigasi ke halaman "RecomendationScreen" ketika item "Ai" ditekan
      Navigator.pushNamed(
          context, 'RecomendationScreen'); // Ubah ke '/recomendation'
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Recipes"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () =>
                  Navigator.pushNamed(context, AddProductPage.route),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio:
                    16 / 9, // Ganti ini sesuai dengan aspect ratio gambar
                enlargeCenterPage: true,
              ),
              items: [
                Image.asset('assets/1.jpg'),
                Image.asset('assets/2.jpg'),
                Image.asset('assets/3.jpg'),
              ],
            ),
            const SizedBox(height: 30),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (prov.allProducts.isEmpty)
              const Center(
                child: Text(
                  "No Data",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.grey, // Warna teks jika tidak ada data
                  ),
                ),
              )
            else
              Expanded(
                child: prov.allProducts.isEmpty
                    ? const Center(
                        child: Text(
                          "No Data",
                          style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 142, 142,
                                142), // Warna teks jika tidak ada data
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: prov.allProducts.length,
                        itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 73, 153, 245),
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 23, 13, 222)
                                      .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ProductItem(
                              prov.allProducts[i].id,
                              prov.allProducts[i].recipeName,
                              prov.allProducts[i].ingredients,
                              prov.allProducts[i].updatedAt,
                            ),
                          ),
                        ),
                      ),
              ),
          ],
        ),
      ),
      // Tambahkan BottomNavigationBar di sini
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard_command_key),
            label: 'AI',
          ),
        ],
        currentIndex: _selectedIndex, // Tentukan indeks terpilih
        onTap: _onItemTapped, // Fungsi yang dipanggil saat item ditekan
        selectedItemColor: Colors.blue, // Warna ikon terpilih
      ),
    );
  }
}
