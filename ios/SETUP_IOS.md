# Configuration iOS

Ce zip cible en priorité Android (installation immédiate, sans Mac). Le projet Xcode
complet (`Runner.xcodeproj`) n'est **pas inclus** : il s'agit de fichiers binaires
générés par Flutter, qu'il n'est pas fiable de reconstituer à la main. Vous pouvez
l'ajouter en quelques minutes, si vous développez sur Mac :

## 1. Générer le projet Xcode

À la racine du projet (là où se trouve `pubspec.yaml`) :

```bash
flutter create --platforms=ios .
```

Cela crée un dossier `ios/` complet (Runner.xcodeproj, Podfile, AppDelegate, etc.)
sans toucher au code Dart déjà présent dans `lib/`.

## 2. Configurer Firebase pour iOS

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```
Sélectionnez votre projet Firebase, cochez `ios`. Cela régénère automatiquement
`lib/firebase_options.dart` (avec les vraies valeurs, à la place du gabarit fourni)
et place `GoogleService-Info.plist` dans `ios/Runner/`.

## 3. Google Sign-In (iOS)

1. Ouvrez `ios/Runner/GoogleService-Info.plist`, copiez la valeur de `REVERSED_CLIENT_ID`.
2. Dans Xcode : `Runner` → `Info` → `URL Types` → `+`, collez cette valeur dans
   `URL Schemes`.

## 4. Permissions (Info.plist)

Ajoutez ces clés dans `ios/Runner/Info.plist` (déjà fournies en modèle dans
`Info.plist.additions.xml` à côté de ce fichier — copiez-collez les balises
`<key>`/`<string>` correspondantes) :

- `NSCameraUsageDescription` — utilisée pour prendre une photo à analyser ou pour
  la demande de statut vérificateur.
- `NSPhotoLibraryUsageDescription` — utilisée pour choisir un média depuis la galerie.
- `NSLocationWhenInUseUsageDescription` — utilisée pour situer les événements locaux
  signalés à proximité.

## 5. Partage entrant depuis d'autres apps (Share Extension)

Le partage natif "Partager → MyGoonga" sur iOS nécessite une **Share Extension**,
une cible Xcode distincte qui ne peut être créée que depuis l'interface Xcode
(`File → New → Target → Share Extension`). Étapes résumées :

1. `File → New → Target → Share Extension`, nommez-la `ShareExtension`.
2. Activez `App Groups` sur les deux cibles (`Runner` et `ShareExtension`), avec le
   même identifiant (ex: `group.com.mygoonga.app`).
3. Suivez la documentation du package `receive_sharing_intent` (déjà dans
   `pubspec.yaml`) pour le code Swift de la Share Extension :
   https://pub.dev/packages/receive_sharing_intent — section "iOS setup".

Sur Android, ce même flux de partage fonctionne directement (voir le manifeste déjà
fourni dans `android/app/src/main/AndroidManifest.xml`) : aucune étape manuelle requise.

## 6. Lancer l'application

```bash
cd ios && pod install && cd ..
flutter run --dart-define=API_BASE_URL=https://votre-api.onrender.com
```
