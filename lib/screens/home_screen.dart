import 'package:flutter/material.dart';
import 'package:flutter_project/providers/profile_provider.dart';
import 'package:flutter_project/widgets/home_category_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color primaryRed = Color(0xFFE53935);
  static const Color darkText = Color(0xFF2F3A3F);
  static const Color greyText = Color(0xFF9CA3AF);
  static const Color yellow = Color(0xFFFFD600);

  @override
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileProvider>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {

    final profileProvider = Provider.of<ProfileProvider>(context);
    final lvl=profileProvider.profile!.level;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // TODO: Load user name and level from AuthProvider/ProfileProvider.
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      children: [
                         CircleAvatar(
                          radius: 30,
                          backgroundColor: primaryRed,
                          child: Text(
                            '${profileProvider.profile!.displayName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                         Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'مرحباً بك!',
                                style: TextStyle(
                                  color: darkText,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(

                                '★ مستوى ${lvl}',
                                style: TextStyle(
                                  color: greyText,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            // TODO: Navigate to SettingsScreen.
                            Navigator.pushNamed(context, "/Settings");
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Color(0xFF5F6A6A),
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: primaryRed,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: primaryRed.withValues(alpha: 0.25),
                          blurRadius: 22,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'إنجاز اليوم',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                               Text(
                                ' لقد تعلمت ${profileProvider.profile!.wordsLearned} كلمات جديدة! ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),

                              const SizedBox(height: 16),

                              SizedBox(
                                width: 130,
                                height: 36,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFD4A514),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    // TODO: Navigate to Vocabulary/Learning screen.
                                    // TODO: Load today's words from VocabularyProvider.
                                    Navigator.pushNamed(context, "/VocabularyScreen");
                                  },
                                  child: const Text(
                                    'واصل التعلم',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // TODO: Replace static progress with ProgressProvider value.
                        SizedBox(
                          width: 90,
                          height: 90,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: 0.6,
                                strokeWidth: 7,
                                backgroundColor:
                                Colors.white.withValues(alpha: 0.3),
                                valueColor:
                                const AlwaysStoppedAnimation<Color>(yellow),
                              ),
                               Text(
                                '${(profileProvider.profile!.todayProgress*100).toInt()}%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'الأقسام الرئيسية',
                        style: TextStyle(
                          color: darkText,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 18,
                      childAspectRatio: 1.0,
                      children: [
                        HomeCategoryCard(
                          icon: Icons.school,
                          title: 'تعلم الكلمات',
                          subtitle: ' كلمة${profileProvider.profile!.wordsLearned}',
                          onTap: () {
                            // TODO: Navigate to VocabularyScreen.
                            // TODO: Load vocabulary list from VocabularyProvider.
                            Navigator.pushNamed(context, "/VocabularyScreen");
                          },
                        ),
                        HomeCategoryCard(
                          icon: Icons.mic,
                          title: 'تدريب النطق',
                          subtitle: 'تحسين النطق',
                          onTap: () {
                            // TODO: Navigate to PronunciationScreen.
                            // TODO: Connect with PronunciationProvider.
                            Navigator.pushNamed(context, '/Pronunciation');
                          },
                        ),
                        HomeCategoryCard(
                          icon: Icons.quiz,
                          title: 'الاختبارات',
                          subtitle: 'اختبارات 5',
                          onTap: () {
                            // TODO: Navigate to QuizScreen.
                            // TODO: Load quizzes from QuizProvider.
                          },
                        ),
                        HomeCategoryCard(
                          icon: Icons.trending_up,
                          title: 'التقدم',
                          subtitle: 'مستوى 2',
                          onTap: () {
                            // TODO: Navigate to ProgressScreen.
                            // TODO: Load progress data from ProgressProvider.
                            Navigator.pushNamed(context, '/Progress');
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 26),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFBDE3FF)),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: Color(0xFF3498DB),
                          size: 28,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            'نصيحة: تكرار الكلمات بصوت عالٍ يساعد في حفظ النغمات الصينية بشكل أسرع.',
                            style: TextStyle(
                              color: greyText,
                              fontSize: 14,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}