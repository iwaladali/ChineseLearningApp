import 'package:flutter/material.dart';
import 'package:flutter_project/services/speech_service.dart';
class SpeechProvider with ChangeNotifier{

  final SpeechService _service = SpeechService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> speak_word(String text) async{
    _isLoading = true;
    notifyListeners();
    await _service.init();
    await _service.speak(text);

    _isLoading = false;
    notifyListeners();
  }
}