import 'package:flutter_project/models/DTO/audio_result.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class AudioService {
  final String _apiKey = '';
  final String _url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

  Future<PronunciationResult> analyzeAudio({
    required String audioFilePath,
    required String correctWord,
    required String language,
  }) async {
    final audioBytes = await File(audioFilePath).readAsBytes();
    final audioBase64 = base64Encode(audioBytes);

    final response = await http.post(
      Uri.parse('$_url?key=$_apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {
                'inline_data': {
                  'mime_type': 'audio/aac',
                  'data': audioBase64,
                }
              },
              {
                'text': '''
                  You are an expert $language pronunciation coach.
                  The correct word the user should say is: "$correctWord"

                  Listen to the audio carefully and analyze:
                  1. What word did the user actually say?
                  2. How accurate is their pronunciation? (0-100)
                  3. What specific mistakes did they make?
                  4. One tip to improve

                  Reply ONLY in this exact JSON format (no extra text):
                  {
                    "word_heard": "what you heard",
                    "accuracy": 85,
                    "feedback": "Your pronunciation was good but...",
                    "tip": "Focus on...",
                    "grade": "Excellent"
                  }

                  grade must be one of: Excellent, Good, Fair, Poor
                '''
              }
            ]
          }
        ]
      }),
    );

    final data = jsonDecode(response.body);
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');
    final text = data['candidates'][0]['content']['parts'][0]['text'] as String;
    final cleanJson = text
        .replaceAll('```json', '')
        .replaceAll('```', '')
        .trim();
    final map = jsonDecode(cleanJson) as Map<String, dynamic>;

    return PronunciationResult.fromMap(map);
  }
}
