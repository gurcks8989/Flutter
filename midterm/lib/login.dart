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

import 'signup.dart';
import 'package:flutter/material.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 120.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                const SizedBox(height: 16.0),
                const Text('SHRINE'),
              ],
            ),
            const SizedBox(height: 120.0),
            // TODO: Wrap Username with AccentColorOverride (103)
            // TODO: Remove filled: true values (103)
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            // TODO: Wrap Password with AccentColorOverride (103)
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 6.0),
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              buttonPadding:const EdgeInsets.symmetric(horizontal: 5.0),
              children: <Widget>[
                TextButton(
                  child: const Text('CANCEL', style: TextStyle(color: Colors.black),),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                TextButton(
                  child: const Text('Sign Up', style: TextStyle(color: Colors.black),),
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUpPage()),
                    ) ;
                  },
                ),
                // TODO: Add an elevation to NEXT (103)
                // TODO: Add a beveled rectangular border to NEXT (103)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[350],
                    onPrimary: Colors.black,
                  ),
                  child: const SizedBox(width:50, child: Text('NEXT', textAlign: TextAlign.center,)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: Add AccentColorOverride (103)
