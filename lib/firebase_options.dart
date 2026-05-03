// File generated based on google-services.json for jyotish-guru-1710
// Expert App: com.example.palmistry_palmist

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDcloShmTNbNAzlxXE7EgdjAwQYGR-ZkcE',
    appId: '1:330132786283:android:308590a2bc96ae67c5f52e',
    messagingSenderId: '330132786283',
    projectId: 'jyotish-guru-1710',
    storageBucket: 'jyotish-guru-1710.firebasestorage.app',
  );
}
