//import 'package:app/AppDrawer.dart';
//import 'package:app/Translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Translations.dart';
import 'AppDrawer.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Language'),),
      drawer: AppDrawer(),
      body: Translations(),
    );
  }
}
