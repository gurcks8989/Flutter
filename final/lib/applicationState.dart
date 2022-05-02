

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication.dart';
import 'firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // FirebaseFirestore.instance
    //     .collection('attendees')
    //     .where('attending', isEqualTo: true)
    //     .snapshots()
    //     .listen((snapshot) {
    //   _attendees = snapshot.docs.length;
    //   notifyListeners();
    // });

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        // _guestBookSubscription = FirebaseFirestore.instance
        //     .collection('guestbook')
        //     .orderBy('timestamp', descending: true)
        //     .snapshots()
        //     .listen((snapshot) {
        // _guestBookMessages = [];
        // for (final document in snapshot.docs) {
        //   _guestBookMessages.add(
        //     GuestBookMessage(
        //       docId: document.id,
        //       userId: document.data()['userId'] as String,
        //       name: document.data()['name'] as String,
        //       message: document.data()['text'] as String,
        //       dateTime: DateTime.fromMillisecondsSinceEpoch(
        //           document.data()['timestamp'] as int),
        //     ),
        //   );
        // }
        notifyListeners();
      // });
      //   _attendingSubscription = FirebaseFirestore.instance
      //       .collection('attendees')
      //       .doc(user.uid)
      //       .snapshots()
      //       .listen((snapshot) {
      //     if (snapshot.data() != null) {
      //       if (snapshot.data()!['attending'] as bool) {
      //         _attending = Attending.yes;
      //       } else {
      //         _attending = Attending.no;
      //       }
      //     } else {
      //       _attending = Attending.unknown;
      //     }
      //     notifyListeners();
      //   });
      } else {
        _loginState = ApplicationLoginState.loggedOut;
      //   _guestBookMessages = [];
      //   _guestBookSubscription?.cancel();
      //   _attendingSubscription?.cancel();
      }
      notifyListeners();
    });
  }

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

  Future<void> registerAccount(
      String email,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('guestbook')
        .add(<String, dynamic>{
      'text': message,
      'timestamp': DateTime
          .now()
          .millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }
}