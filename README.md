# MyGoonga — Application Flutter

Client mobile de MyGoonga : vérification collaborative de médias et d'événements
locaux. Cette application consomme l'API FastAPI livrée séparément (dossier
`mygoonga-api`)

---

## 1. Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.22 ou plus récent
- Un projet Firebase (voir section 3) — requis même pour un premier essai, car
  l'authentification n'a pas d'équivalent "mode test" côté client (contrairement à
  l'API, qui peut tourner sans Firebase)
- L'API MyGoonga démarrée et accessible (locale ou déployée sur Render)
- Android Studio (pour Android) et/ou Xcode sur Mac (pour iOS)

Vérifiez votre installation :
```bash
flutter doctor
```

---

## 2. Installation des dépendances

```bash
cd mygoonga_app
flutter pub get
```

---

## 3. Configuration Firebase (obligatoire)

L'application utilise Firebase Auth (e-mail/mot de passe + Google Sign-In). Comme
l'API, elle doit être reliée à **un projet Firebase réel** — voir la section
correspondante du README de l'API pour la création du projet et l'activation des
méthodes de connexion.

### 3.1 Générer les fichiers de configuration automatiquement (recommandé)

```bash
dart pub global activate flutterfire_cli
firebase login          # nécessite le Firebase CLI (npm i -g firebase-tools)
flutterfire configure
```

Sélectionnez votre projet Firebase et les plateformes `android` (et `ios` sur Mac).
Cette commande :
- régénère `lib/firebase_options.dart` avec vos vraies valeurs (remplace le gabarit
  fourni, qui ne fonctionne pas tel quel),
- télécharge `android/app/google-services.json`,
- télécharge `ios/Runner/GoogleService-Info.plist` (si iOS sélectionné).

### 3.2 Alternative manuelle

Si vous préférez ne pas installer le Firebase CLI :
1. Dans la console Firebase → Paramètres du projet → Vos applications → ajoutez une
   application Android, `applicationId` = `com.mygoonga.app` (celui déclaré dans
   `android/app/build.gradle` — changez-le aussi côté Firebase si vous personnalisez
   cet identifiant).
2. Téléchargez le `google-services.json` fourni par Firebase, placez-le dans
   `android/app/` (remplace `google-services.json.example`).
3. Remplissez `lib/firebase_options.dart` à la main avec les valeurs affichées dans
   la console (apiKey, appId, messagingSenderId, projectId, storageBucket) — le
   fichier fourni indique clairement où les insérer.

### 3.3 Google Sign-In — SHA-1 (Android)

Google Sign-In sur Android exige que l'empreinte SHA-1 de votre clé de signature
soit enregistrée dans Firebase :

```bash
cd android
./gradlew signingReport
```
Copiez la valeur `SHA1` du variant `debug` (pour le développement), collez-la dans
**Firebase → Paramètres du projet → Vos applications → application Android →
Ajouter une empreinte**. Répétez l'opération avec la clé de release avant publication.

---

## 4. Lancer l'application

L'URL de l'API est injectée à la compilation (pas de fichier `.env` côté Flutter,
pour rester compatible avec toutes les plateformes) :

```bash
# Contre l'API lancée en local (émulateur Android — 10.0.2.2 = hôte local)
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000

# Contre l'API déployée sur Render
flutter run --dart-define=API_BASE_URL=https://votre-api.onrender.com
```

Sans `--dart-define`, l'application utilise par défaut `http://10.0.2.2:8000`
(pratique en développement avec un émulateur Android, mais ne fonctionnera pas sur
un appareil physique ni en production — pensez à toujours préciser l'URL réelle).

### Tester sans configurer Firebase (mode debug uniquement)

Si vous voulez avancer sur l'UI avant d'avoir fini la configuration Firebase, vous
pouvez appeler l'API en mode `X-Debug-Uid` (voir README de l'API) en compilant avec :

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000 --dart-define=DEBUG_AUTH_HEADERS=true
```

Puis, dans le code, définissez `ApiClient.instance.debugUid` avant le premier appel
(par exemple temporairement dans `main()`). **Ne compilez jamais une version de
production avec `DEBUG_AUTH_HEADERS=true`** : cela contournerait totalement
l'authentification Firebase.

---

## 5. Partage entrant depuis WhatsApp / la galerie ("Partager → MyGoonga")

Fonctionne directement sur Android, aucune étape supplémentaire : le manifeste
(`android/app/src/main/AndroidManifest.xml`) déclare déjà les intent-filters
nécessaires (`SEND` / `SEND_MULTIPLE` pour les images et vidéos).

Sur iOS, cela nécessite une Share Extension à créer une fois dans Xcode — voir
`ios/SETUP_IOS.md`, section 5.

---

## 6. Structure du projet

```
lib/
  main.dart                point d'entree, initialisation Firebase
  app.dart                  MaterialApp, theme, routage racine
  firebase_options.dart     genere par flutterfire configure
  theme/                    couleurs et theme clair/sombre (style Telegram/WhatsApp)
  core/
    app_config.dart          URL de l'API (via --dart-define)
    api_client.dart           client Dio + injection du token Firebase
  models/                    UserProfile, MediaAnalysis, EventDetail, etc.
  services/
    auth_service.dart          Firebase Auth (email + Google) + sync profil
    user_service.dart           GET/PATCH /users/me
    media_service.dart           POST /media/analyze + suivi du resultat
    event_service.dart            evenements locaux + flags
    verifier_service.dart          demande + moderation du statut verificateur
    admin_service.dart              gestion des roles, journal d'audit
    location_service.dart            geolocalisation
    share_intent_service.dart         reception du partage natif
  providers/
    auth_provider.dart          etat global d'authentification et de profil
  screens/
    splash/, auth/, home/, media/, events/, verifier/, profile/, moderation/, admin/
  widgets/                  composants reutilisables (badges de statut, etats vides...)
```

## 7. Rôles et écrans visibles

La barre de navigation et les actions du profil s'adaptent au rôle renvoyé par
l'API (`GET /users/me`) — le contrôle réel des droits reste bien sûr fait côté
serveur, l'UI ne fait que refléter ce que l'utilisateur peut faire :

| Rôle | Accès supplémentaires dans l'app |
|---|---|
| `standard` | Analyse de média, événements locaux, demande de statut vérificateur |
| `verifier` | + ses témoignages sur les événements comptent avec un poids plus fort |
| `moderator` | + File de modération des demandes vérificateur |
| `admin` | + Gestion des rôles utilisateurs, journal d'audit |

## 8. Préparer une version de production

- **Android** : générez votre propre clé de signature (`keytool -genkey ...`),
  référencez-la dans `android/app/build.gradle` (`signingConfigs.release`) à la
  place de `signingConfigs.debug` utilisé par défaut pour simplifier le premier
  lancement. Ajoutez son empreinte SHA-1/SHA-256 dans Firebase (section 3.3).
- **iOS** : suivez `ios/SETUP_IOS.md`, puis configurez la signature dans Xcode
  (compte développeur Apple requis pour publier sur l'App Store).
- Recompilez toujours avec `--dart-define=API_BASE_URL=<url de production>`.


