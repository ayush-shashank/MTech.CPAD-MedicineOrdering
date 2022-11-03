class Order {
  String? _id;
  String? _customerId;
  String? _productId;
  String? _productName;
  int? _quantity = 0;
  double? _orderAmount = 0;
  bool _isActive = true;
  String _prescriptionURL = '';
  String _productImageURL = '';
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

  String get prescriptionURL => _prescriptionURL;
  set prescriptionURL(String value) => _prescriptionURL = value;

  String get productImageURL => _productImageURL;
  set productImageURL(String value) => _productImageURL = value;

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
    _productImageURL = json['productImageURL'];
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
    data['productImageURL'] = _productImageURL;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    return data;
  }
}
