class Product {
  String? _sId;
  String _name = '';
  num _weightInGrams = 0;
  num _price = 0;
  int _qtyAvailable = 0;
  bool _doesPrescription = false;
  String? _createdAt;
  String? _updatedAt;

  Product(
      {String? sId,
      required String name,
      required num weightInGrams,
      required num price,
      required int qtyAvailable,
      required bool doesPrescription,
      String? createdAt,
      String? updatedAt});
  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String get name => _name;
  set name(String name) => _name = name;
  num get weightInGrams => _weightInGrams;
  set weightInGrams(num weightInGrams) => _weightInGrams = weightInGrams;
  num get price => _price;
  set price(num price) => _price = price;
  int get qtyAvailable => _qtyAvailable;
  set qtyAvailable(int qtyAvailable) => _qtyAvailable = qtyAvailable;
  bool get doesPrescription => _doesPrescription;
  set doesPrescription(bool doesPrescription) =>
      _doesPrescription = doesPrescription;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  Product.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _name = json['name'];
    _weightInGrams = json['weightInGrams'];
    _price = json['price'];
    _qtyAvailable = json['qtyAvailable'];
    _doesPrescription = json['doesPrescription'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  // factory Product.fromJson(Map<String, dynamic> json) {
  //   return Product(
  //     json['_id'].toString(),
  //     json['name'].toString(),
  //     json['weightInGrams'] as num,
  //     json['price'] as double,
  //     json['qtyAvailable'] as int,
  //     json['doesPrescription'] as bool,
  //     DateTime.tryParse(json['createdAt']),
  //     DateTime.tryParse(json['updatedAt']),
  //   );
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    data['name'] = _name;
    data['weightInGrams'] = _weightInGrams;
    data['price'] = _price;
    data['qtyAvailable'] = _qtyAvailable;
    data['doesPrescription'] = _doesPrescription;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    return data;
  }
}
