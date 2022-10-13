import 'package:http/http.dart';

class Service {
  static String baseUrl = 'http://192.168.1.3:3000';

  static Future<dynamic> fetch(String path, {Object? body}) async {
    final uri = Uri.parse("$baseUrl$path");
    var headers = {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    };

    Response response;
    if (body == null) {
      response = await get(uri, headers: headers);
    } else {
      response = await post(uri, headers: headers, body: body);
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch');
    }
  }
}
