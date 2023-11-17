import 'package:flutter/material.dart';

import 'package:mini/pages/result_screen.dart';
import 'package:mini/services/recomendation.dart';

const List<String> origin = <String>[
  'Asia',
  'Europe',
];
int _selectedIndex = 0;

class RecomendationScreen extends StatefulWidget {
  const RecomendationScreen({Key? key}) : super(key: key);

  @override
  State<RecomendationScreen> createState() => _RecomendationScreenState();
}

class _RecomendationScreenState extends State<RecomendationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  String originValue = origin.first;
  bool isLoading = false;

  void _onItemTapped(int index) {
    if (index == 0) {
      // Navigasi ke halaman "RecomendationScreen" ketika item "Ai" ditekan
      Navigator.pushNamed(context, 'HomePage'); // Ubah ke '/recomendation'
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _getRecommendations() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await RecommendationService.getRecommendation(
        recipe: _controller.text,
        origin: '',
      );

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            gptResponseData: result,
          ),
        ),
      );
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Gagal mendapatkan rekomendasi'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Spices Recommendation"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Rekomendasi Rempah Berbasis AI",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Pilih Asal Rempah"),
                  ),
                  DropdownButtonFormField<String>(
                    value: originValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        originValue = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0,
                      ),
                    ),
                    items: origin.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Masukkan recipe"),
                  ),
                  TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Masukkan Resep",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Resep';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _getRecommendations();
                              }
                            },
                            child: const Text("Dapatkan Rekomendasi"),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard_command_key),
            label: 'Ai',
          ),
        ],
        currentIndex: _selectedIndex, // Tentukan indeks terpilih
        onTap: _onItemTapped, // Fungsi yang dipanggil saat item ditekan
      ),
    );
  }
}
