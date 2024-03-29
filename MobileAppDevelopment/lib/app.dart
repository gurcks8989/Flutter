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

import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'signup.dart';
import 'detail.dart';
import 'search.dart';
import 'model/hotel.dart';

const routeHome = '/home';
const routeMain = '/main';
const routeLogin = '/login';
const routeSignUp = '/signup';
const routeSearch = '/search';
const routeDetail = '/detail';
const routeFavorite = '/favorite';
const routeMyPage = '/mypage';

// TODO: Convert ShrineApp to stateful widget (104)
class ShrineApp extends StatelessWidget {
  const ShrineApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      // TODO: Change home: to a Backdrop with a HomePage frontLayer (104)
      home: const HomePage(),
      // TODO: Make currentCategory field take _currentCategory (104)
      // TODO: Pass _currentCategory for frontLayer (104)
      // TODO: Change backLayer field value to CategoryMenuPage (104)
      initialRoute: routeLogin,
      onGenerateRoute: _getRoute,
      theme: ThemeData(
        colorScheme: ThemeData.light().colorScheme.copyWith(
          secondary: Colors.black,
          error: Colors.red[600],
        ),
      ),
    );
  }

  Route<dynamic>? _getRoute(RouteSettings settings) {
    late Widget page;
    switch(settings.name){
      case routeMain:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case routeLogin:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case routeSignUp:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case routeDetail:
        final _hotel = settings.arguments as Hotel ;
        return MaterialPageRoute(
            builder: (context) {
              return DetailPage(hotel: _hotel) ;
            },
        ) ;
      case routeHome:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case routeSearch:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case routeFavorite:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case routeMyPage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default :
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}')),
        ));
    }
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => const LoginPage(),
      fullscreenDialog: true,
    );
  }
}

// TODO: Build a Shrine Theme (103)
// TODO: Build a Shrine Text Theme (103)
