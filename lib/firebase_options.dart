// GENERE NORMALEMENT PAR LA COMMANDE `flutterfire configure`.
//
// Ce fichier est un MODELE fourni pour que le projet compile une fois vos
// propres identifiants Firebase renseignes. Ne l'utilisez pas tel quel :
// suivez la section "Configuration Firebase" du README, qui regenere
// automatiquement ce fichier avec les bonnes valeurs pour votre projet.
//
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'MyGoonga ne cible pas le Web dans ce MVP. Régénérez firebase_options.dart '
        'avec `flutterfire configure` si vous souhaitez ajouter cette plateforme.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions ne prend pas en charge cette plateforme.',
        );
    }
  }

  // Valeurs d'exemple — remplacez-les en exécutant `flutterfire configure`
  // à la racine du projet (voir README, section Firebase).
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKe3bb9ca9_fczXZYFiFCrT7rUzTx-K1Q',
    appId: '1:34305769700:android:d5401ba7078e74b94dacf1',
    messagingSenderId: '34305769700',
    projectId: 'my-goonga',
    storageBucket: 'my-goonga.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKe3bb9ca9_fczXZYFiFCrT7rUzTx-K1Q',
    appId: '1:34305769700:ios:1234567890abcdef1234567890abcdef',
    messagingSenderId: '34305769700',
    projectId: 'my-goonga',
    storageBucket: 'my-goonga.firebasestorage.app',
    iosBundleId: 'com.mygoonga.app',
  );
}
