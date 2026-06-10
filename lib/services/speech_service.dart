import 'package:flutter_tts/flutter_tts.dart';

class SpeechService{
  final FlutterTts _tts = FlutterTts();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    await _tts.setLanguage("zh-CN");
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);

    _initialized = true;
  }

  Future<void> speak(String text) async {
    if (!_initialized) {
      await init();
    }

    await _tts.stop();
    await _tts.speak(text);
  }
}