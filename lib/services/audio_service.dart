import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/DTO/audio_result.dart';

class AudioService {
  final String _groqKey = '';

  Future<PronunciationResult> analyzeAudio({
    required String audioFilePath,
    required String correctWord,
    required String language,
  }) async {
    // ── STEP 1: Groq Whisper → نص ──────────────────
    final spokenText = await _transcribeWithGroq(audioFilePath, language);
    print('Groq heard: $spokenText');

    // ── STEP 2: Groq LLaMA → تحليل ─────────────────
    return await _analyzeWithGroq(
      spokenText:  spokenText,
      correctWord: correctWord,
      language:    language,
    );
  }

  // ── STEP 1: Whisper ───────────────────────────────
  Future<String> _transcribeWithGroq(String audioFilePath, String language) async {
    final bytes    = await File(audioFilePath).readAsBytes();
    final fileName = audioFilePath.split('/').last;
    final langCode = language.toLowerCase() == 'chinese' ? 'zh' : 'ar';

    for (int attempt = 1; attempt <= 3; attempt++) {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.groq.com/openai/v1/audio/transcriptions'),
      );

      request.headers['Authorization']   = 'Bearer $_groqKey';
      request.fields['model']            = 'whisper-large-v3-turbo';
      request.fields['language']         = langCode;
      request.fields['response_format']  = 'text';
      request.files.add(
        http.MultipartFile.fromBytes('file', bytes, filename: fileName),
      );

      final response = await request.send();
      final body     = await response.stream.bytesToString();

      if (response.statusCode == 200) return body.trim();

      print('Whisper attempt $attempt failed: $body');
      await Future.delayed(const Duration(seconds: 2));
    }

    throw Exception('Groq Whisper failed after 3 attempts');
  }

  // ── STEP 2: LLaMA ─────────────────────────────────
  Future<PronunciationResult> _analyzeWithGroq({
    required String spokenText,
    required String correctWord,
    required String language,
  }) async {
    final response = await http.post(
      Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $_groqKey',
        'Content-Type':  'application/json',
      },
      body: jsonEncode({
        'model': 'llama-3.3-70b-versatile',
        'temperature': 0.1,
        'messages': [
          {
            'role': 'system',
            'content': '''
              You are an expert $language pronunciation coach.
              Always reply ONLY in this exact JSON format, no extra text:
              {
                "word_heard": "...",
                "accuracy": 85,
                "feedback": "...",
                "tip": "...",
                "grade": "Good"
              }
              grade must be one of: Excellent, Good, Fair, Poor
            '''
          },
          {
            'role': 'user',
            'content': 'Correct word: "$correctWord". User said: "$spokenText". Analyze.'
          }
        ],
      }),
    );

    final data      = jsonDecode(response.body);
    final text      = data['choices'][0]['message']['content'] as String;
    final cleanJson = text.replaceAll('```json', '').replaceAll('```', '').trim();

    return PronunciationResult.fromMap(jsonDecode(cleanJson));
  }
}