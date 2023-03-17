// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
//import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:firebase_core/firebase_core.dart';
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
  static Future<FirebaseOptions> get currentPlatform async {
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
    apiKey: 'AIzaSyAi3e1e-uAIL5Ig4iCFPum9FH2Tn5wWhxg',
    appId: '1:276710694419:android:e0ab87de536bea98a2e9e6',
    messagingSenderId: '276710694419',
    projectId: 'vitium-74f9c',
    databaseURL: 'https://vitium-74f9c-default-rtdb.firebaseio.com',
    storageBucket: 'vitium-74f9c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXrx7DmFh0DRKUhgDhOMia06oicc8yYqg',
    appId: '1:276710694419:ios:fc58aa1632ff7cdea2e9e6',
    messagingSenderId: '276710694419',
    projectId: 'vitium-74f9c',
    databaseURL: 'https://vitium-74f9c-default-rtdb.firebaseio.com',
    storageBucket: 'vitium-74f9c.appspot.com',
    iosClientId:
        '276710694419-vdr8tnir78f1hfvtv79qkro49u39e61n.apps.googleusercontent.com',
    iosBundleId: 'com.example.vitiumApp',
  );
}
