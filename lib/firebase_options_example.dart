// ATTENTION: Ceci est un fichier EXEMPLE
// Le vrai fichier firebase_options.dart sera généré par la commande :
// flutterfire configure
//
// OU vous pouvez renommer ce fichier en firebase_options.dart et
// remplacer les valeurs par celles de votre projet Firebase

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example for Android:
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
    apiKey: 'AIzaSyDR4ecCEyKhCZ9fquNrljkTn84MgRbqJzM',
    appId: 'applicatho',
    messagingSenderId: 'VOTRE_MESSAGING_SENDER_ID',
    projectId: 'VOTRE_PROJECT_ID',
    authDomain: 'VOTRE_PROJECT_ID.firebaseapp.com',
    storageBucket: 'VOTRE_PROJECT_ID.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'VOTRE_ANDROID_API_KEY',
    appId: 'VOTRE_ANDROID_APP_ID',
    messagingSenderId: 'VOTRE_MESSAGING_SENDER_ID',
    projectId: 'VOTRE_PROJECT_ID',
    storageBucket: 'VOTRE_PROJECT_ID.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'VOTRE_IOS_API_KEY',
    appId: 'VOTRE_IOS_APP_ID',
    messagingSenderId: 'VOTRE_MESSAGING_SENDER_ID',
    projectId: 'VOTRE_PROJECT_ID',
    storageBucket: 'VOTRE_PROJECT_ID.appspot.com',
    iosBundleId: 'com.example.applicatho',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'VOTRE_MACOS_API_KEY',
    appId: 'VOTRE_MACOS_APP_ID',
    messagingSenderId: 'VOTRE_MESSAGING_SENDER_ID',
    projectId: 'VOTRE_PROJECT_ID',
    storageBucket: 'VOTRE_PROJECT_ID.appspot.com',
    iosBundleId: 'com.example.applicatho',
  );
}

// Pour trouver vos valeurs :
// 1. Allez sur Firebase Console
// 2. Sélectionnez votre projet
// 3. Paramètres du projet > Général
// 4. Faites défiler vers le bas pour voir vos applications
// 5. Copiez les valeurs de configuration
