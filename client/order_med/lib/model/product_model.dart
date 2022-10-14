class Product {
  late final String _id;
  late final String _name;
  late final int _weightInGrams;
  late final double _price;
  late final int _quantityAvailable;
  late final List<String> _productImage;
  late final bool _doesRequirePrescription;
  late final DateTime _createdAt;
  late final DateTime _updatedAt;

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

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    _name = json['_name'];
    _weightInGrams = json['_weightInGrams'];
    _price = json['_price'];
    _quantityAvailable = json['_quantityAvailable'];
    _productImage = List.castFrom<dynamic, String>(json['_productImage']);
    _doesRequirePrescription = json['_doesRequirePrescription'];
    _createdAt = DateTime.parse(json['_createdAt']);
    _updatedAt = DateTime.parse(json['_updatedAt']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = _id;
    _data['_name'] = _name;
    _data['_weightInGrams'] = _weightInGrams;
    _data['_price'] = _price;
    _data['_quantityAvailable'] = _quantityAvailable;
    _data['_productImage'] = _productImage;
    _data['_doesRequirePrescription'] = _doesRequirePrescription;
    _data['_createdAt'] = _createdAt.toIso8601String();
    _data['_updatedAt'] = _updatedAt.toIso8601String();
    return _data;
  }
}
