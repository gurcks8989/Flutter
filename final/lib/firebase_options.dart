// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdmNDdiiSX-pmO1bELOPnWh-BfpK37Opo',
    appId: '1:265981542825:android:d0f09f8c8dc950138f84b8',
    messagingSenderId: '265981542825',
    projectId: 'mad-final-a7696',
    storageBucket: 'mad-final-a7696.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvAfx4ur9fgvriaaZ6Vb7WvccgskvrKbU',
    appId: '1:265981542825:ios:182901d3a1d5e72d8f84b8',
    messagingSenderId: '265981542825',
    projectId: 'mad-final-a7696',
    storageBucket: 'mad-final-a7696.appspot.com',
    iosClientId: '265981542825-lhnaidqkp41tb6n6gmv9tgagg8kgbr86.apps.googleusercontent.com',
    iosBundleId: 'com.example.mdc100Series',
  );
}