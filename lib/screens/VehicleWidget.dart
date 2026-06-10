//import 'package:app/AppDrawer.dart';
//import 'package:app/Translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'Translations.dart';

class Vehicle extends StatelessWidget {
  const Vehicle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vehicle'),),
      drawer: AppDrawer(),
      body: Translations(),
    );
  }
}
