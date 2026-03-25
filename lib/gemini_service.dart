import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const apiKey = "AIzaSyD9X2Sii6p9OPtfvClGSaslkCz6k_N31gE"; 

  static Future<String> generateTests(String code) async {
    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent?key=$apiKey",
    );

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": """
You are a senior Dart developer.

Generate unit tests using package:test.
- Only code
- No explanation
- Include edge cases

Code:
$code
"""
              }
            ]
          }
        ]
      }),
    );

    final data = jsonDecode(response.body);

    if (data["candidates"] == null) {
      return "❌ Error: ${data["error"]["message"]}";
    }

    return data["candidates"][0]["content"]["parts"][0]["text"];
  }
}