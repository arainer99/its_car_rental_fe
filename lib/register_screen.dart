import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its_car_rental/Services/UserService.dart';
import 'package:its_car_rental/WidgetUtils/GeneralUtils.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<StatefulWidget> {
  TextEditingController mailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController surNameController = new TextEditingController();

  final globalKey = GlobalKey<ScaffoldState>();

  void _register() async {
    final UserService userService = new UserService();
    if (userService.register(nameController.text, surNameController.text,
            mailController.text, passwordController.text) !=
        null) {
      Navigator.pushNamed(context, '/home');
      return;
    }
    globalKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Register failed!',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void test() {
    print('HI');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              alignment: Alignment.topLeft,
              child: BackButton(),
            ),
            Header('Neuen Account erstellen', color: Colors.blue),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: surNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Vorname',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nachname',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: mailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-Mail',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Passwort',
                ),
              ),
            ),
            FlatButton(
              height: 40,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                child: Text('Registrieren'),
              ),
              onPressed: _register,
            ),
          ],
        ),
      ),
    );
  }
}
