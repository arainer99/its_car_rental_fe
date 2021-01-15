import 'package:flutter/material.dart';
import 'package:its_car_rental/Login_Screen.dart';
import 'package:its_car_rental/MainScreen.dart';
import 'package:its_car_rental/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarRental',
      theme: ThemeData(
        primaryColor: Colors.blue[800],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        // '/': (context) => LoginPage(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => MainScreen(),
      },
      home: LoginPage()
    );
  }
}