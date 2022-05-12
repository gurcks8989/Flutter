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
import 'package:shrine/profile.dart';

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
                docId: document.id,
                userId: document.data()['userId'] as String,
                likeNum: document.data()['likeNum'] as int,
                name: document.data()['name'] as String,
                price: document.data()['price'] as int,
                description: document.data()['description'] as String,
                creationTime: document.data()['creationTimestamp'] as Timestamp,
                updateTime: document.data()['updateTimestamp'] as Timestamp,
                path: document.data()['path'] as String,
              ),
            );
          }
          notifyListeners();
        });
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        _user = UserElement() ;
        _productList = [];
        _productListSubscription?.cancel();
        signOut();
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;
  UserElement _user = UserElement();
  UserElement get user => _user;

  Future<UserCredential> signInWithGoogle() async {
    _loginState = ApplicationLoginState.googleLogin;
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

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
    UserCredential userCredential = await signInWithGoogle();
    final user = userCredential.user;
    if (user != null) {
      _user.userId = user.providerData[0].uid!;
      _user.email = user.providerData[0].email!;
      _user.path = user.providerData[0].photoURL!;
    }
  }

  Future<void> startGuestLoginFlow() async {
    _loginState = ApplicationLoginState.guestLogin;
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    final user = userCredential.user;
    if (user != null) {
        _user.userId = user.uid!;
        _user.email = 'Anonymous' ;
        getDefaultImage()
            .then((value) => _user.path = value) ;
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

  Future<DocumentReference> addProduct(String name, int price,
      String description, String path) {
    if (loginState == ApplicationLoginState.loggedOut) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('product')
        .add({
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'likeNum': 0,
      'name': name,
      'price': price,
      'description': description,
      'path': path,
      'creationTimestamp': FieldValue.serverTimestamp(),
      'updateTimestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> editProduct(String docId, String name, int price,
      String description, String path) {
    if (loginState == ApplicationLoginState.loggedOut) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('product')
        .doc(docId)
        .update({
      'name': name,
      'price': price,
      'description': description,
      'path': path,
      'updateTimestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteProductInServer(String docId) async {
    FirebaseFirestore.instance.collection('product').doc(docId).delete();

    FirebaseFirestore.instance
        .collection('likeProduct')
        .where('productId', isEqualTo: docId)
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) => {
      for (final document in snapshot.docs){
        FirebaseFirestore.instance.collection('likeProduct')
            .doc(document.id).delete()
      }}) ;
    notifyListeners();
  }

  Future<int> alreadyLikeCheck(String docId) {
    if (loginState == ApplicationLoginState.loggedOut) {
      throw Exception('Must be logged in');
    }
    bool _isExist;
    return FirebaseFirestore.instance
        .collection('likeProduct')
        .where('productId', isEqualTo: docId)
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.size);
  }

  Future<void> increaseLike(String docId) async {
    if (loginState == ApplicationLoginState.loggedOut) {
      throw Exception('Must be logged in');
    }
    FirebaseFirestore.instance
        .collection('product')
        .doc(docId)
        .update({'likeNum': FieldValue.increment(1)});

    FirebaseFirestore.instance
        .collection('likeProduct')
        .add({
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'productId': docId,
      'timestamp' : FieldValue.serverTimestamp(),
    });
  }

  String getCurrentUserId() {
    if (loginState == ApplicationLoginState.loggedOut) {
      throw Exception('Must be logged in');
    }
    return FirebaseAuth.instance.currentUser!.uid ;
  }

  Future<String> getDefaultImage() {
    return FirebaseFirestore.instance
        .collection('initialize')
        .doc('productDefaultImage')
        .get().then(
          (doc) => doc['logo'] as String,
      onError: (e) => print("Error completing: $e"),
    );
  }
}
