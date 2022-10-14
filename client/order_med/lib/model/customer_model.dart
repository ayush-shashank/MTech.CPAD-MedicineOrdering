class Customer {
  late final String _id;
  late final String _name;
  late final String _email;
  late final num _phoneNumber;
  late final String _password;
  late List<String> _orders = [];

  Customer({
    id,
    required name,
    required email,
    phoneNumber,
    required password,
    orders,
  });

  String get id => _id;
  set id(String value) => _id = value;

  get name => _name;
  set name(value) => _name = value;

  get email => _email;
  set email(value) => _email = value;

  get phoneNumber => _phoneNumber;
  set phoneNumber(value) => _phoneNumber = value;

  get password => _password;
  set password(value) => _password = value;

  get orders => _orders;
  set orders(value) => _orders = value;

  Customer.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    _name = json['_name'];
    _email = json['_email'];
    _phoneNumber = json['_phoneNumber'];
    _password = json['_password'];
    _orders = List.castFrom<dynamic, String>(json['_orders']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = _id;
    _data['_name'] = _name;
    _data['_email'] = _email;
    _data['_phoneNumber'] = _phoneNumber;
    _data['_password'] = _password;
    _data['_orders'] = _orders;
    return _data;
  }
}
