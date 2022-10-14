class Order {
  late final String _id;
  late final String _customerId;
  late final String _productId;
  late final String _productName;
  late final int _quantity;
  late final double _orderAmount;
  late final bool _isActive;
  late final List<dynamic> _prescription;
  late final DateTime _createdAt;
  late final DateTime _updatedAt;

  Order({
    id,
    required customerId,
    required productId,
    productName,
    required quantity,
    orderAmount,
    isActive,
    prescription,
    createdAt,
    updatedAt,
  });

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

  get prescription => _prescription;
  set prescription(value) => _prescription = value;

  get createdAt => _createdAt;
  set createdAt(value) => _createdAt = value;

  get updatedAt => _updatedAt;
  set updatedAt(value) => _updatedAt = value;

  Order.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    _customerId = json['customerId'];
    _productId = json['productId'];
    _productName = json['productName'];
    _quantity = json['quantity'];
    _orderAmount = json['orderAmount'];
    _isActive = json['isActive'];
    _prescription = List.castFrom<dynamic, dynamic>(json['prescription']);
    _createdAt = DateTime.parse(json['createdAt']);
    _updatedAt = DateTime.parse(json['updatedAt']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['customerId'] = _customerId;
    data['productId'] = _productId;
    data['productName'] = _productName;
    data['quantity'] = _quantity;
    data['orderAmount'] = _orderAmount;
    data['isActive'] = _isActive;
    data['prescription'] = _prescription;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    return data;
  }
}
