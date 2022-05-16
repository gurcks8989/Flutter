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
import 'package:shrine/profile.dart';

import 'addProduct.dart';
import 'detail.dart';
import 'editProduct.dart';
import 'home.dart';
import 'login.dart';
import 'product.dart';

const routeLogin = '/login';
const routeHome = '/main';
const routeAddProduct = '/addProduct';
const routeDetail = '/detail';
const routeEditProduct = '/edit' ;
const routeProfile = '/profile';

enum ApplicationLoginState {
  loggedOut,
  googleLogin,
  guestLogin,
}

// TODO: Convert ShrineApp to stateful widget (104)
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'final',
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
      case routeAddProduct:
        return MaterialPageRoute(builder: (_) => const AddProductPage());
      case routeDetail:
        return MaterialPageRoute(
          builder: (context) {
            return DetailPage(product: settings.arguments! as ProductElement) ;
          },
        ) ;
      case routeEditProduct:
        return MaterialPageRoute(
          builder: (context) {
            return EditProductPage(product: settings.arguments! as ProductElement) ;
          },
        ) ;
      case routeProfile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      default :
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}