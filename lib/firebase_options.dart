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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgh9ys12UucB5g2by5bMQJnQJMmRx44sM',
    appId: '1:228402230352:android:36306c9dd27b133646cd55',
    messagingSenderId: '228402230352',
    projectId: 'danbeauty-937c5',
    databaseURL: 'https://danbeauty-937c5-default-rtdb.firebaseio.com',
    storageBucket: 'danbeauty-937c5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAo_awcBKxIFn0nUxl-G0lk8eDL9-OWxYI',
    appId: '1:228402230352:ios:34a242a287abc4be46cd55',
    messagingSenderId: '228402230352',
    projectId: 'danbeauty-937c5',
    databaseURL: 'https://danbeauty-937c5-default-rtdb.firebaseio.com',
    storageBucket: 'danbeauty-937c5.appspot.com',
    androidClientId: '228402230352-1tn0co2ikil8ldbua6mqoedbqehtesfq.apps.googleusercontent.com',
    iosClientId: '228402230352-gjtr1jb4apg8po6plu2iismm2sfgh41q.apps.googleusercontent.com',
    iosBundleId: 'com.mighty.taxirider2',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBnkOoWUA2HOS-pWn4xyT_Bmkle8vyvGYs',
    appId: '1:228402230352:web:09f88938882a5e0046cd55',
    messagingSenderId: '228402230352',
    projectId: 'danbeauty-937c5',
    authDomain: 'danbeauty-937c5.firebaseapp.com',
    databaseURL: 'https://danbeauty-937c5-default-rtdb.firebaseio.com',
    storageBucket: 'danbeauty-937c5.appspot.com',
    measurementId: 'G-W037QTN3JD',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCXyS_KkRhc39xp0mveB_V53kLUwyKbAtk',
    appId: '1:228402230352:web:5367a404c3fc2c7546cd55',
    messagingSenderId: '228402230352',
    projectId: 'danbeauty-937c5',
    authDomain: 'danbeauty-937c5.firebaseapp.com',
    databaseURL: 'https://danbeauty-937c5-default-rtdb.firebaseio.com',
    storageBucket: 'danbeauty-937c5.appspot.com',
    measurementId: 'G-Y9JHBBHBDC',
  );

}