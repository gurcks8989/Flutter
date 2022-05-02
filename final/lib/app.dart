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

import 'home.dart';
import 'login.dart';

const routeHome = '/home';
const routeMain = '/main';
const routeLogin = '/login';
const routeSignUp = '/signup';
const routeSearch = '/search';
const routeDetail = '/detail';
const routeFavorite = '/favorite';
const routeMyPage = '/mypage';

// TODO: Convert ShrineApp to stateful widget (104)
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'final',
      home: const HomePage(),
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
      case routeMain:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case routeLogin:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      // case routeFavorite:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return FavoritePage(hotels: settings.arguments! as List<Hotel>) ;
      //     },
      //   ) ;
      // case routeMyPage:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return MyPage(hotels: settings.arguments! as List<Hotel>) ;
      //     },
      //   ) ;
      default :
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text('No route defined for ${settings.name}')),
          )
        );
    }
  }
}