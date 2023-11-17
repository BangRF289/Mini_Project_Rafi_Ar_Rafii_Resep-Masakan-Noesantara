import 'dart:convert';
import 'package:mini/models/open_ai.dart';

import 'package:http/http.dart' as http;

import '../constants/open_ai.dart';

class RecommendationService {
  static Future<GpData> getRecommendation(
      {required String recipe, required String origin}) async {
    late GpData gptData = GpData(
      id: "",
      object: "",
      created: 0,
      model: "",
      choices: [],
      usage: Usage(
        promptTokens: 0,
        completionTokens: 0,
        totalTokens: 0,
      ),
    );

    try {
      var url = Uri.parse("https://api.openai.com/v1/completions");

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Charset": "utf-8",
        "Authorization": "Bearer $apiKey",
      };

      String promptData =
          "Anda ahli dalam bumbu dan rempah. beri saya bumbu dan rekomendasi bumbu berdasarkan resep $recipe. berasal dari benua $origin.";

      final data = jsonEncode({
        "model": "text-davinci-003",
        "prompt": promptData,
        "max_tokens": 200,
        "temperature": 0.7,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0,
      });

      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        gptData = gpDataFromJson(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }

    return gptData;
  }
}
