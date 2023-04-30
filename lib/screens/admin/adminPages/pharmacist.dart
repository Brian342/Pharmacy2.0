import 'package:brianpharmacy/screens/admin/adminPages/admin_details.dart';
import 'package:brianpharmacy/screens/dashboard/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PharamcistPage extends StatefulWidget {
  const PharamcistPage({super.key});

  @override
  State<PharamcistPage> createState() => _PharamcistPageState();
}

class _PharamcistPageState extends State<PharamcistPage> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.add, size: 32),
              label: const Text(
                'Add profile',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminDetails()),
                  );
                });
              }),
          const Text(
            'signed in as',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            "${user?.email}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.arrow_back, size: 32),
              label: const Text(
                'sign out',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                });
              }),
        ],
      ),
    ));
  }
}
