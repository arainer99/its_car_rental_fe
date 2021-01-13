import 'package:http/http.dart' as http;

class HttpService {
  static final String base_url = 'http://192.168.130.44:3000/api/v1/';
  static final Map<String, String> headers = {"Content-type": "application/json"};

  static Future<http.Response> postRequest(String endpoint, String body) async {
    final http.Response response = await http.post(base_url + endpoint, headers: headers, body: body);
    if(response.statusCode != 201) {
      throw Exception('Network Request (POST) failed!');
    }
    return response;
  }
}