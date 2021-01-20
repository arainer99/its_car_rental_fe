import 'package:its_car_rental/DTOs/BaseDTO.dart';

class VehicleCategoryDTO extends BaseDTO {
  String name;
  String iconUrl;

  VehicleCategoryDTO(id, this.name, this.iconUrl, createdAt, updatedAt) : super(id, createdAt, updatedAt);

  VehicleCategoryDTO.fromJson(Map<String, dynamic> json) : super(json['id'], json['createdAt'], json['updatedAt']) {
    name = json['name'];
    iconUrl = json['iconUrl'];
  }

  factory VehicleCategoryDTO.fromJsonFactory(Map<String, dynamic> json) {
    return VehicleCategoryDTO.fromJson(json);
  }
}