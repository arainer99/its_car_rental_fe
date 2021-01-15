import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Andreas/FH_ITS/WS20/SWD/Flutter-FE/its_car_rental/lib/Services/SecureStorageService.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  String _jwt = 'empty';

  String _getJwt() {
    SecureStorageService().getItem('jwt').then((value) => setState(() {
      _jwt = value;
    }));

    return _jwt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Text('Logged in with jwt-key: '),
            Text(_getJwt()),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: RaisedButton(
                child: Text('Go Back'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
