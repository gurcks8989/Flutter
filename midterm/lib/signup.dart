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

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              const SizedBox(height: 10.0),
              TextFormField(
                validator: (userName){
                  if (userName == null || userName.isEmpty) { return 'Please enter UserName' ; }
                  else if (RegExp("[0-9][a-zA-Z]|[a-zA-Z][0-9]|[0-9].[a-zA-Z]|[a-zA-Z].[0-9]").hasMatch(userName)) {
                    // Exist digit & alphabet
                    var digitCnt = 0, alphaCnt = 0 ;
                    for(int i = 0 ; i < userName.length ; i++){
                      if(isDigit(userName.codeUnitAt(i)))
                        digitCnt += 1 ;
                      if(isLetter(userName.codeUnitAt(i)))
                        alphaCnt += 1 ;
                    }
                    if(digitCnt < 3 || alphaCnt < 3)
                      return 'Username is invalid' ;
                    return null ;
                  }
                  else
                    return 'Username is invalid' ;
                  return null;
                },
                controller: _usernameController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                validator: (password){
                  if (password == null || password.isEmpty) { return 'Please enter Password' ; }
                  return null;
                },
                controller: _passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                validator: (password){
                  if (password == null || password.isEmpty) { return 'Please enter Password' ; }
                  else if(password != _passwordController.text){ return 'Confirm Password doesnʼt match Password' ; }
                  return null;
                },
                controller: _passwordConfirmController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                validator: (email){
                  if (email == null || email.isEmpty) { return 'Please enter Email Address' ; }
                  return null;
                },
                controller: _emailController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Email Address',
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[350],
                      onPrimary: Colors.black,
                    ),
                    child: const Text('SIGN UP'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isDigit(int rune) => rune ^ 0x30 <= 9;

bool isLetter(int codeUnit) =>
    (codeUnit >= 65 && codeUnit <= 90) || (codeUnit >= 97 && codeUnit <= 122);