//import 'package:app/AppDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Translations.dart';
import 'AppDrawer.dart';

class Another extends StatelessWidget {
  const Another({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Another'),),
      drawer: AppDrawer(),
      body: Translations(),
    );
  }
}
