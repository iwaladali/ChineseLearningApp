import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/login_screen.dart';

class AuthCheck extends StatelessWidget {
  final Widget child;

  const AuthCheck({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const LoginScreen();
    }

    return child;
  }
}