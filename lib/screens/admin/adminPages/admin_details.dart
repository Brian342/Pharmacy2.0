import 'package:brianpharmacy/screens/admin/adminPages/admin_location.dart';
import 'package:brianpharmacy/screens/admin/models/drug.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class AdminDetails extends StatefulWidget {
  const AdminDetails({Key? key}) : super(key: key);

  @override
  State<AdminDetails> createState() => _AdminDetailsState();
}

class _AdminDetailsState extends State<AdminDetails> {
  bool selected = false;

  List<String> text = [];
  final controllerName = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerLocation = TextEditingController();
  final controllerProfessional = TextEditingController();
  final _locationController = TextEditingController();
  final controllerDrugs = TextEditingController();

  List<Drug> drugs = [];

  void _chooseLocation() async {
    final pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoationPicker(),
      ),
    );
    if (pickedLocation != null) {
      setState(
        () {
          _locationController.text =
              ' ${pickedLocation.latitude},${pickedLocation.longitude}';
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 150),
            child: SizedBox(
              child: Text(
                "Fill Form",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: controllerName,
            decoration: decoration('Full Name'),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: controllerProfessional,
            decoration: decoration('Profession'),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: decoration('Phone Number'),
            controller: controllerPhone,
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: _chooseLocation,
            child: const Text('Choose Location'),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: controllerDrugs,
            decoration: const InputDecoration(
              hintText: 'Enter drugs separated by commas',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some items';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {
              List<String> drugList = controllerDrugs.text.split(',');
              drugs.clear();
              for (var drug in drugList) {
                var parts = drug.split(':');
                var name = parts[0].trim();
                var price = double.parse(parts[1].trim());
                drugs.add(Drug(name: name, price: price));
              }

              List<String> location = _locationController.text.split(',');

              final user = User(
                name: controllerName.text,
                location: location,
                profession: controllerProfessional.text,
                mobileNumber: controllerPhone.text,
                drugs: drugs,
              );

              createUser(user);
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }

  InputDecoration decoration(String lable) => InputDecoration(
        labelText: lable,
        border: const OutlineInputBorder(),
      );

  Future createUser(User user) async {
    //Reference th backend
    final docUser = FirebaseFirestore.instance.collection('admin').doc();
    user.id = docUser.id;

    final json = user.toJson();

    //Create document and writes data to Firebase
    await docUser.set(json);
    print(json);

    // Clear the controllers
    controllerName.clear();
    controllerPhone.clear();
    controllerLocation.clear();
    controllerDrugs.clear();
    controllerProfessional.clear();

// Reload the page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const AdminDetails()),
    );
  }
}
