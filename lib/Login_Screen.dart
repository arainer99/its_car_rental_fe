import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its_car_rental/Services/SecureStorageService.dart';
import 'package:its_car_rental/Services/UserService.dart';
import 'package:its_car_rental/WidgetUtils/GeneralUtils.dart';

import 'DTOs/userDTO.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _checkIfAlreadyLoggedIn();
  }

  void _checkIfAlreadyLoggedIn() async {
    final String jwtToken = await SecureStorageService().getItem('jwt');
    if (jwtToken != null && jwtToken != '') {
      Navigator.pushNamed(context, '/home');
      return;
    }
  }

  Future<void> _login() async {
    if (nameController.text.isEmpty || passwordController.text.isEmpty) {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text(
          'Please provide E-Mail and Password',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    UserService userService = new UserService();
    final UserDTO user =
        await userService.login(nameController.text, passwordController.text);
    if (user != null) {
      Navigator.pushNamed(context, '/home');
      return;
    }
    globalKey.currentState.showSnackBar(SnackBar(
      content: CenteredText('Login Failed'),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

  _showRegisterScreen() {
    Navigator.pushNamed(context, '/register');
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
        key: globalKey,
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
                ItsOutlinedInputField(
                  controller: nameController,
                  labelText: 'E-Mail',
                ),
                ItsOutlinedInputField(
                  controller: passwordController,
                  labelText: 'Password',
                  obscureText: true,
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
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          child: Text('Registrieren'),
                          onPressed: _showRegisterScreen,
                        ),
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
