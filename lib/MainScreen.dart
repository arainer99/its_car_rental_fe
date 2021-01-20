import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its_car_rental/DTOs/VehicleCategoryDTO.dart';
import 'package:its_car_rental/Services/UserService.dart';
import 'package:its_car_rental/Services/VehicleService.dart';
import 'package:its_car_rental/WidgetUtils/GeneralUtils.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'WidgetUtils/UserPopupMenuButton.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  UserService userService = new UserService();
  VehicleService vehicleService = new VehicleService();

  TextEditingController _groupNameController = new TextEditingController();
  TextEditingController _iconUrlController = new TextEditingController();

  List<VehicleCategoryDTO> vehicleCategories = new List();

  String _jwt;

  // String _getJwt() {
  //   userService.getJwt().then((value) => setState(() {
  //         _jwt = value;
  //       }));
  //
  //   return _jwt;
  // }

  void getVehicleCategories() async {
    final List<VehicleCategoryDTO> _vehicles =
        await vehicleService.getCategories(userService.jwt);
    setState(() {
      this.vehicleCategories = _vehicles;
    });
  }

  void checkLogin() async {
    if (await this.userService.checkLogin() == false) {
      print('User not logged in!');
      WidgetsFlutterBinding.ensureInitialized();
      Navigator.pushNamed(context, '/');
    }
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
    this.checkLogin();
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showMaterialModalBottomSheet(
            context: context,
            enableDrag: true,
            builder: (BuildContext context) {
              return Container(
                height: 500,
                color: Colors.grey[100],
                child: ListView(
                  children: <Widget>[
                    Container(
                      color: Colors.grey,
                      height: 40,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Add a new Vehicle Group',
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.save),
                              onPressed: () async {
                                final VehicleCategoryDTO newCategory =
                                    await vehicleService.addCategory(
                                        _groupNameController.text,
                                        _iconUrlController.text,
                                        userService.jwt);
                                setState(() {
                                  vehicleCategories.add(newCategory);
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    ItsOutlinedInputField(
                      labelText: 'Group-Name',
                      controller: _groupNameController,
                    ),
                    ItsOutlinedInputField(
                      labelText: 'Icon-URL',
                      controller: _iconUrlController,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
