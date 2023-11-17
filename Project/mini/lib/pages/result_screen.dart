import 'package:flutter/material.dart';
import 'package:mini/models/open_ai.dart';

class ResultScreen extends StatefulWidget {
  final GpData gptResponseData;

  // Konstruktor untuk menerima data rekomendasi
  const ResultScreen({Key? key, required this.gptResponseData})
      : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.gptResponseData.choices.isNotEmpty) {
      // Akses elemen dalam List
      String recommendedText = widget.gptResponseData.choices[0].text;
      // Lakukan apa pun yang Anda perlu lakukan dengan data rekomendasi
      print(recommendedText);
    } else {
      // Tindakan yang akan diambil jika List kosong
      print("Data kosong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Rekomendasi"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      "Hasil Rekomendasi",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.gptResponseData.choices.isNotEmpty)
                      Text(widget.gptResponseData.choices[0].text)
                    else
                      const Text("Data kosong"),
                  ],
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
      ),
    );
  }
}
