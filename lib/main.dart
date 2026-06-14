import 'package:flutter/material.dart';
import 'package:flutter_project/providers/profile_provider.dart';
import 'package:flutter_project/screens/vocabulary_add.dart';
import 'package:flutter_project/screens/vocabulary_show.dart';

import 'screens/SettingsWidget.dart';
import 'package:flutter_project/providers/auth_provider.dart';
import 'package:flutter_project/services/auth_service.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project/providers/audio_provider.dart';
import 'package:flutter_project/providers/speech_provider.dart';

import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'package:flutter_project/providers/vocabulary_provider.dart';


import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/screens/register_screen.dart';
import 'package:flutter_project/screens/home_screen.dart';

import 'package:flutter_project/screens/vocabulary_screen.dart';
import 'package:flutter_project/screens/word_details_screen.dart';
import 'package:flutter_project/screens/progress_screen.dart';

import 'package:flutter_project/screens/pronunciation_training_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
     
    MultiProvider(
      providers: [
         ChangeNotifierProvider(
            create: (_) => AuthenticatProvider(
              authService: AuthService(),
            ),
          ),
        ChangeNotifierProvider(
          create: (_) => VocabularyProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SpeechProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AudioProvider(),
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

        '/Progress': (BuildContext ctx) => const ProgressScreen(),
        '/Pronunciation': (BuildContext ctx) => const PronunciationTrainingScreen(),
        '/': (BuildContext ctx) => const LoginScreen(),
        '/VocabularyScreen': (BuildContext ctx) => const VocabularyScreen(),

        '/addVocabulary': (BuildContext ctx) => VocabularyAdd(),
        '/showVocabulary': (BuildContext ctx) => VocabularyShow(),
        '/RegisterScreen': (BuildContext ctx) => RegisterScreen(),
        '/HomeScreen': (BuildContext ctx) => HomeScreen(),
        '/wordDetails': (BuildContext ctx) => WordDetailsScreen(),
        '/PronunciationTrainingScreen': (BuildContext ctx) => PronunciationTrainingScreen(),
        '/Settings': (BuildContext ctx) => Settings(),


      },
    );
  }
}