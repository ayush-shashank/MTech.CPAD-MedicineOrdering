class Product {
  String? _id;
  String? _name;
  num? _weightInGrams;
  num? _price;
  int? _quantityAvailable;
  String? _productImage;
  bool? _doesRequirePrescription;
  DateTime? _createdAt;
  DateTime? _updatedAt;
  int discount = 50;

  Product();
  double get salePrice {
    return (_price! * (100 - discount)).round() / 100;
  }

  String? get id => _id;
  set id(String? value) => _id = value;

  String get name => _name ?? '';
  set name(String value) => _name = value;

  get weightInGrams => _weightInGrams;
  set weightInGrams(value) => _weightInGrams = value;

  get price => _price;
  set price(value) => _price = value;

  get quantityAvailable => _quantityAvailable;
  set quantityAvailable(value) => _quantityAvailable = value;

  String? get productImage => _productImage;
  set productImage(String? value) => _productImage = value;

  get doesRequirePrescription => _doesRequirePrescription;
  set doesRequirePrescription(value) => _doesRequirePrescription = value;

  get createdAt => _createdAt;
  set createdAt(value) => _createdAt = value;

  get updatedAt => _updatedAt;
  set updatedAt(value) => _updatedAt = value;

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    _name = json['name'] ?? '';
    _weightInGrams = json['weightInGrams'];
    _price = json['price'];
    discount = json['discount'];
    _quantityAvailable = json['quantityAvailable'] ?? 0;
    _productImage = (json['productImageURL']);
    _doesRequirePrescription = json['doesRequirePrescription'] ?? false;
    _createdAt =
        DateTime.tryParse(json['createdAt'] ?? DateTime.now().toString());
    _updatedAt =
        DateTime.tryParse(json['updatedAt'] ?? DateTime.now().toString());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = _id;
    data['name'] = _name;
    data['weightInGrams'] = _weightInGrams;
    data['price'] = _price;
    data['quantityAvailable'] = _quantityAvailable;
    data['productImageURL'] = _productImage;
    data['doesRequirePrescription'] = _doesRequirePrescription;
    data['createdAt'] = _createdAt?.toIso8601String();
    data['updatedAt'] = _updatedAt?.toIso8601String();
    return data;
  }
}
