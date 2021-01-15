import 'package:http/http.dart' as http;

class HttpService {
  static final String base_url = 'http://192.168.130.44:3000/api/v1/';
  static final Map<String, String> headers = {"Content-type": "application/json"};

  /// Helper Function for a Basic GET Request to a REST API
  static Future<http.Response> getRequest(String endpoint) async {
    final http.Response response = await http.get(base_url + endpoint, headers: headers);
    HttpService._checkHttpResponse(response);
    return response;
  }

  /// Helper Function for a Basic POST Request to a REST API
  static Future<http.Response> postRequest(String endpoint, String body) async {
    final http.Response response = await http.post(base_url + endpoint, headers: headers, body: body);
    HttpService._checkHttpResponse(response);
    return response;
  }

  /// Helper Function for a Basic PUT Request to a REST API
  static Future<http.Response> putRequest(String endpoint, String body) async {
    final http.Response response = await http.put(base_url + endpoint, headers: headers, body: body);
    HttpService._checkHttpResponse(response);
    return response;
  }

  /// Helper Function for a Basic DELETE Request to a REST API
  static Future<http.Response> deleteRequest(String endpoint) async {
    final http.Response response = await http.delete(base_url + endpoint, headers: headers);
    HttpService._checkHttpResponse(response);
    return response;
  }

  static void _checkHttpResponse(http.Response response) {
    if(response.statusCode != 201) {
      throw Exception('Network Request (POST) failed!');
    }
  }
}