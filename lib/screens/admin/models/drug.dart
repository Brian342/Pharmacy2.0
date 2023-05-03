//datatypes
class Drug {
  String name;
  double price;
//constructor
  Drug({
    required this.name,
    required this.price,
  });
//converting json file into a data
  factory Drug.fromJson(Map<String, dynamic> json) {
    return Drug(
      name: json['name'],
      price: json['price'],
    );
  }
//assigning data to each variable 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
