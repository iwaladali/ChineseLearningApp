import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/providers/vocabulary_provider.dart';
import 'package:flutter_project/models/DTO/vocabulary_response.dart';
import 'package:flutter_project/widgets/quiz_answer_tile.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class QuizQuestion {
  final String chinese;
  final String pinyin;
  final String correctAnswer;
  final List<String> options;

  QuizQuestion({
    required this.chinese,
    required this.pinyin,
    required this.correctAnswer,
    required this.options,
  });
}

class _QuizScreenState extends State<QuizScreen> {
  // Theme highlights
  static const Color primaryRed = Color(0xFFE53935);
  static const Color surfaceColor = Color(0xFFF8F8F8);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentYellow = Color(0xFFF59E0B);
  static const Color darkSlate = Color(0xFF1F2937);
  static const Color subText = Color(0xFF6B7280);

  bool _loading = true;
  List<QuizQuestion> _questions = [];
  int _currentIndex = 0;
  int _selectedAnswerIndex = -1;
  bool? _isCorrect;
  int _score = 0;
  bool? isAdded = false;

  @override
  void initState() {
    super.initState();
    _initializeQuiz();
  }

  final Random _random = Random();

  Future<void> _initializeQuiz() async {
    try {
      final vocabProvider = context.read<VocabularyProvider>();
      
      if (vocabProvider.vocabularies.isEmpty) {
        await vocabProvider.loadVocabularies().timeout(const Duration(seconds: 10));
      }

      final dataSource = vocabProvider.vocabularies;

      if (mounted) {
        if (dataSource.isNotEmpty) {
          setState(() {
            final shuffledData = List.from(dataSource)..shuffle(_random);
            final selectedItems = shuffledData.take(min(10, shuffledData.length)).toList();
            _questions = selectedItems.map((item) => _buildQuestion(item, dataSource)).toList();
            _loading = false;
          });
        } else {
          setState(() {
            _loading = false;
            _questions = [];
          });
        }
      }
    } catch (e) {
      debugPrint("Quiz initialization error: $e");
      if (mounted) {
        setState(() {
          _loading = false;
          _questions = [];
        });
      }
    }
  }

  QuizQuestion _buildQuestion(dynamic item, List<dynamic> allData) {
    String chinese = "";
    String pinyin = "";
    String correctAnswer = "";

    if (item is VocabularyResponse) {
      chinese = item.chinese;
      pinyin = item.pinyin;
      correctAnswer = item.arabic;
    } else {
      chinese = item['word'] ?? item['chinese'] ?? "";
      pinyin = item['pinyin'] ?? "";
      correctAnswer = (item['arabic'] is List) ? item['arabic'][0] : (item['arabic'] ?? "");
    }

    final options = <String>{correctAnswer};
    int safetyBreak = 0;
    
    // Pick 3 more random unique answers from allData
    while (options.length < 4 && safetyBreak < 100) {
      final rItem = allData[_random.nextInt(allData.length)];
      String rAnswer = "";
      if (rItem is VocabularyResponse) {
        rAnswer = rItem.arabic;
      } else {
        rAnswer = (rItem['arabic'] is List) ? rItem['arabic'][0] : (rItem['arabic'] ?? "");
      }
      if (rAnswer.isNotEmpty) options.add(rAnswer);
      safetyBreak++;
    }

    // Pad if not enough unique data exists
    while (options.length < 4) {
      options.add("خيار ${options.length + 1}");
    }

    final optionsList = options.toList()..shuffle(_random);

    return QuizQuestion(
      chinese: chinese,
      pinyin: pinyin,
      correctAnswer: correctAnswer,
      options: optionsList,
    );
  }
  void _handleAnswer(int index) {
    //if (_selectedAnswerIndex != -1) return; // Prevent change answer

    setState(() {
      _selectedAnswerIndex = index;
      _isCorrect = _questions[_currentIndex].options[index] == _questions[_currentIndex].correctAnswer;
      if (_isCorrect! && isAdded == false)
        {
          _score++;
          isAdded = true;
        }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswerIndex = -1;
        _isCorrect = null;
        isAdded = false;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('انتهى الاختبار', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('لقد حصلت على $_score من ${_questions.length}', 
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 20),
            const Icon(Icons.emoji_events, color: accentYellow, size: 64),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('رجوع للقائمة', style: TextStyle(color: primaryRed)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: primaryRed),
        ),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: surfaceColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: darkSlate),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.menu_book_outlined, size: 80, color: subText),
                const SizedBox(height: 24),
                const Text(
                  'لا توجد مفردات متاحة',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: darkSlate),
                ),
                const SizedBox(height: 12),
                const Text(
                  'يرجى إضافة كلمات إلى القاموس أولاً لتتمكن من إجراء الاختبار.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: subText),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryRed,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('رجوع', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final currentQuestion = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: surfaceColor,
        body: SafeArea(
          child: Column(
            children: [
              // Header section
              _buildHeader(progress),
              
              // Progress Stats
              _buildStatsRow(),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      _buildQuestionCard(currentQuestion),
                      const SizedBox(height: 32),
                      _buildAnswerList(currentQuestion),
                      const SizedBox(height: 24),
                      _buildFeedbackArea(),
                    ],
                  ),
                ),
              ),

