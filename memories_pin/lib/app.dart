// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home/home.dart';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'splashScreen.dart';
import 'login/login.dart';
import 'home/signUpPage.dart';
import 'home/home.dart';
import 'home/userInterface.dart';
import 'login/login.dart';

const routeLogin = '/login';
const routeHome = '/main';
const routeAddProduct = '/addProduct';
const routeDetail = '/detail';
const routeEditProduct = '/edit' ;
const routeProfile = '/profile';

enum ApplicationLoginState {
  loggedOut,
  login,
  email,
  password,
  register,
  googleLogin,
  guestLogin,
}

// TODO: Convert ShrineApp to stateful widget (104)
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'memories pin',
      initialRoute: routeLogin,
      onGenerateRoute: _getRoute,
      theme: ThemeData(
        colorScheme: ThemeData
            .light()
            .colorScheme
            .copyWith(
          secondary: Colors.black,
          error: Colors.red[600],
        ),
      ),
    );
  }

  Route<dynamic>? _getRoute(RouteSettings settings) {
    switch(settings.name){
      case routeLogin:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case routeHome:
        return MaterialPageRoute(builder: (_) => const HomePage());
      // case routeDetail:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return DetailPage(product: settings.arguments! as ProductElement) ;
      //     },
      //   ) ;
      // case routeEditProduct:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return EditProductPage(product: settings.arguments! as ProductElement) ;
      //     },
      //   ) ;
      default :
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}