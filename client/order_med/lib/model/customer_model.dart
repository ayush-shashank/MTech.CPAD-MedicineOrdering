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
    _name = json['name'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _password = json['password'];
    _orders = List.castFrom<dynamic, String>(json['orders']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = _id;
    data['name'] = _name;
    data['email'] = _email;
    data['phoneNumber'] = _phoneNumber;
    data['password'] = _password;
    data['orders'] = _orders;
    return data;
  }
}
