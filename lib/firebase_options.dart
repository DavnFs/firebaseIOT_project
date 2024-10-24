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
    apiKey: 'AIzaSyB1T1R9zzlYFPwdLDp1f1Vmhlz-5DlVjrs',
    appId: '1:866107197917:web:a05ec8447d07df81d08e34',
    messagingSenderId: '866107197917',
    projectId: 'esiot2024-23ad0',
    authDomain: 'esiot2024-23ad0.firebaseapp.com',
    databaseURL: 'https://esiot2024-23ad0-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'esiot2024-23ad0.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwvFf9214Q6LwafXX1rIOovQ7dkLgpzwA',
    appId: '1:866107197917:android:59f4fadb0d6c4cc7d08e34',
    messagingSenderId: '866107197917',
    projectId: 'esiot2024-23ad0',
    databaseURL: 'https://esiot2024-23ad0-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'esiot2024-23ad0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDUKz9tCuB0Gry8mlcuXXNEHMevZkw4wb0',
    appId: '1:866107197917:ios:e24ba51f5282fd69d08e34',
    messagingSenderId: '866107197917',
    projectId: 'esiot2024-23ad0',
    databaseURL: 'https://esiot2024-23ad0-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'esiot2024-23ad0.appspot.com',
    iosBundleId: 'com.example.firebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDUKz9tCuB0Gry8mlcuXXNEHMevZkw4wb0',
    appId: '1:866107197917:ios:e24ba51f5282fd69d08e34',
    messagingSenderId: '866107197917',
    projectId: 'esiot2024-23ad0',
    databaseURL: 'https://esiot2024-23ad0-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'esiot2024-23ad0.appspot.com',
    iosBundleId: 'com.example.firebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB1T1R9zzlYFPwdLDp1f1Vmhlz-5DlVjrs',
    appId: '1:866107197917:web:4d56571745f1b853d08e34',
    messagingSenderId: '866107197917',
    projectId: 'esiot2024-23ad0',
    authDomain: 'esiot2024-23ad0.firebaseapp.com',
    databaseURL: 'https://esiot2024-23ad0-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'esiot2024-23ad0.appspot.com',
  );

}