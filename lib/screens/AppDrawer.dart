import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      width: screenWidth < 600 ? 250 : screenWidth * 0.25,

      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/dog.jpeg'),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "My Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () =>
                  Navigator.pushNamed(context, '/'),
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () =>
                  Navigator.pushNamed(context, '/setting'),
            ),
          ),Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(Icons.notification_add),
              title: Text('notification'),
              onTap: () =>
                  Navigator.pushNamed(context, '/notification'),
            ),
          ),

        ],
      ),
    );
  }
}