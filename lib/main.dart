import 'package:flutter/material.dart';
// import 'package:smh_app/Screens/MainScreen.dart';
import 'package:smh_app/Screens/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen()
    );
  }
}