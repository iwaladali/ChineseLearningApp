import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/quiz_answer_tile1.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const Color primaryRed = Color(0xFFE53935);
  static const Color darkText = Color(0xFF2F3A3F);
  static const Color greyText = Color(0xFF9CA3AF);
  static const Color green = Color(0xFF2ECC71);
  static const Color yellow = Color(0xFFFFD600);

  int _selectedAnswerIndex = -1;

  @override
  Widget build(BuildContext context) {
    // TODO: Load quiz questions from Firestore.
    // TODO: Replace static question with QuizProvider/VocabularyProvider data.
    // TODO: Track current question index from QuizProvider.
    // TODO: Save quiz result in Firestore.
    // TODO: Update ProgressProvider after finishing quiz.

    const int currentQuestionIndex = 1;
    const int totalQuestions = 10;
    const int correctAnswers = 1;

    const String questionText = 'ما معنى كلمة';
    const String hanzi = '你好';
    const String pinyin = 'nǐ hǎo';

    final List<String> answers = [
      'شكراً',
      'مرحباً',
      'وداعاً',
      'تفاحة',
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),

                        const Expanded(
                          child: Column(
                            children: [
                              Text(
                                'اختبار المفردات',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: darkText,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'من 10 السؤال 1',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: greyText,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            // TODO: Show quiz help dialog.
                          },
                          icon: const Icon(Icons.help_outline),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 22,
                    ),
                    child: Column(
                      children: [
                        LinearProgressIndicator(
                          value: currentQuestionIndex / totalQuestions,
                          minHeight: 8,
                          backgroundColor: const Color(0xFFE5E7EB),
                          valueColor:
                          const AlwaysStoppedAnimation<Color>(primaryRed),
                          borderRadius: BorderRadius.circular(20),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              '00:45',
                              style: TextStyle(
                                color: yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'الإجابات الصحيحة: [1]',
                              style: TextStyle(
                                color: green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  questionText,
                                  style: TextStyle(
                                    color: greyText,
                                    fontSize: 16,
                                  ),
                                ),

                                SizedBox(height: 24),

                                Text(
                                  hanzi,
                                  style: TextStyle(
                                    color: primaryRed,
                                    fontSize: 42,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 14),

                                Text(
                                  pinyin,
                                  style: TextStyle(
                                    color: greyText,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 34),

                          for (int i = 0; i < answers.length; i++)
                            QuizAnswerTile(
                              answer: answers[i],
                              isSelected: _selectedAnswerIndex == i,
                              onTap: () {
                                setState(() {
                                  _selectedAnswerIndex = i;
                                });

                                // TODO: Store selected answer in QuizProvider.
                                // TODO: Check if selected answer is correct.
                              },
                            ),

                          const SizedBox(height: 18),

                          if (_selectedAnswerIndex != -1)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: darkText,
                                  ),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: Text(
                                      'أحسنت! إجابة صحيحة.',
                                      style: TextStyle(
                                        color: darkText,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          const SizedBox(height: 20),

                          SizedBox(
                            width: 170,
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryRed,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                              onPressed: _selectedAnswerIndex == -1
                                  ? null
                                  : () {
                                // TODO: Move to next question.
                                // TODO: If last question, navigate to QuizResultScreen.
                              },
                              child: const Text(
                                'السؤال التالي',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}