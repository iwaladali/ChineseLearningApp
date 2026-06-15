import 'package:flutter/material.dart';
import 'package:flutter_project/providers/profile_provider.dart';
import 'package:flutter_project/widgets/progress_stat_card.dart';
import 'package:flutter_project/widgets/achievement_tile.dart';
import 'package:provider/provider.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  static const Color primaryRed = Color(0xFFE53935);
  static const Color darkText = Color(0xFF2F3A3F);
  static const Color greyText = Color(0xFF9CA3AF);
  static const Color yellow = Color(0xFFFFD600);

  @override
  Widget build(BuildContext context) {
    // TODO: Load user progress from ProgressProvider.
    // TODO: Replace static statistics with provider values.
    // TODO: Load achievements from Firestore.
    // TODO: Add charts later after connecting ProgressProvider data.
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),

                          const Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'تقدمك الدراسي',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: darkText,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'استمر في العطاء، أنت تبلي بلاءً حسناً',
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
                              // TODO: Refresh progress data from ProgressProvider.
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: primaryRed,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: primaryRed,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'المستوى الحالي',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'مبتدئ - المستوى 2',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 28),
                                Chip(
                                  label: Text(
                                    'نشط',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Color(0xFFFF6B6B),
                                ),
                              ],
                            ),
                          ),

                          Icon(
                            Icons.military_tech,
                            color: Colors.white.withValues(alpha: 0.35),
                            size: 90,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      'الإحصائيات العامة',
                      style: TextStyle(
                        color: darkText,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 18,
                        crossAxisSpacing: 18,
                        childAspectRatio: 0.9,
                        children:  [
                          ProgressStatCard(
                            icon: Icons.menu_book,
                            iconColor: primaryRed,
                            value: '${profileProvider.profile!.wordsLearned}',
                            title: 'كلمة متعلمة',
                          ),
                          ProgressStatCard(
                            icon: Icons.mic,
                            iconColor: Color(0xFF2ECC71),
                            value: '${(profileProvider.profile!.todayProgress*100).toInt()}%',
                            title: 'متوسط النطق',
                          ),
                          ProgressStatCard(
                            icon: Icons.quiz,
                            iconColor: yellow,
                            value: '5',
                            title: 'اختبارات مكتملة',
                          ),
                          ProgressStatCard(
                            icon: Icons.local_fire_department,
                            iconColor: Color(0xFFFF5722),
                            value: '7',
                            title: 'أيام متتالية',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 34),

                    const Text(
                      'الإنجازات الأخيرة',
                      style: TextStyle(
                        color: darkText,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: AchievementTile(
                        title: 'أول 20 كلمة',
                        subtitle: 'لقد تعلمت أول 20 كلمة صينية بنجاح',
                      ),
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