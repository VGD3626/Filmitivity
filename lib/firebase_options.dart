// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAXn8Q1JUa0ZBVdYLW0Y5P8kUrCUkxWTdc',
    appId: '1:1082976378693:web:6d10235b190b85f93ca82c',
    messagingSenderId: '1082976378693',
    projectId: 'android01-cd233',
    authDomain: 'android01-cd233.firebaseapp.com',
    storageBucket: 'android01-cd233.appspot.com',
    measurementId: 'G-DHTVCXWLY2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBYUBW4n6eBDmN9T4RY3QHx_H5ye9ZMBW0',
    appId: '1:1082976378693:android:02e8907d4e7a665c3ca82c',
    messagingSenderId: '1082976378693',
    projectId: 'android01-cd233',
    storageBucket: 'android01-cd233.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9MZSwsmljZxbfUFhXxwSF5kw_87jvnls',
    appId: '1:1082976378693:ios:fa7ee7ec3c22d2fc3ca82c',
    messagingSenderId: '1082976378693',
    projectId: 'android01-cd233',
    storageBucket: 'android01-cd233.appspot.com',
    iosBundleId: 'com.example.android01',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD9MZSwsmljZxbfUFhXxwSF5kw_87jvnls',
    appId: '1:1082976378693:ios:fa7ee7ec3c22d2fc3ca82c',
    messagingSenderId: '1082976378693',
    projectId: 'android01-cd233',
    storageBucket: 'android01-cd233.appspot.com',
    iosBundleId: 'com.example.android01',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAXn8Q1JUa0ZBVdYLW0Y5P8kUrCUkxWTdc',
    appId: '1:1082976378693:web:bef210acfcb4f77d3ca82c',
    messagingSenderId: '1082976378693',
    projectId: 'android01-cd233',
    authDomain: 'android01-cd233.firebaseapp.com',
    storageBucket: 'android01-cd233.appspot.com',
    measurementId: 'G-SKB9REMVLC',
  );
}