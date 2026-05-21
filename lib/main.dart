import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_project/providers/vocabulary_provider.dart';
import 'package:flutter_project/providers/speech_provider.dart';
import 'screens/vocabulary_show.dart';
import 'screens/vocabulary_add.dart';

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
      home:MainScreen()
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Firebase Ready 🚀')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VocabularyShow()),
                  );
                },
                child: Text("Show Vocabularies")),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VocabularyAdd()),
                  );
                },
                child: Text("Add Vocabulary")),
          ],
        ),
      ),

    );
  }
}
