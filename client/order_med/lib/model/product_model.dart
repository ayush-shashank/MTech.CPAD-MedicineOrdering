class Product {
  String? _id;
  String? _name;
  int? _weightInGrams;
  double? _price;
  int? _quantityAvailable;
  List<String>? _productImage;
  bool? _doesRequirePrescription;
  DateTime? _createdAt;
  DateTime? _updatedAt;

  Product({
    required id,
    required name,
    required weightInGrams,
    required price,
    required quantityAvailable,
    required productImage,
    required doesRequirePrescription,
    required createdAt,
    required updatedAt,
  });

  String? get id => _id;
  set id(String? value) => _id = value;

  get name => _name;
  set name(value) => _name = value;

  get weightInGrams => _weightInGrams;
  set weightInGrams(value) => _weightInGrams = value;

  get price => _price;
  set price(value) => _price = value;

  get quantityAvailable => _quantityAvailable;
  set quantityAvailable(value) => _quantityAvailable = value;

  get productImage => _productImage;
  set productImage(value) => _productImage = value;

  get doesRequirePrescription => _doesRequirePrescription;
  set doesRequirePrescription(value) => _doesRequirePrescription = value;

  get createdAt => _createdAt;
  set createdAt(value) => _createdAt = value;

  get updatedAt => _updatedAt;
  set updatedAt(value) => _updatedAt = value;

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    _name = json['name'] ?? '';
    _weightInGrams = json['weightInGrams'] ?? 0;
    _price = json['price'] ?? 0;
    _quantityAvailable = json['quantityAvailable'] ?? 0;
    _productImage = List.castFrom<dynamic, String>(json['productImage'] ?? []);
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
    data['productImage'] = _productImage;
    data['doesRequirePrescription'] = _doesRequirePrescription;
    data['createdAt'] = _createdAt?.toIso8601String();
    data['updatedAt'] = _updatedAt?.toIso8601String();
    return data;
  }
}
