import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'package:flutter_project/providers/vocabulary_provider.dart';

import 'package:flutter_project/screens/splash_screen.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/screens/register_screen.dart';
import 'package:flutter_project/screens/vocabulary_add.dart';
import 'package:flutter_project/screens/vocabulary_show.dart';
import 'package:flutter_project/screens/forgot_password_screen.dart';
import 'package:flutter_project/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VocabularyProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {
        '/': (BuildContext ctx) => const HomeScreen(),

        '/login': (BuildContext ctx) => const LoginScreen(),

        '/addVocabulary': (BuildContext ctx) => VocabularyAdd(),

        '/showVocabulary': (BuildContext ctx) => VocabularyShow(),
      },
    );
  }
}