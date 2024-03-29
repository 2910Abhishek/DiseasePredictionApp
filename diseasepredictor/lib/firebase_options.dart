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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2iwWe_RXb3QAgVUDaXOVY9NmldQcmXh4',
    appId: '1:560600565133:android:84f2d7333835e01eea29c4',
    messagingSenderId: '560600565133',
    projectId: 'diseaseprediction-c1e90',
    databaseURL: 'https://diseaseprediction-c1e90-default-rtdb.firebaseio.com',
    storageBucket: 'diseaseprediction-c1e90.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBIUcctSo38MHLymDW1V8sdRONuvOCs3Po',
    appId: '1:560600565133:ios:9599b291710b59edea29c4',
    messagingSenderId: '560600565133',
    projectId: 'diseaseprediction-c1e90',
    databaseURL: 'https://diseaseprediction-c1e90-default-rtdb.firebaseio.com',
    storageBucket: 'diseaseprediction-c1e90.appspot.com',
    iosBundleId: 'com.example.diseasepredictor',
  );
}
