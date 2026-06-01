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