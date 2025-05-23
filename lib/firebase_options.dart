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
    apiKey: 'AIzaSyDOjMrlq945fQyYk9UHbfIP4NRnCfVG2To',
    appId: '1:276930606271:web:3b32873b65acdd4ba6020a',
    messagingSenderId: '276930606271',
    projectId: 'albaraa-6ea10',
    authDomain: 'albaraa-6ea10.firebaseapp.com',
    storageBucket: 'albaraa-6ea10.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzl0ibe6V-t21jovERGuiVoQ4XFbkYVfQ',
    appId: '1:276930606271:android:885f89b48cda9638a6020a',
    messagingSenderId: '276930606271',
    projectId: 'albaraa-6ea10',
    storageBucket: 'albaraa-6ea10.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQWW-ntFLaKStFyHHH_cFn9PfWcbs0-IY',
    appId: '1:276930606271:ios:a296ea9d930347a7a6020a',
    messagingSenderId: '276930606271',
    projectId: 'albaraa-6ea10',
    storageBucket: 'albaraa-6ea10.appspot.com',
    iosBundleId: 'com.example.flutterApplication2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCQWW-ntFLaKStFyHHH_cFn9PfWcbs0-IY',
    appId: '1:276930606271:ios:a296ea9d930347a7a6020a',
    messagingSenderId: '276930606271',
    projectId: 'albaraa-6ea10',
    storageBucket: 'albaraa-6ea10.appspot.com',
    iosBundleId: 'com.example.flutterApplication2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDOjMrlq945fQyYk9UHbfIP4NRnCfVG2To',
    appId: '1:276930606271:web:323fa06cae92c8e5a6020a',
    messagingSenderId: '276930606271',
    projectId: 'albaraa-6ea10',
    authDomain: 'albaraa-6ea10.firebaseapp.com',
    storageBucket: 'albaraa-6ea10.appspot.com',
  );
}
