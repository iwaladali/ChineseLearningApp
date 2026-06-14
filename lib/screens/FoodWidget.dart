//import 'package:app/AppDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Translations.dart';
import 'AppDrawer.dart';

class Food extends StatelessWidget {
  const Food({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food'),),
      drawer: AppDrawer(),
      body: Translations(),
    );
  }
}
