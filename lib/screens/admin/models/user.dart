import 'package:brianpharmacy/screens/admin/models/drug.dart';
//datatype
class User {
  String? id;
  String name;
  List<Drug> drugs;
  List<String> location;
  String profession;
  String mobileNumber;
//constructor
  User({
    this.id,
    required this.name,
    required this.drugs,
    required this.location,
    required this.profession,
    required this.mobileNumber,
  });
// converting json file into a data 
  factory User.fromJson(Map<String, dynamic> json) {
    final List<dynamic> drugJson = json['drugs'] ?? [];
    final List<Drug> drugs = drugJson.map((dynamic item) => Drug.fromJson(item)).toList();
    return User(
      id: json['id'],
      name: json['name'],
      drugs: drugs,
      location: List<String>.from(json['location'] ?? []),
      profession: json['profession'],
      mobileNumber: json['mobileNumber'],
    );
  }
//assigning data to each variable
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['drugs'] = drugs.map((drug) => drug.toJson()).toList();
    data['location'] = location;
    data['profession'] = profession;
    data['mobileNumber'] = mobileNumber;
    return data;
  }
}
