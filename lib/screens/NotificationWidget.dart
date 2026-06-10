import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AppDrawer.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification'),),
      drawer: AppDrawer(),
    );
  }
}
