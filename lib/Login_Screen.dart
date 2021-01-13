import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its_car_rental/WidgetUtils/GeneralUtils.dart';
import 'package:http/http.dart' as http;
import 'httpService.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _login() async {
    if (nameController.text.isEmpty || passwordController.text.isEmpty) {
      print('Insert values');
      return;
    }

    final String body = jsonEncode(<String, String>{
      'username': nameController.text,
      'password': passwordController.text
    });
    final http.Response response = await HttpService.postRequest('auth/login', body);

    print(response.body);
  }

  _showRegisterScreen() {
    Navigator.pushNamed(context, '/register');
  }

  _returnPreviousScreen() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/test.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: ListView(
              children: <Widget>[
                Header(
                  'ITS Car Rental',
                  fontSize: 30.0,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
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
                      labelText: 'Password',
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
                    child: Text('Login'),
                    onPressed: _login,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Noch keinen Account?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FlatButton(
                        // textColor: Theme.of(context).primaryColor,
                        // child: FlatButton(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
                            child: Text('Registrieren'),
                            onPressed: _showRegisterScreen,
                          ),
                        // ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
