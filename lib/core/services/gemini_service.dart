import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey =
      dotenv.env['GEMINI_API_KEY'] ?? '';
  // -----------------------------
  // 📸 SCAN RECEIPT (FULL FIXED)
  // -----------------------------
  Future<Map<String, dynamic>> scanReceipt(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final mimeType =
      imageFile.path.endsWith(".png") ? "image/png" : "image/jpeg";

      final response = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent?key=$apiKey',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text": """
Extract receipt data from this image.

Return ONLY valid JSON:

{
  "merchant": "",
  "amount": "",
  "date": "",
  "category": ""
}
"""
                },
                {
                  "inline_data": {
                    "mime_type": mimeType,
                    "data": base64Image
                  }
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode != 200) {
        return {"error": response.body};
      }

      final decoded = jsonDecode(response.body);

      final rawText =
      decoded["candidates"][0]["content"]["parts"][0]["text"];

      // clean ```json ``` wrapper if exists
      final cleaned = rawText
          .replaceAll("```json", "")
          .replaceAll("```", "")
          .trim();

      final jsonData = jsonDecode(cleaned);

      return jsonData;
    } catch (e) {
      return {"error": e.toString()};
    }
  }

  // -----------------------------
  // 🧠 INSIGHTS (FOR DASHBOARD)
  // -----------------------------
  Future<String> generateInsights(
      List<Map<String, dynamic>> expenses) async {
    final response = await http.post(
      Uri.parse(
        'https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent?key=$apiKey',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": """
Analyze these expenses and give financial insights:

1. Total spending
2. Category breakdown
3. Highest expense
4. Savings suggestions

Data:
${jsonEncode(expenses)}
"""
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode != 200) {
      return "Error: ${response.body}";
    }

    final decoded = jsonDecode(response.body);

    return decoded["candidates"][0]["content"]["parts"][0]["text"];
  }
}