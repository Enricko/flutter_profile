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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyDbtH4paRB1qCN0R_ziMs7wi7grd2OwntA',
    appId: '1:953433661723:web:9fc4a4ac1a2fac7bf473be',
    messagingSenderId: '953433661723',
    projectId: 'personal-profile-34a44',
    authDomain: 'personal-profile-34a44.firebaseapp.com',
    databaseURL: 'https://personal-profile-34a44-default-rtdb.firebaseio.com',
    storageBucket: 'personal-profile-34a44.appspot.com',
    measurementId: 'G-0LQS0L55RB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADlw_PBxZLeX1n6DWMRdfTZSxs11zOFXg',
    appId: '1:953433661723:android:72b26df85a27dccef473be',
    messagingSenderId: '953433661723',
    projectId: 'personal-profile-34a44',
    databaseURL: 'https://personal-profile-34a44-default-rtdb.firebaseio.com',
    storageBucket: 'personal-profile-34a44.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDe4hRE0S2I4n0X3QOP6g6GfMzDrailBXU',
    appId: '1:953433661723:ios:447999276b2c8704f473be',
    messagingSenderId: '953433661723',
    projectId: 'personal-profile-34a44',
    databaseURL: 'https://personal-profile-34a44-default-rtdb.firebaseio.com',
    storageBucket: 'personal-profile-34a44.appspot.com',
    iosClientId: '953433661723-14brh0g1vmc77tf31am5phd42dkgi6h1.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterProfile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDe4hRE0S2I4n0X3QOP6g6GfMzDrailBXU',
    appId: '1:953433661723:ios:447999276b2c8704f473be',
    messagingSenderId: '953433661723',
    projectId: 'personal-profile-34a44',
    databaseURL: 'https://personal-profile-34a44-default-rtdb.firebaseio.com',
    storageBucket: 'personal-profile-34a44.appspot.com',
    iosClientId: '953433661723-14brh0g1vmc77tf31am5phd42dkgi6h1.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterProfile',
  );
}
