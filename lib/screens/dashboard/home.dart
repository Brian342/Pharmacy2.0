import 'package:brianpharmacy/components/nav_bar.dart';
import 'package:brianpharmacy/constraints.dart';
import 'package:brianpharmacy/main.dart';
import 'package:brianpharmacy/screens/dashboard/components/body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Pharmacy App'),
            ),
            ListTile(
              title: const Text('Login as pharmasist'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const MainPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('About app'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: const Body(),
      bottomNavigationBar: const MyNavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
    );
  }
}
