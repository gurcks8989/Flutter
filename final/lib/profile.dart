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

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'applicationState.dart';
import 'product.dart';
import 'app.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('profile'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => Navigator.pushNamed(
              context,
              routeAddProduct,
            ),
          ),
        ],
      ),
      body: Consumer<ApplicationState>(
        builder: (context, appState, _) => User(
          user: appState.user,
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class UserElement {
  String path = '' ;
  String userId = '' ;
  String email = '' ;

  UserElement(){
    path = '' ;
    userId = '' ;
    email = '' ;
  }
}

class User extends StatefulWidget{
  const User({
    required this.user,
  });
  final UserElement user;

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        AspectRatio(
          aspectRatio: 15 / 10,
            child: Image.file(
            File(widget.user.path),
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
