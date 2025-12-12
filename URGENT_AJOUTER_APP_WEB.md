# ⚠️ ACTION URGENTE - Ajouter l'app Web à Firebase

## Tu DOIS faire ça maintenant (2 minutes)

### Étape 1 : Ouvrir Firebase Console
Va sur : https://console.firebase.google.com/project/applicatho/settings/general/

### Étape 2 : Ajouter une app Web
1. En bas de la page, dans **"Vos applications"**
2. Tu devrais voir ton app Android déjà ajoutée
3. Clique sur l'icône **`</>`** (Web) pour ajouter une app web

### Étape 3 : Configurer l'app Web
1. **Pseudo de l'app** : `Applicatho Web`
2. **NE COCHE PAS** "Configurer également Firebase Hosting"
3. Clique sur **Enregistrer l'app**

### Étape 4 : Copier l'App ID Web
Après l'enregistrement, tu verras :

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyDR4ecCEyKhCZ9fquNrljkTn84MgRbqJzM",
  authDomain: "applicatho.firebaseapp.com",
  projectId: "applicatho",
  storageBucket: "applicatho.firebasestorage.app",
  messagingSenderId: "689225163008",
  appId: "1:689225163008:web:XXXXX"  // ← COPIE CETTE LIGNE
};
```

### Étape 5 : Coller l'App ID
1. Copie **SEULEMENT** la valeur de `appId` (ex: `1:689225163008:web:abc123...`)
2. Ouvre `lib/firebase_options.dart`
3. Ligne 53, remplace `AJOUTER_APP_WEB` par ton vrai app ID

Exemple :
```dart
// AVANT
appId: '1:689225163008:web:AJOUTER_APP_WEB',

// APRÈS (avec ta vraie valeur)
appId: '1:689225163008:web:abc123def456...',
```

### Étape 6 : Sauvegarde et lance
Sauvegarde le fichier, puis dans le terminal :

```bash
flutter run -d chrome
```

## ✅ C'est tout !

Une fois l'app ID ajouté, l'application fonctionnera !

---

## 🆘 Si tu es bloqué

Dis-moi à quelle étape tu es bloqué et je t'aide !
