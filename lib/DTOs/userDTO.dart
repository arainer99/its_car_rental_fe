import 'package:its_car_rental/DTOs/BaseDTO.dart';

class UserDTO extends BaseDTO {
  String name;
  String surName;
  String mail;
  String role;

  UserDTO(id, this.mail, this.name, this.surName, this.role) : super.onlyId(id);

  UserDTO.fromJson(Map<String, dynamic> json) : super.onlyId(json['id']) {
    mail = json['email'];
    name = json['firstName'];
    surName = json['lastName'];
    role = json['role'];
  }

  factory UserDTO.fromJsonFactory(Map<String, dynamic> json) {
    return UserDTO.fromJson(json);
  }
}