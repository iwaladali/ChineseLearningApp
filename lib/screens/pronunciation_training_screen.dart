import 'package:flutter/material.dart';
import 'package:flutter_project/models/DTO/vocabulary_response.dart';
import 'package:flutter_project/providers/audio_provider.dart';
import 'package:flutter_project/widgets/pronunciation_word_card.dart';
import 'package:provider/provider.dart';


class PronunciationTrainingScreen extends StatefulWidget {
  const PronunciationTrainingScreen({super.key});

  @override
  State<PronunciationTrainingScreen> createState() =>
      _PronunciationTrainingScreenState();
}

class _PronunciationTrainingScreenState
    extends State<PronunciationTrainingScreen> {
  static const Color primaryRed = Color(0xFFE53935);
  static const Color darkText = Color(0xFF2F3A3F);
  static const Color greyText = Color(0xFF9CA3AF);
  static const Color lightRed = Color(0xFFFDEAEA);

  void showResultSnackBar(
      BuildContext context,
      Map<String, dynamic> result,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🗣 Word: ${result['wordHeard']}"),
            Text("🎯 Accuracy: ${result['accuracy']}%"),
            Text("⭐ Grade: ${result['grade']}"),
            const SizedBox(height: 6),
            Text("💬 Feedback: ${result['feedback']}"),
            Text("💡 Tip: ${result['tip']}"),
          ],
        ),
      ),
    );
  }

  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    // TODO: Receive selected Word model from WordDetailsScreen.
    // TODO: Replace static word values with selected word data.
    final vocab =
    ModalRoute.of(context)!.settings.arguments
    as VocabularyResponse;
     String hanzi = vocab.chinese ;
     String pinyin = vocab.pinyin;
     String arabic = vocab.arabic;

    final audioProvider = Provider.of<AudioProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 18),

                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),

                        const Expanded(
                          child: Text(
                            'تدريب النطق',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: darkText,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 48),
                      ],
                    ),

                    const SizedBox(height: 32),

                     PronunciationWordCard(
                      hanzi: hanzi,
                      pinyin: pinyin,
                      arabic: arabic,
                    ),

                    const SizedBox(height: 70),

                    const Text(
                      'اضغط وابدأ النطق',
                      style: TextStyle(
                        color: greyText,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 28),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isRecording = !_isRecording;
                        });

                        if (_isRecording) {
                          // TODO: Start microphone recording using SpeechProvider.
                          audioProvider.startRecording();
                        } else {

                          audioProvider.stopAndAnalyze(correctWord: hanzi,
                              language: "Chinese");
                          // TODO: Stop microphone recording.
                          // TODO: Send audio to pronunciation evaluation service.
                          // TODO: Display pronunciation score.
                          // TODO: Save pronunciation result in Firestore.
                          // TODO: Update ProgressProvider pronunciation statistics.
                        //  while(audioProvider.isAnalyzing);
                          print("Hello");
                          showResultSnackBar(context, audioProvider.result!.GetfromMap() );
                        }
                      },
                      child: Container(
                        width: 112,
                        height: 112,
                        decoration: BoxDecoration(
                          color: lightRed,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: primaryRed.withValues(alpha: 0.18),
                              blurRadius: 28,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(
                          _isRecording ? Icons.stop : Icons.mic,
                          color: primaryRed,
                          size: 46,
                        ),
                      ),
                    ),

                    const SizedBox(height: 38),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: darkText,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: const BorderSide(
                                color: Color(0xFFE5E7EB),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            onPressed: () {
                              // TODO: Reset current pronunciation attempt.
                              // TODO: Clear score/result from SpeechProvider.
                            },
                            child: const Text(
                              'إعادة المحاولة',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryRed,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            onPressed: () {
                              // TODO: Finish pronunciation training.
                              // TODO: Navigate back to WordDetailsScreen.
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'الخروج للتالية',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}