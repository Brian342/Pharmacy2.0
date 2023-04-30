import 'package:brianpharmacy/constraints.dart';
import 'package:brianpharmacy/screens/admin/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              final users = snapshot.error;
              print(users);
              return const Text('Somethig went wrong');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              return ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: users.map(buildUser).toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
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
                  text: 'Latitude: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: user.location.first),
              const TextSpan(
                  text: 'Longitude: ',
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

class DoctorsTile extends StatelessWidget {
  const DoctorsTile({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.press,
  });
  final String image, title, subtitle;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding / 10,
      ),
      width: size.width * 1,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: press,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30, // Image radius
                    backgroundImage: AssetImage(image),
                  ),
                  title: Text(
                    title,
                    textScaleFactor: 1.5,
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark_add_outlined)),
                  subtitle: Text(subtitle),
                  selected: true,
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
