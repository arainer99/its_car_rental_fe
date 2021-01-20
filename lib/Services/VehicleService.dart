import 'dart:convert';

import 'package:its_car_rental/DTOs/VehicleCategoryDTO.dart';
import 'package:its_car_rental/Services/httpService.dart';
import 'package:http/http.dart' as http;

class VehicleService {
  Future<List<VehicleCategoryDTO>> getCategories(String _jwt) async {
    final http.Response response = await HttpService.getRequest('vehicle-categories', _jwt);
    Iterable vehicleCategories = jsonDecode(response.body);
    return List<VehicleCategoryDTO>.from(vehicleCategories.map((model) => VehicleCategoryDTO.fromJsonFactory(model)));
  }
}