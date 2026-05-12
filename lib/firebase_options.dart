import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions wurden nicht für Web konfiguriert. '
        'Führe "flutterfire configure" aus.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions für ${defaultTargetPlatform.name} nicht konfiguriert. '
          'Führe "flutterfire configure" aus.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvMtBgUx02TfcEC9C93SpKcSwONwLWJas',
    appId: '1:627946070040:android:98f577240736a343c3e36d',
    messagingSenderId: '627946070040',
    projectId: 'mobile-applications-ss26',
    storageBucket: 'mobile-applications-ss26.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBKo0Zezs1sKWJFhh1LwsXb2Pb7e78Ot2s',
    appId: '1:627946070040:ios:ccc0758511cd7a48c3e36d',
    messagingSenderId: '627946070040',
    projectId: 'mobile-applications-ss26',
    storageBucket: 'mobile-applications-ss26.firebasestorage.app',
    iosBundleId: 'com.example.mobileApplicationsProjectSs26',
  );
}
