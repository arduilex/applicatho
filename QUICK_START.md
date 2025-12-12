# Démarrage Rapide - Applicatho

## Étapes essentielles pour lancer l'application

### 1. Configuration Firebase (OBLIGATOIRE)

L'application nécessite Firebase pour fonctionner. Suivez ces étapes :

#### A. Créer un projet Firebase
1. Allez sur https://console.firebase.google.com
2. Créez un nouveau projet nommé "applicatho"
3. Activez **Firestore Database** (mode production)
4. Activez **Storage** (optionnel, pour les images)

#### B. Configurer l'application Android

1. Dans Firebase Console, ajoutez une application Android
2. Package name : `com.example.applicatho`
3. Téléchargez le fichier `google-services.json`
4. **IMPORTANT** : Placez ce fichier dans `android/app/google-services.json`

#### C. Créer les collections Firestore

Dans Firestore, créez au minimum ces collections pour tester l'app :

**Collection `saints`** - Saint du jour
```
Document ID: (auto)
- name: "Saint Joseph"
- imageUrl: "https://example.com/saint.jpg"
- date: [aujourd'hui]
- description: "Description du saint"
```

**Collection `verses`** - Verset du jour
```
Document ID: (auto)
- text: "Je suis le chemin, la vérité et la vie"
- reference: "Jean 14:6"
- date: [aujourd'hui]
```

**Collection `members`** - Membres du BDSPIE
```
Document 1:
- name: "LESCURE Maël"
- role: "Président de l'association"
- photoUrl: "https://example.com/photo1.jpg"
- order: 1

Document 2:
- name: "KLEIN Thomas"
- role: "Vice Président"
- photoUrl: "https://example.com/photo2.jpg"
- order: 2

Document 3:
- name: "Père Jean-Yves"
- role: "Aumonier de l'ICAM"
- photoUrl: "https://example.com/photo3.jpg"
- order: 3
```

**Collection `events`** - Événements
```
Document ID: (auto)
- title: "Messe de Noël"
- description: "Célébration spéciale"
- date: [date future]
- location: "Église principale"
- imageUrl: ""
```

#### D. Configurer les règles Firestore

Dans Firestore > Règles, copiez ceci :

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read: if true;
      allow write: if false;
    }
  }
}
```

### 2. Lancer l'application

```bash
# Nettoyer le projet
flutter clean

# Installer les dépendances
flutter pub get

# Lancer sur Android
flutter run

# Ou lancer sur un émulateur spécifique
flutter run -d <device_id>
```

### 3. Personnalisation

#### Modifier les couleurs
Fichier : `lib/utils/constants.dart`
```dart
class AppColors {
  static const primary = Color(0xFF8B4513); // Votre couleur
  static const secondary = Color(0xFFD4AF37);
  // ...
}
```

#### Modifier les liens sociaux
Fichier : `lib/utils/constants.dart`
```dart
class SocialLinks {
  static const whatsapp = 'https://wa.me/VOTRE_NUMERO';
  static const instagram = 'https://instagram.com/VOTRE_COMPTE';
  static const youtube = 'https://youtube.com/VOTRE_CHAINE';
}
```

### 4. Fonctionnalités de l'application

#### Navigation
- **Menu latéral** : Glissez depuis la gauche ou cliquez sur l'icône hamburger
- **Accueil** : Page principale avec saint du jour, verset, membres
- **Carte** : Localisation des églises sur OpenStreetMap
- **Agenda** : Calendrier des événements
- **Prier** : Prières et versets

#### Interface Admin (cachée)
Pour accéder à l'interface d'administration :
1. Allez sur l'écran d'accueil
2. Tapez **5 fois rapidement** sur le titre "Applicatho"
3. L'interface admin s'ouvre

### 5. Structure des données complètes

Pour voir toutes les collections et leurs champs, consultez `FIREBASE_SETUP.md`

Collections nécessaires :
- ✅ `saints` - Saint du jour
- ✅ `verses` - Versets bibliques
- ✅ `events` - Événements
- ✅ `prayers` - Prières
- ✅ `churches` - Églises
- ✅ `members` - Membres BDSPIE
- ✅ `faqs` - Questions fréquentes

### 6. Dépannage

#### Erreur "No Firebase App"
- Vérifiez que `google-services.json` est dans `android/app/`
- Relancez avec `flutter clean && flutter pub get`

#### Pas de données affichées
- Vérifiez que vos collections Firestore existent
- Vérifiez que les règles permettent la lecture (allow read: if true)
- Vérifiez les logs : `flutter run -v`

#### Erreur de localisation
- Acceptez les permissions de localisation quand demandé
- Sur Android : Paramètres > Apps > Applicatho > Permissions

#### Erreur de build Android
- Vérifiez que vous avez bien ajouté le plugin Google Services
- Le fichier `android/app/build.gradle.kts` doit contenir :
  ```kotlin
  id("com.google.gms.google-services")
  ```

### 7. Commandes utiles

```bash
# Voir les devices disponibles
flutter devices

# Nettoyer le build
flutter clean

# Voir les logs détaillés
flutter run -v

# Builder en release
flutter build apk --release

# Analyser le code
flutter analyze
```

### 8. Prochaines étapes

Une fois l'application fonctionnelle :
1. Remplissez toutes les collections Firestore avec vos données
2. Uploadez les images dans Firebase Storage
3. Testez toutes les fonctionnalités
4. Personnalisez les couleurs et textes
5. Configurez les liens réseaux sociaux

### 9. Ressources

- Documentation complète : `FIREBASE_SETUP.md`
- Firebase Console : https://console.firebase.google.com
- Documentation Flutter : https://docs.flutter.dev
- FlutterFire : https://firebase.flutter.dev

### 10. Support

Pour toute question, consultez :
- Le `README.md` pour la documentation générale
- Le `FIREBASE_SETUP.md` pour les détails Firebase
- Les logs de l'application pour débugger

---

**Note importante** : Sans Firebase configuré, l'application ne fonctionnera pas. La configuration Firebase est la première étape obligatoire.

Bon développement ! 🙏