              // Bottom Action Bar
              _buildBottomButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double progress) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.black12,
                  elevation: 2,
                ),
              ),
              const Expanded(
                child: Text(
                  'اختبار المفردات',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: darkSlate,
                  ),
                ),
              ),
              const SizedBox(width: 48), // Spacer for centering
            ],
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(primaryRed),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'السؤال ${_currentIndex + 1} من ${_questions.length}',
            style: const TextStyle(color: subText, fontWeight: FontWeight.w600, fontSize: 13),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: accentGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: accentGreen, size: 14),
                const SizedBox(width: 4),
                Text(
                  'النقاط: $_score',
                  style: const TextStyle(color: accentGreen, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(QuizQuestion question) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'ما معنى هذه الكلمة؟',
            style: TextStyle(color: subText.withValues(alpha: 0.8), fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          Text(
            question.chinese,
            style: const TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: primaryRed,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            question.pinyin,
            style: const TextStyle(
              fontSize: 22,
              color: subText,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerList(QuizQuestion question) {
    return Column(
      children: List.generate(question.options.length, (index) {
        final option = question.options[index];
        final isSelected = _selectedAnswerIndex == index;
        
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 12),
          child: QuizAnswerTile(
            answer: option,
            isSelected: isSelected,
            onTap: () => _handleAnswer(index),

          ),
        );
      }),
    );
  }

  Widget _buildFeedbackArea() {
    if (_selectedAnswerIndex == -1) return const SizedBox.shrink();

    return AnimatedOpacity(
      opacity: 1,
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isCorrect! ? accentGreen.withValues(alpha: 0.1) : primaryRed.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isCorrect! ? accentGreen.withValues(alpha: 0.3) : primaryRed.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              _isCorrect! ? Icons.check_circle : Icons.error,
              color: _isCorrect! ? accentGreen : primaryRed,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _isCorrect! ? 'رائع! إجابة صحيحة' : 'للأسف، الإجابة غير صحيحة',
                style: TextStyle(
                  color: _isCorrect! ? accentGreen : primaryRed,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            if (!_isCorrect!)
              Text(
                'الصحيح: ${_questions[_currentIndex].correctAnswer}',
                style: const TextStyle(color: subText, fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryRed,
            foregroundColor: Colors.white,
            elevation: 8,
            shadowColor: primaryRed.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            disabledBackgroundColor: Colors.grey.shade300,
          ),
          onPressed: _selectedAnswerIndex == -1 ? null : _nextQuestion,
          child: Text(
            _currentIndex < _questions.length - 1 ? 'السؤال التالي' : 'عرض النتائج',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
