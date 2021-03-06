import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'SplashScreen.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';
import 'MainPage.dart';
import 'UserInterface.dart';

class CommonThings {
  static double _width;
  static double _height;
  static String _address;

  CommonThings() {
    _width = 0;
    _height = 0;
    _address = '/';
  }

  void setSize(Size size) {
    _width = size.width;
    _height = size.height;
  }

  double getWidth() {
    return _width;
  }

  double getHeight() {
    return _height;
  }

  void setAddress(String currentAddress) {
    _address = currentAddress;
  }

  String getAddress() {
    return _address;
  }
}

void main() => runApp(MyApp());

CommonThings common = new CommonThings();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: common.getAddress(),
      routes: {
        "/": (context) => SplashScreen(),
        "/login": (context) => LoginPage(),
        "/main": (context) => MainPage(),
        "/signUp": (context) => SignUpPage(),
      },
    );
  }
}

void pushText(String s) {
  print('push ' + s);
}
