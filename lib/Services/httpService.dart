import 'dart:io';
import 'package:http/http.dart' as http;

class HttpService {
  static final String base_url = 'http://192.168.130.44:3000/api/v1/';

  static Map<String, String> headers([String _jwt]) {
    String bearerToken = "";
    if(_jwt != null && _jwt.length > 0) bearerToken = "Bearer " + _jwt;
    final Map<String, String> _headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: bearerToken
    };
    return _headers;
  }

  /// Helper Function for a Basic GET Request to a REST API
  static Future<http.Response> getRequest(String endpoint, [String jwt]) async {
    final http.Response response = await http.get(
        base_url + endpoint, headers: headers(jwt)
    );
    HttpService._checkHttpResponse(response);
    return response;
  }

  /// Helper Function for a Basic POST Request to a REST API
  static Future<http.Response> postRequest(String endpoint, String body, [String jwt]) async {
    final http.Response response = await http.post(
        base_url + endpoint, headers: headers(jwt), body: body);
    HttpService._checkHttpResponse(response);
    return response;
  }

  /// Helper Function for a Basic PUT Request to a REST API
  static Future<http.Response> putRequest(String endpoint, String body, [String jwt]) async {
    final http.Response response = await http.put(
        base_url + endpoint, headers: headers(jwt), body: body);
    HttpService._checkHttpResponse(response);
    return response;
  }

  /// Helper Function for a Basic DELETE Request to a REST API
  static Future<http.Response> deleteRequest(String endpoint, [String jwt]) async {
    final http.Response response = await http.delete(
        base_url + endpoint, headers: headers(jwt)
    );
    HttpService._checkHttpResponse(response);
    return response;
  }

  static void _checkHttpResponse(http.Response response) {
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Network Request (POST) failed!');
    }
  }
}