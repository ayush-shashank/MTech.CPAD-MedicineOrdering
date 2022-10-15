import 'dart:convert';

import 'package:http/http.dart';
import 'package:order_med/globals.dart' as globals;

class NetworkService {
  static NetworkService? _instance;
  // Avoid self instance
  NetworkService._();
  static NetworkService get instance {
    _instance ??= NetworkService._();
    return _instance!;
  }

  static String baseUrl = globals.baseUrl;

  static Future<dynamic> fetch(String path, {Object? body}) async {
    final uri = Uri.parse("$baseUrl$path");
    var headers = <String, String>{
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*",
      'Content-Type': 'application/json; charset=UTF-8'
    };
    Response response;
    if (body == null) {
      print('GET  \t $uri');
      response = await get(uri, headers: headers);
    } else {
      print('POST  \t $uri');
      response = await post(uri, headers: headers, body: jsonEncode(body));
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return response.body;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to fetch');
    }
  }
}
