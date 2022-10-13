class Customer {
  String? _sId;
  String? _name;
  String _email = '';
  int? _phno;
  String _password = '';
  List<String> _orders = [];

  Customer(
      {String? sId,
      String? name,
      required String email,
      int? phno,
      required String password,
      List<String>? orders});

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String get email => _email;
  set email(String email) => _email = email;
  int? get phno => _phno;
  set phno(int? phno) => _phno = phno;
  String get password => _password;
  set password(String password) => _password = password;
  List<String> get orders => _orders;
  set orders(List<String> orders) => _orders = orders;

  Customer.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _phno = json['phno'];
    _password = json['password'];
    _orders = json['orders'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    data['name'] = _name;
    data['email'] = _email;
    data['phno'] = _phno;
    data['password'] = _password;
    data['orders'] = _orders;
    return data;
  }
}
