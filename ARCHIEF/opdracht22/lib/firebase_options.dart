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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCQlzuyyvdCdpUVtTpXPFTDxQMPHbdbABI',
    appId: '1:792678563618:web:29d33fb6dd1866e20b6f7b',
    messagingSenderId: '792678563618',
    projectId: 'fir-workshop-project-3ba64',
    authDomain: 'fir-workshop-project-3ba64.firebaseapp.com',
    databaseURL: 'https://fir-workshop-project-3ba64-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fir-workshop-project-3ba64.appspot.com',
    measurementId: 'G-852ZWB871T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCLkFmaTNTKyvpVscVeIUrTHjahehFcDBI',
    appId: '1:792678563618:android:28832904fa223f820b6f7b',
    messagingSenderId: '792678563618',
    projectId: 'fir-workshop-project-3ba64',
    databaseURL: 'https://fir-workshop-project-3ba64-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fir-workshop-project-3ba64.appspot.com',
  );
}
