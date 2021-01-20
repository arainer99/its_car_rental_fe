import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:its_car_rental/DTOs/userDTO.dart';
import 'SecureStorageService.dart';
import 'httpService.dart';
import 'dart:convert';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  UserDTO _user;
  String _jwt;

  UserDTO get user => _user;
  String get jwt => _jwt;

  bool isAdmin() => _user.role == 'admin';

  Future<String> getJwt() async {
    return SecureStorageService().getItem('jwt');
  }

  Future<UserDTO> login(String email, String password) async {
    final String body = jsonEncode(<String, String>{
      'email': email,
      'password': password
    });
    try {
      final http.Response response = await HttpService.postRequest('auth/login', body);
      this._jwt = jsonDecode(response.body)['accessToken'];
      SecureStorageService().addItem('jwt', this._jwt);
      final http.Response userResponse = await HttpService.getRequest('auth/_me', jwt);
      _user = new UserDTO.fromJsonFactory(jsonDecode(userResponse.body));
    } catch (Exception) {
      print('LOGIN FAILED');
      return null;
    }
    return _user;
  }

  Future<UserDTO> register(String name, surname, email, password) async {
    final String body = jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'firstName': name,
      'lastName': surname
    });
    try {
      final http.Response response = await HttpService.postRequest('auth/register', body);
      this._jwt = jsonDecode(response.body)['token']['accessToken'];
      SecureStorageService().addItem('jwt', this._jwt);
      _user = new UserDTO.fromJsonFactory(jsonDecode(response.body)['user']);
    } catch (Exception) {
      print('Register failed');
      return null;
    }
    return _user;
  }

  Future<bool> checkLogin() async {
    if(this._user == null || this._jwt == null || this._jwt == "") {
      try {
        final String jwtToken = await SecureStorageService().getItem('jwt');
        final http.Response userResponse = await HttpService.getRequest('auth/_me', jwtToken);
        _user = new UserDTO.fromJsonFactory(jsonDecode(userResponse.body));
        _jwt = jwtToken;
        return true;
      } catch(Exception) {
        _jwt = null;
        _user = null;
        return false;
      }
    }
    return true;
  }

  logout(BuildContext context) {
    SecureStorageService().deleteItem('jwt');
    this._jwt = null;
    Navigator.pushNamed(context, '/');
  }
}