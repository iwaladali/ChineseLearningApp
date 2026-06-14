import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'package:flutter_project/providers/vocabulary_provider.dart';
import 'package:flutter_project/providers/speech_provider.dart';

import 'package:flutter_project/screens/VehicleWidget.dart';
import 'package:flutter_project/screens/LanguageWidget.dart';
import 'package:flutter_project/screens/FoodWidget.dart';
import 'package:flutter_project/screens/AnotherWidget.dart';
import 'package:flutter_project/screens/NotificationWidget.dart';
import 'package:flutter_project/screens/HomePage.dart';
import 'package:flutter_project/screens/SettingsWidget.dart';

import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/screens/vocabulary_add.dart';
import 'package:flutter_project/screens/vocabulary_show.dart';
import 'package:flutter_project/screens/quiz_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VocabularyProvider()),
        ChangeNotifierProvider(create: (_) => SpeechProvider()),
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
      routes: {
        '/': (BuildContext ctx) => HomePage(),

        '/login': (BuildContext ctx) => const LoginScreen(),

        '/food': (BuildContext ctx) => Food(),
        '/language': (BuildContext ctx) => Language(),
        '/another': (BuildContext ctx) => Another(),
        '/vehicle': (BuildContext ctx) => Vehicle(),
        '/setting': (BuildContext ctx) => Settings(),
        '/notification': (BuildContext ctx) => NotificationWidget(),

        '/quiz': (BuildContext ctx) => const QuizScreen(),

        '/addVocabulary': (BuildContext ctx) => VocabularyAdd(),
        '/showVocabulary': (BuildContext ctx) => VocabularyShow(),
      },
    );
  }
}