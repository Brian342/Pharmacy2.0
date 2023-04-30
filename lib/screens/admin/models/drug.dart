class Drug {
  String name;
  double price;

  Drug({
    required this.name,
    required this.price,
  });

  factory Drug.fromJson(Map<String, dynamic> json) {
    return Drug(
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
