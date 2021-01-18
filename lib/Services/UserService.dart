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

  UserDTO get user => _user;

  Future<UserDTO> login(String email, String password) async {
    final String body = jsonEncode(<String, String>{
      'email': email,
      'password': password
    });
    try {
      final http.Response response = await HttpService.postRequest('auth/login', body);
      SecureStorageService().addItem('jwt', jsonDecode(response.body)['token']['accessToken']);
      _user = new UserDTO.fromJsonFactory(jsonDecode(response.body)['user']);
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
      SecureStorageService().addItem('jwt', jsonDecode(response.body)['token']['accessToken']);
      _user = new UserDTO.fromJsonFactory(jsonDecode(response.body)['user']);
    } catch (Exception) {
      print('Register failed');
      return null;
    }
    return _user;
  }
}