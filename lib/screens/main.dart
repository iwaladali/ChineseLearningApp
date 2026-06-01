import 'package:flutter/material.dart';
import 'package:flutter_project/screens/vocabulary_add.dart';
import 'package:flutter_project/screens/vocabulary_show.dart';
import 'VehicleWidget.dart';
import 'LanguageWidget.dart';
import 'FoodWidget.dart';
import 'AnotherWidget.dart';
import 'NotificationWidget.dart';
import 'HomePage.dart';
import 'SettingsWidget.dart';

void main(){
  runApp(MyApp());
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