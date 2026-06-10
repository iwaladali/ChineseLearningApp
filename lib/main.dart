import 'package:flutter/material.dart';
import 'package:flutter_project/screens/vocabulary_add.dart';
import 'package:flutter_project/screens/vocabulary_show.dart';
import 'screens/VehicleWidget.dart';
import 'screens/LanguageWidget.dart';
import 'screens/FoodWidget.dart';
import 'screens/AnotherWidget.dart';
import 'screens/NotificationWidget.dart';
import 'screens/HomePage.dart';
import 'screens/SettingsWidget.dart';

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
import 'package:flutter_project/screens/profile_screen.dart';
import 'package:flutter_project/screens/vocabulary_screen.dart';
import 'package:flutter_project/screens/word_details_screen.dart';
import 'package:flutter_project/screens/progress_screen.dart';
import 'package:flutter_project/screens/pronunciation_training_screen.dart';
import 'package:flutter_project/providers/speech_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>VocabularyProvider()),
      ChangeNotifierProvider(create: (_)=>SpeechProvider()),
    ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      routes: {
        '/' : (BuildContext ctx) => HomePage(),
        '/food': (BuildContext ctx) => Food(),
        '/language': (BuildContext ctx) => Language(),
        '/another': (BuildContext ctx) => Another(),
        '/vehicle': (BuildContext ctx) => Vehicle(),
        '/setting' : (BuildContext ctx) => Settings(),
        '/notification' : (BuildContext ctx) => NotificationWidget(),
        '/addVocabulary' : (BuildContext ctx) => VocabularyAdd(),
        '/showVocabulary' : (BuildContext ctx) => VocabularyShow()
      },
    );
  }
}