# Guide de Configuration Firebase pour Applicatho

## Étape 1 : Créer un projet Firebase

1. Allez sur [Firebase Console](https://console.firebase.google.com)
2. Cliquez sur "Ajouter un projet"
3. Nom du projet : **applicatho** (ou votre choix)
4. Suivez les étapes de création

## Étape 2 : Activer Firestore Database

1. Dans votre projet Firebase, allez dans **Build** > **Firestore Database**
2. Cliquez sur **Créer une base de données**
3. Choisissez le mode **Production** (vous pouvez modifier les règles après)
4. Choisissez la région (ex: **europe-west1** pour l'Europe)

### Règles Firestore (à configurer)

Allez dans l'onglet **Règles** et copiez ceci :

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Lecture publique, écriture admin uniquement
    match /{document=**} {
      allow read: if true;
      allow write: if false; // À modifier si vous voulez permettre l'écriture depuis l'app
    }
  }
}
```

## Étape 3 : Activer Storage (optionnel, pour les images)

1. Allez dans **Build** > **Storage**
2. Cliquez sur **Commencer**
3. Acceptez les règles par défaut

### Règles Storage

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read: if true;
      allow write: if false; // À modifier selon vos besoins
    }
  }
}
```

## Étape 4 : Configurer l'application Android

1. Dans Firebase Console, cliquez sur l'icône **Android** pour ajouter une app
2. **Package Android** : Trouvez-le dans `android/app/build.gradle` (ligne `applicationId`)
   - Par défaut devrait être : `com.example.applicatho`
3. **Pseudo de l'app** : Applicatho
4. Téléchargez le fichier **google-services.json**
5. Copiez-le dans : `android/app/google-services.json`

### Modifier android/app/build.gradle

Ajoutez dans `android/app/build.gradle` :

```gradle
// En haut du fichier, après les autres plugins
plugins {
    id "com.android.application"
    id "kotlin-android"
    // AJOUTEZ CETTE LIGNE:
    id "com.google.gms.google-services"
}
```

### Modifier android/build.gradle

Ajoutez dans `android/build.gradle` dans la section dependencies de buildscript :

```gradle
buildscript {
    dependencies {
        // ... autres dépendances
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

## Étape 5 : Configurer l'application iOS (optionnel)

1. Dans Firebase Console, cliquez sur l'icône **iOS** pour ajouter une app
2. **Bundle ID iOS** : Trouvez-le dans `ios/Runner.xcodeproj/project.pbxproj`
   - Recherchez `PRODUCT_BUNDLE_IDENTIFIER`
   - Par défaut : `com.example.applicatho`
3. Téléchargez le fichier **GoogleService-Info.plist**
4. Copiez-le dans : `ios/Runner/GoogleService-Info.plist`

## Étape 6 : Créer les collections Firestore

Dans Firebase Console > Firestore Database, créez ces collections :

### Collection `saints`
Cliquez sur "Démarrer une collection" > Nom : `saints`

Document exemple :
```
ID: auto
Champs:
- name (string): "Saint François d'Assise"
- imageUrl (string): "https://example.com/saint.jpg"
- description (string): "Fondateur de l'ordre franciscain..."
```

**NOTE** : L'application choisit un saint **aléatoirement** à chaque lancement. Vous pouvez ajouter autant de saints que vous voulez !

### Collection `verses`
```
ID: auto
Champs:
- text (string): "Car Dieu a tant aimé le monde..."
- reference (string): "Jean 3:16"
```

**NOTE** : L'application choisit un verset **aléatoirement** à chaque lancement. Ajoutez plusieurs versets pour plus de variété !

### Collection `events`
```
ID: auto
Champs:
- title (string): "Messe de Noël"
- description (string): "Célébration de la naissance du Christ"
- date (timestamp): 25 décembre 2024 19:00
- location (string): "Cathédrale Notre-Dame"
- imageUrl (string): "" (optionnel)
```

### Collection `prayers`
```
ID: auto
Champs:
- title (string): "Notre Père"
- text (string): "Notre Père qui es aux cieux..."
- category (string): "Prières essentielles"
```

### Collection `churches`
```
ID: auto
Champs:
- name (string): "Cathédrale Notre-Dame"
- address (string): "6 Parvis Notre-Dame, Paris"
- latitude (number): 48.853
- longitude (number): 2.3499
- phone (string): "+33 1 42 34 56 10"
- description (string): "Cathédrale historique..."
```

### Collection `members`
```
ID: auto
Champs:
- name (string): "LESCURE Maël"
- role (string): "Président de l'association"
- photoUrl (string): "https://..." (URL de la photo)
- order (number): 1
```

Document 2:
```
- name (string): "KLEIN Thomas"
- role (string): "Vice Président"
- photoUrl (string): "https://..."
- order (number): 2
```

Document 3:
```
- name (string): "Père Jean-Yves"
- role (string): "Aumonier de l'ICAM"
- photoUrl (string): "https://..."
- order (number): 3
```

### Collection `faqs`
```
ID: auto
Champs:
- question (string): "Quels sont les horaires des messes ?"
- answer (string): "Les messes ont lieu tous les dimanches à 10h30..."
- order (number): 1
```

## Étape 7 : Configuration alternative avec FlutterFire CLI

Si vous voulez utiliser FlutterFire CLI (nécessite d'être connecté à Firebase) :

```bash
# Se connecter à Firebase (ouvre un navigateur)
firebase login

# Configurer le projet Flutter avec Firebase
flutterfire configure
```

Cela créera automatiquement le fichier `lib/firebase_options.dart` avec vos configurations.

## Étape 8 : Tester l'application

```bash
flutter clean
flutter pub get
flutter run
```

## Problèmes courants

### Erreur "No Firebase App"
- Vérifiez que `google-services.json` est bien dans `android/app/`
- Vérifiez que vous avez ajouté le plugin dans `build.gradle`

### Erreur de permissions de localisation
- Vérifiez que les permissions sont bien dans `AndroidManifest.xml`
- Sur Android, acceptez les permissions quand demandé

### Pas de données affichées
- Vérifiez que vos collections Firestore sont bien créées
- Vérifiez les règles Firestore (allow read: if true)
- Regardez les logs : `flutter run -v`

## Données de test

Pour faciliter les tests, vous pouvez importer ce JSON dans Firestore.

### Exemple de saint
```json
{
  "name": "Saint Joseph",
  "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Guido_Reni_-_St_Joseph_with_the_Infant_Jesus_-_WGA19304.jpg/400px-Guido_Reni_-_St_Joseph_with_the_Infant_Jesus_-_WGA19304.jpg",
  "description": "Époux de la Vierge Marie et père nourricier de Jésus"
}
```

**NOTE** : Pas besoin de date ! L'application choisit aléatoirement.

### Exemple de verset
```json
{
  "text": "Je suis le chemin, la vérité et la vie. Nul ne vient au Père que par moi.",
  "reference": "Jean 14:6"
}
```

**NOTE** : Pas besoin de date ! L'application choisit aléatoirement.

## Ressources utiles

- [Documentation Firebase](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev)
- [Firestore Data Model](https://firebase.google.com/docs/firestore/data-model)
- [Images de saints gratuites](https://commons.wikimedia.org)

## Support

Pour toute question sur la configuration Firebase :
- Documentation officielle : https://firebase.google.com/docs
- FlutterFire : https://firebase.flutter.dev

Bon courage ! 🙏
