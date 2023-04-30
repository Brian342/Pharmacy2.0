import 'package:brianpharmacy/screens/admin/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DrugList extends StatefulWidget {
  const DrugList({super.key});

  @override
  State<DrugList> createState() => _DrugListState();
}

class _DrugListState extends State<DrugList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors list'),
      ),
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final users = snapshot.error;
            print(users);
            return const Text('Somethig went wrong');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildUser(User user) => ListTile(
        isThreeLine: true,
        leading: Text(user.profession),
        title: Text(user.name),
        subtitle: Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                  text: 'Longitude ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: user.location.first),
              const TextSpan(
                  text: 'Latitude ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: user.location.last),
            ],
          ),
        ),
      );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('admin')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
