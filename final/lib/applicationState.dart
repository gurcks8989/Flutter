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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shrine/app.dart';

import 'firebase_options.dart';
import 'product.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _productListSubscription = FirebaseFirestore.instance
            .collection('product')
            .orderBy('price')
            .snapshots()
            .listen((snapshot) {
          _productList = [];
          for (final document in snapshot.docs) {
            _productList.add(
              ProductElement(
                id: document.id,
                likeNum: document.data()['likeNum'] as int,
                name: document.data()['name'] as String,
                price: document.data()['price'] as int,
                description: document.data()['description'] as String,
                creationTime: DateTime.fromMillisecondsSinceEpoch(document.data()['timestamp'] as int),
                path: document.data()['path'] as String,
              ),
            );
          }
          notifyListeners();
        });
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        _productList = [];
        _productListSubscription?.cancel();
        signOut() ;
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
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

  Future<void> startGuestLoginFlow() async {
    _loginState = ApplicationLoginState.guestLogin;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      User? user = userCredential.user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      print('sign out complete');
      return await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('sign out failed');
      print(e.toString());
      return null;
    }
  }

  StreamSubscription<QuerySnapshot>? _productListSubscription;
  List<ProductElement> _productList = [];
  List<ProductElement> get productList => _productList;

  Future<DocumentReference> addProduct(String name, int price, String description, String path) {
    if (loginState == ApplicationLoginState.loggedOut) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('product')
        .add({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'likeNum': 0,
      'name': name,
      'price': price,
      'description': description,
      'path': path,
      'timestamp' : DateTime.now().millisecondsSinceEpoch,
    });
  }
}

