# Configuration Firebase pour le Web

## Étape 1 : Ajouter une application Web dans Firebase

1. Va sur [Firebase Console](https://console.firebase.google.com)
2. Sélectionne ton projet **applicatho**
3. Clique sur l'icône **Paramètres** (roue dentée) > **Paramètres du projet**
4. Descends jusqu'à la section **"Vos applications"**
5. Clique sur l'icône **Web** (`</>`)

## Étape 2 : Enregistrer l'application Web

1. **Pseudo de l'app** : `Applicatho Web`
2. **NE COCHE PAS** "Configurer également Firebase Hosting" (pas nécessaire)
3. Clique sur **Enregistrer l'app**

## Étape 3 : Copier la configuration

Tu verras un bloc de code JavaScript qui ressemble à ça :

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyA...",
  authDomain: "applicatho-xxxxx.firebaseapp.com",
  projectId: "applicatho-xxxxx",
  storageBucket: "applicatho-xxxxx.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abcdef123456"
};
```

## Étape 4 : Modifier le fichier firebase_options.dart

Ouvre le fichier `lib/firebase_options.dart` et remplace les valeurs dans la section `web` :

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'AIzaSyA...',  // Copie ta valeur ici
  appId: '1:123456789:web:abcdef123456',  // Copie ta valeur ici
  messagingSenderId: '123456789',  // Copie ta valeur ici
  projectId: 'applicatho-xxxxx',  // Copie ta valeur ici
  authDomain: 'applicatho-xxxxx.firebaseapp.com',  // Copie ta valeur ici
  storageBucket: 'applicatho-xxxxx.appspot.com',  // Copie ta valeur ici
);
```

## Étape 5 : Correspondance des valeurs

| Firebase Console | firebase_options.dart |
|------------------|----------------------|
| apiKey | apiKey |
| authDomain | authDomain |
| projectId | projectId |
| storageBucket | storageBucket |
| messagingSenderId | messagingSenderId |
| appId | appId |

## Étape 6 : Tester

Une fois que tu as modifié `lib/firebase_options.dart` avec tes vraies valeurs :

```bash
flutter run -d chrome
```

L'application devrait maintenant se connecter à Firebase et afficher :
- ✅ Un saint aléatoire
- ✅ Un verset aléatoire
- ✅ Les membres du BDSPIE

## Exemple complet

Voici à quoi devrait ressembler ton fichier `firebase_options.dart` une fois configuré :

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'AIzaSyABCDEF1234567890abcdefghijklmnopq',
  appId: '1:123456789012:web:abc123def456ghi789',
  messagingSenderId: '123456789012',
  projectId: 'applicatho-a1b2c',
  authDomain: 'applicatho-a1b2c.firebaseapp.com',
  storageBucket: 'applicatho-a1b2c.appspot.com',
);
```

## Problèmes courants

### "No Firebase App '[DEFAULT]' has been created"
➡️ Vérifie que tu as bien remplacé TOUTES les valeurs dans `firebase_options.dart`
➡️ Redémarre l'application : `flutter run -d chrome`

### "API key not valid"
➡️ Vérifie que tu as bien copié l'`apiKey` complet depuis Firebase Console
➡️ Assure-toi qu'il n'y a pas d'espace au début ou à la fin

### L'app ne charge rien
➡️ Vérifie que tes collections Firestore sont bien créées (saints, verses, members)
➡️ Regarde les logs dans la console du navigateur (F12)

## Pour Android (plus tard)

Pour tester sur Android, tu auras besoin de :
1. Placer `google-services.json` dans `android/app/`
2. Configurer les valeurs Android dans `firebase_options.dart`

Mais pour l'instant, concentre-toi sur le **Web** !

---

**Tu es presque là !** Une fois les valeurs configurées, l'app fonctionnera ! 🚀
