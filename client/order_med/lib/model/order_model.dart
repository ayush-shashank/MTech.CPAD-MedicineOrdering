class Order {
  String? _id;
  String? _customerId;
  String? _productId;
  String? _productName;
  int? _quantity;
  double? _orderAmount;
  bool? _isActive;
  String? _prescriptionURL;
  DateTime? _createdAt;
  DateTime? _updatedAt;

  Order();

  get id => _id;
  set id(value) => _id = value;

  get customerId => _customerId;
  set customerId(value) => _customerId = value;

  get productId => _productId;
  set productId(value) => _productId = value;

  get productName => _productName;
  set productName(value) => _productName = value;

  get quantity => _quantity;
  set quantity(value) => _quantity = value;

  get orderAmount => _orderAmount;
  set orderAmount(value) => _orderAmount = value;

  get isActive => _isActive;
  set isActive(value) => _isActive = value;

  get prescriptionURL => _prescriptionURL;
  set prescription(value) => _prescriptionURL = value;

  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? value) => _createdAt = value;

  DateTime? get updatedAt => _updatedAt;
  set updatedAt(DateTime? value) => _updatedAt = value;

  Order.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    _customerId = json['customerId'];
    _productId = json['productId'];
    _productName = json['productName'] ?? '';
    _quantity = json['quantity'] ?? 0;
    _orderAmount = json['orderAmount'] ?? 0;
    _isActive = json['isActive'];
    _prescriptionURL = json['prescriptionURL'];
    _createdAt = DateTime.tryParse(json['createdAt']);
    _updatedAt = DateTime.tryParse(json['updatedAt']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['customerId'] = _customerId;
    data['productId'] = _productId;
    data['productName'] = _productName;
    data['quantity'] = _quantity;
    data['orderAmount'] = _orderAmount;
    data['isActive'] = _isActive;
    data['prescriptionURL'] = _prescriptionURL;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    return data;
  }
}
