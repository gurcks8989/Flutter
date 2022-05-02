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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut ;
  ApplicationLoginState get loginState => _loginState;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> startGoogleLoginFlow() async {
    _loginState = ApplicationLoginState.googleLogin;
    UserCredential userCredential = await signInWithGoogle() ;
    final user = userCredential.user;
    if (user != null) {
      for (final providerProfile in user.providerData) {
        final provider = providerProfile.providerId;

        final uid = providerProfile.uid;

        final name = providerProfile.displayName;
        final emailAddress = providerProfile.email;
        final profilePhoto = providerProfile.photoURL;
      }
    }
  }

  Future startGuestLoginFlow() async {
    _loginState = ApplicationLoginState.guestLogin;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      User? user = userCredential.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  get borderRadius => BorderRadius.circular(3.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 200.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset('assets/marketLogo.png'),
                const SizedBox(height: 130.0),
                Material(
                  elevation: 10,
                  borderRadius: borderRadius,
                  child: Ink(
                    color: const Color(0xFFEC9E91),
                    child: InkWell(
                      onTap: () async{
                        startGoogleLoginFlow()
                            .then((_){
                              Navigator.pop(context) ;
                            })
                            .catchError((e) => print(e));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0.0),
                        height: 50.0,//MediaQuery.of(context).size.width * .08,
                        child: Row(
                          children: <Widget>[
                            LayoutBuilder(builder: (context, constraints) {
                              return Container(
                                height: constraints.maxHeight,
                                width: constraints.maxHeight,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD35A56),
                                  borderRadius: borderRadius,
                                ),
                                child: const Icon(
                                  Icons.android,
                                  color: Colors.white,
                                ),
                              );
                            }),
                            const Expanded(
                              child: ListTile(
                                title: Text('GOOGLE'),
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Material(
                  elevation: 10,
                  borderRadius: borderRadius,
                  child: Ink(
                    color: const Color(0xFFC4C4C4),
                    child: InkWell(
                      onTap: () {
                        startGuestLoginFlow()
                            .then((_){
                          Navigator.pop(context) ;
                        })
                            .catchError((e) => print(e));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0.0),
                        height: 50.0,//MediaQuery.of(context).size.width * .08,
                        child: Row(
                          children: <Widget>[
                            LayoutBuilder(builder: (context, constraints) {
                              return Container(
                                height: constraints.maxHeight,
                                width: constraints.maxHeight,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: borderRadius,
                                ),
                                child: const Icon(
                                  Icons.question_mark,
                                  color: Colors.white,
                                ),
                              );
                            }),
                            const Expanded(
                              child: ListTile(
                                title: Text('Guest'),
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
