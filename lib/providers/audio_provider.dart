
import 'package:flutter/material.dart';
import 'package:flutter_project/models/DTO/learned_word.dart';
import 'package:flutter_project/services/learned_word.dart';
import 'package:flutter_project/services/profile_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:flutter_project/services/audio_service.dart';
import 'package:flutter_project/models/DTO/audio_result.dart';

class AudioProvider with ChangeNotifier {

  final AudioService _service = AudioService();
  final AudioRecorder _recorder = AudioRecorder();

  bool isRecording  = false;
  bool isAnalyzing  = false;
  String _audioPath = '';
  PronunciationResult? result;
  String? errorMessage;


  Future<void> startRecording() async
  {
    if (!await _recorder.hasPermission()) {
      errorMessage = 'Microphone permission denied';
      notifyListeners();
      return;
    }

    final dir = await getTemporaryDirectory();
    _audioPath = '${dir.path}/voice.wav';


    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 64000,
      ),
      path: _audioPath,
    );

    isRecording  = true;
    errorMessage = null;
    notifyListeners();
  }




  Future<void> stopAndAnalyze({
    required String correctWord,
    required String language,
  }) async
  {
    await _recorder.stop();

    isRecording = false;
    isAnalyzing = true;
    result      = null;
    notifyListeners();

    try {
      result = await _service.analyzeAudio(
        audioFilePath: _audioPath,
        correctWord:   correctWord,
        language:      language,
      );

    } catch (e) {
      errorMessage = 'Analysis failed: $e';
    }


    isAnalyzing = false;
    notifyListeners();
  }

  Future<void> recored_analyis({required String correctWord,
    required String language,}) async {
    await startRecording();

    await Future.delayed(Duration(seconds: 3));

    await stopAndAnalyze(
    correctWord: correctWord,
    language: language,
    );
  }
  // void reset() {
  //   result       = null;
  //   errorMessage = null;
  //   isRecording  = false;
  //   isAnalyzing  = false;
  //   notifyListeners();
  // }

}