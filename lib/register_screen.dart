import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its_car_rental/WidgetUtils/GeneralUtils.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Header('Neuen Account erstellen', color: Colors.blue),

          ],
        ),
      ),
    );
  }
}
