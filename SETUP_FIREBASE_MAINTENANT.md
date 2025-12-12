# 🚀 Configuration Firebase - À FAIRE MAINTENANT

## Étape 1 : Va sur Firebase Console

Ouvre cette URL dans ton navigateur :
👉 https://console.firebase.google.com/project/[TON_PROJECT_ID]/settings/general/

Remplace `[TON_PROJECT_ID]` par le nom de ton projet.

Ou simplement :
1. Va sur https://console.firebase.google.com
2. Clique sur ton projet
3. Clique sur l'icône **⚙️ Paramètres** > **Paramètres du projet**

## Étape 2 : Ajouter l'application Web

Dans "Vos applications" en bas de la page :

### Si tu VOIS déjà une app Web :
1. Clique dessus pour voir la configuration
2. Copie le code de configuration

### Si tu NE VOIS PAS d'app Web :
1. Clique sur **`</>`** (icône Web)
2. Nom : `Applicatho Web`
3. **NE COCHE PAS** Firebase Hosting
4. Clique sur **Enregistrer l'app**
5. Tu verras le code de configuration

## Étape 3 : Copier LA CONFIGURATION

Tu devrais voir quelque chose comme ça :

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyCqUWORd...",
  authDomain: "applicatho-xxxxx.firebaseapp.com",
  projectId: "applicatho-xxxxx",
  storageBucket: "applicatho-xxxxx.appspot.com",
  messagingSenderId: "1234567890",
  appId: "1:1234567890:web:abc123..."
};
```

## Étape 4 : Modifier firebase_options.dart

Ouvre le fichier : `lib/firebase_options.dart`

Cherche cette section (vers la ligne 50) :

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'VOTRE_API_KEY_WEB',  // ← ICI
  appId: 'VOTRE_APP_ID_WEB',    // ← ICI
  messagingSenderId: 'VOTRE_SENDER_ID',  // ← ICI
  projectId: 'VOTRE_PROJECT_ID',  // ← ICI
  authDomain: 'VOTRE_PROJECT_ID.firebaseapp.com',  // ← ICI
  storageBucket: 'VOTRE_PROJECT_ID.appspot.com',  // ← ICI
);
```

Remplace TOUTES les valeurs par celles de Firebase :

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'AIzaSyCqUWORd...',  // ← COLLE ta valeur
  appId: '1:1234567890:web:abc123...',  // ← COLLE ta valeur
  messagingSenderId: '1234567890',  // ← COLLE ta valeur
  projectId: 'applicatho-xxxxx',  // ← COLLE ta valeur
  authDomain: 'applicatho-xxxxx.firebaseapp.com',  // ← COLLE ta valeur
  storageBucket: 'applicatho-xxxxx.appspot.com',  // ← COLLE ta valeur
);
```

## Étape 5 : Sauvegarder et Relancer

1. **Sauvegarde** le fichier `firebase_options.dart`
2. Dans le terminal, lance :

```bash
flutter run -d chrome
```

## ✅ Ça devrait fonctionner !

Si tout est bien configuré, tu verras :
- ✅ L'application se lance
- ✅ Un saint aléatoire s'affiche
- ✅ Un verset aléatoire s'affiche
- ✅ Les 3 membres du BDSPIE s'affichent

## ❌ Si ça ne marche pas

### Erreur "API key not valid"
➡️ Vérifie que tu as bien copié l'API key COMPLÈTE
➡️ Assure-toi qu'il n'y a pas d'espace avant ou après

### Erreur "No Firebase App"
➡️ Vérifie que tu as remplacé TOUTES les valeurs (pas juste projectId)
➡️ Vérifie les guillemets : `'valeur'` pas `"valeur"`

### L'app charge mais rien ne s'affiche
➡️ Vérifie que tes collections Firestore existent (saints, verses, members)
➡️ Vérifie que tu as au moins 1 document dans chaque collection

---

## 🎯 Récapitulatif express

1. Firebase Console → Paramètres → Vos applications
2. Ajouter app Web (si pas déjà fait)
3. Copier la config JavaScript
4. Coller dans `lib/firebase_options.dart` section `web`
5. Sauvegarder
6. `flutter run -d chrome`

**C'est tout ! 🚀**

---

## 📸 Pour t'aider visuellement

### Où trouver la config :
```
Firebase Console
└── ⚙️ Paramètres (en haut à gauche)
    └── Paramètres du projet
        └── Vos applications (en bas)
            └── Cliquer sur l'app Web OU </> pour en créer une
                └── Voir le firebaseConfig
```

### Correspondance :
```
Firebase               →  firebase_options.dart
─────────────────────────────────────────────────
apiKey                 →  apiKey
authDomain             →  authDomain
projectId              →  projectId
storageBucket          →  storageBucket
messagingSenderId      →  messagingSenderId
appId                  →  appId
```

---

**Vas-y maintenant ! Ça prend 2 minutes ! ⏱️**
