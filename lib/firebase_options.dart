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
    apiKey: 'AIzaSyBtOFaFkxZIbE2miKGu2q6IaGBfakAr8zA',
    appId: '1:288526136103:web:f26ff869740da3c236ef02',
    messagingSenderId: '288526136103',
    projectId: 'filmood-f2aae',
    authDomain: 'filmood-f2aae.firebaseapp.com',
    storageBucket: 'filmood-f2aae.firebasestorage.app',
    measurementId: 'G-TBWMDJQKQE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2m_EZJPhSnYELLPV4Ase0jGTKjXbYGkY',
    appId: '1:288526136103:android:94b2fcdaf738243536ef02',
    messagingSenderId: '288526136103',
    projectId: 'filmood-f2aae',
    storageBucket: 'filmood-f2aae.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIn-k2JRxOXLhhIzHV8D4QppspI_uDLF4',
    appId: '1:288526136103:ios:5047a99c09e02ff736ef02',
    messagingSenderId: '288526136103',
    projectId: 'filmood-f2aae',
    storageBucket: 'filmood-f2aae.firebasestorage.app',
    iosBundleId: 'com.example.filmood',
  );
}
