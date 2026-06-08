import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/profile_option_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color primaryRed = Color(0xFFDC2626);
  static const Color lightRed = Color(0xFFFDEAEA);
  static const Color darkText = Color(0xFF2F3A3F);
  static const Color greyText = Color(0xFF9CA3AF);
  static const Color green = Color(0xFF2ECC71);
  static const Color yellowLight = Color(0xFFFFF3C4);

  @override
  Widget build(BuildContext context) {
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
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 22, 24, 28),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x11000000),
                              blurRadius: 18,
                              offset: Offset(0, 8)
                            )
                          ]
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(onPressed: (){
                                  Navigator.pop(context);
                                }, icon: const Icon(Icons.arrow_back)),
                                const Expanded(child: Text('الملف الشخصي',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: darkText,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                                ),)),
                                IconButton(onPressed: (){
                                  // TODO: Navigate to EditProfileScreen.
                                  // TODO: Allow updating user profile through ProfileProvider.
                                }, icon: const Icon(
                                  Icons.edit,
                                  color: primaryRed,
                                ))
                              ],
                            ),
                            const SizedBox(height: 18,),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    color: lightRed,
                                    shape: BoxShape.circle
                                  ),
                                  child: const Center(
                                    // TODO: Replace static first letter with ProfileProvider user initials.
                                    child: Text('أ',
                                    style: TextStyle(
                                      color: darkText,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold
                                    ),),
                                  ),
                                ),
                                const Positioned(
                                    right: 12,
                                    top: 40,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: green,
                                    ))
                              ],
                            ),
                            const SizedBox(height: 14,),
                            const Text('[userName]',
                              // TODO: Replace with ProfileProvider.userName.
                            style: TextStyle(
                              color: darkText,
                              fontSize: 26,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8
                              ),
                              decoration: BoxDecoration(
                                color: yellowLight,
                                borderRadius: BorderRadius.circular(18)
                              ),
                              child: const Text('المستوى: مبتدئ',
                                // TODO: Replace static level with ProgressProvider/ProfileProvider level.
                                style: TextStyle(
                                  color: darkText,
                                  fontSize: 15
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 26,),
                      Padding(
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('إعدادات الحساب',
                            style: TextStyle(
                              color: greyText,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                              )
                            ),
                            const SizedBox(height: 16,),
                            ProfileOptionTile(
                                icon: Icons.language,
                                iconColor: const Color(0xFF3498DB),
                                iconBackground: const Color(0xFFE3F2FD),
                                title: 'تغيير اللغة',
                                subtitle: 'العربية',
                                onTap: (){
                                  // TODO: Open language selection screen.
                                  // TODO: Save selected language using SettingsProvider.
                                }),

                            ProfileOptionTile(
                                icon: Icons.dark_mode,
                                iconColor: const Color(0xFF607D8B),
                                iconBackground: const Color(0xFFEFF4F6),
                                title: 'الوضع الليلي',
                                onTap: (){
                                  // TODO: Toggle dark mode using SettingsProvider.
                                }),

                            ProfileOptionTile(
                                icon: Icons.notifications,
                                iconColor: const Color(0xFFF1C40F),
                                iconBackground: const Color(0xFFFFF8D6),
                                title: 'التنبيهات',
                                onTap: (){
                                  // TODO: Navigate to NotificationsSettingsScreen.
                                  // TODO: Update notification preferences through SettingsProvider.
                                }),
                            
                            const SizedBox(height: 20,),
                            
                            const Text('الدعم والمساعدة',
                            style: TextStyle(
                              color: greyText,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),),

                            const SizedBox(height: 16,),

                            ProfileOptionTile(
                                icon: Icons.help_outline,
                                iconColor: const Color(0xFF2ECC71),
                                iconBackground: const Color(0xFFDFF8EA),
                                title: 'مركز المساعدة',
                                onTap: (){
                                  // TODO: Navigate to HelpCenterScreen.
                                }),
                            ProfileOptionTile(
                                icon: Icons.security,
                                iconColor: primaryRed,
                                iconBackground: lightRed,
                                title: 'سياسة الخصوصية',
                                onTap: (){
                                  // TODO: Navigate to PrivacyPolicyScreen.
                                }),
                            const SizedBox(height: 24,)


                          ],
                        ),
                      )
                    ],
                  ),
                ),),
            
          )),
        ) );
  }
}



