//import 'package:app/FoodWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'FoodWidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('China'),
      ),

      drawer: AppDrawer(),

      body: ListView(
        children: [

          Row(
            children: [
              buildCard(context, Icons.food_bank, '/food'),
              buildCard(context, Icons.language, '/language'),
            ],
          ),

          Row(
            children: [
              buildCard(context, Icons.car_rental, '/vehicle'),
              buildCard(context, Icons.devices_other_sharp, '/another'),
            ],
          ),

          Row(
            children: [
              buildCard(context, Icons.show_chart, '/showVocabulary'),
            ],
          ),

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addVocabulary'),
        child: const Icon(Icons.add),
      ),
    );
  }
}


Widget buildCard(BuildContext context, IconData icon, String route) {
  return Expanded(
    child: Container(
      height: 150,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Center(
          child: Icon(icon, size: 60, color: Colors.white),
        ),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    ),
  );
}
