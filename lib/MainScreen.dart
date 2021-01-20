import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its_car_rental/DTOs/VehicleCategoryDTO.dart';
import 'package:its_car_rental/Services/UserService.dart';
import 'package:its_car_rental/Services/VehicleService.dart';

import 'UserPopupMenuButton.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  UserService userService = new UserService();
  VehicleService vehicleService = new VehicleService();

  List<VehicleCategoryDTO> vehicleCategories = new List();

  String _jwt;

  String _getJwt() {
    userService.getJwt().then((value) => setState(() {
          _jwt = value;
        }));

    return _jwt;
  }

  void getVehicleCategories() async {
    final List<VehicleCategoryDTO> _vehicles =
        await vehicleService.getCategories(userService.jwt);
    setState(() {
      this.vehicleCategories = _vehicles;
    });
  }

  String _getUrl([String url]) {
    return url != null && url.length == 0
        ? url
        : 'https://torqueconsultants.com/wp-content/plugins/tbs-car-catalog/images/no-image.png';
  }

  @override
  void initState() {
    super.initState();
    this.getVehicleCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: [UserPopupMenuButton()],
        toolbarHeight: 40.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: vehicleCategories.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                print('Tapped on: ' + vehicleCategories[index].name);
              },
              title: Row(
                children: [
                  Image.network(
                    _getUrl(vehicleCategories[index].iconUrl),
                    height: 70,
                  ),
                  Text(
                    vehicleCategories[index].name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
