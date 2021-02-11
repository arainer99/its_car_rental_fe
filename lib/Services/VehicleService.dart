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
  
  Future<VehicleCategoryDTO> addCategory(String groupname, String iconUrl, String jwt) async {
    final String body = jsonEncode(<String, String>{
      'name': groupname,
      'iconUrl': iconUrl
    });
    try {
      final http.Response response = await HttpService.postRequest('vehicle-categories', body, jwt);
      final VehicleCategoryDTO newCategory = VehicleCategoryDTO.fromJsonFactory(jsonDecode(response.body));
      print('Group added');
      return newCategory;
    } catch (Exception) {
      print('Add Group has failed');
      return null;
    }
  }

  Future<bool> deleteCategory(int id, String jwt) async {
    try {
      final http.Response response = await HttpService.deleteRequest('vehicle-categories/$id', jwt);
      return true;
    } catch (Exception) {
      print ('Group could not have been deleted');
      return false;
    }
  }
}