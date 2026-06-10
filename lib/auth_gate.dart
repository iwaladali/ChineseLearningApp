import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/vocabulary_show.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();

    // تحميل المستخدم الحالي من Firebase عند فتح التطبيق
    Future.microtask(() {
    //  context.read<AuthProvider>().loadCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {

        // 🔄 لسه بفحص الحالة
        if (auth.status == AuthStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ✅ إذا المستخدم مسجل دخول
        if (auth.isLoggedIn) {
          return const VocabularyShow();
        }

        // ❌ إذا مش مسجل دخول
        return const LoginScreen();
      },
    );
  }
}