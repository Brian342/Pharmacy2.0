import 'package:brianpharmacy/constraints.dart';
import 'package:brianpharmacy/screens/admin/models/drug.dart';
import 'package:brianpharmacy/screens/dashboard/components/geolocation/geolocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HeaderWithSearchBox extends StatefulWidget {
  const HeaderWithSearchBox({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<HeaderWithSearchBox> createState() => _HeaderWithSearchBoxState();
}

class _HeaderWithSearchBoxState extends State<HeaderWithSearchBox> {
  String drug = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      // this will cover 20% of our total height
      height: widget.size.height * 0.3,
      child: Stack(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: 36 + kDefaultPadding),
              height: widget.size.height * 0.2 - 27,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    "Welcome",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const CircleAvatar(
                    radius: 30, // Image radius
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  )
                ],
              )),
          Positioned(
            top: 90,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            drug = val;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search for a drug",
                          hintStyle: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: const Icon(Icons.search_rounded),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: drug.isNotEmpty,
            child: Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('admin')
                        .snapshots(),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      String query = '';
                      final filteredDocs = snapshots.data!.docs.where(
                        (doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          final drugs = List<Drug>.from(
                              data['drugs'].map((d) => Drug.fromJson(d)));
                          final matches = drugs.any((drug) =>
                              drug.name.toLowerCase().contains(query));
                          return matches;
                        },
                      ).toList();

                      for (final doc in filteredDocs) {
                        final data = doc.data() as Map<String, dynamic>;
                        final drugs = List<Drug>.from(
                            data['drugs'].map((d) => Drug.fromJson(d)));
                        final matchedDrugs = drugs.where(
                            (drug) => drug.name.toLowerCase().contains(query));
                        for (final drug in matchedDrugs) {
                          print(drug.name);
                        }
                      }
                      return ListView.builder(
                        itemCount: filteredDocs.length,
                        itemBuilder: (context, index) {
                          final data = filteredDocs[index].data()
                              as Map<String, dynamic>;
                          return InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Pharmacy'),
                                    content: const Text(
                                        'Do you want to view this pharamcy details?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        GeolocationPage(
                                                  data: data,
                                                ),
                                              ));
                                        },
                                        child: const Text('Open'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              isThreeLine: true,
                              leading: Text(data['profession']),
                              title: Text(data['name']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Drug: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: data['drugs'][index]['name'],
                                        ),
                                        const TextSpan(
                                          text: ' Price: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: data['drugs'][index]['price']
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
