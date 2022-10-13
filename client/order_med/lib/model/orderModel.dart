class Order {
  String? _sId;
  String _customerId = '';
  String _productId = '';
  int _quantity = 0;
  bool _isActive = false;
  List<dynamic>? _prescription;
  String? _createdAt;
  String? _updatedAt;

  Order(
      {String? sId,
      required String customerId,
      required String productId,
      required int qty,
      bool? isActive,
      List<dynamic>? prescription,
      String? createdAt,
      String? updatedAt});

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String get customerId => _customerId;
  set customerId(String customerId) => _customerId = customerId;
  String get productId => _productId;
  set productId(String productId) => _productId = productId;
  int get qty => _quantity;
  set qty(int qty) => _quantity = qty;
  bool? get isActive => _isActive;
  set isActive(bool? isActive) => _isActive = isActive!;
  List<dynamic>? get prescription => _prescription;
  set prescription(List<dynamic>? prescription) => _prescription = prescription;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  Order.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _customerId = json['customerId'];
    _productId = json['productId'];
    _quantity = json['qty'];
    _isActive = json['isActive'];
    // if (json['prescription'] != null) {
    //   _prescription = <dynamic>[];
    //   json['prescription'].forEach((v) {
    //     _prescription!.add(new dynamic.fromJson(v));
    //   });
    // }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    data['customerId'] = _customerId;
    data['productId'] = _productId;
    data['qty'] = _quantity;
    data['isActive'] = _isActive;
    if (_prescription != null) {
      data['prescription'] = _prescription!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    return data;
  }
}
