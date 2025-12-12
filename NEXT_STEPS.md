# Prochaines Étapes - Applicatho

Félicitations ! La base de votre application est prête. Voici ce qu'il vous reste à faire :

## 🔥 Étape 1 : Configuration Firebase (URGENT - 15 min)

### A. Créer le projet Firebase
```bash
# Ouvrir Firebase Console dans votre navigateur
https://console.firebase.google.com
```

1. Cliquez sur "Ajouter un projet"
2. Nom : **applicatho**
3. Analytics : Oui (recommandé)
4. Suivez les étapes

### B. Activer Firestore
1. Dans le menu latéral : **Build** > **Firestore Database**
2. Cliquez **Créer une base de données**
3. Mode : **Production**
4. Région : **europe-west1** (ou la plus proche)
5. Cliquez **Activer**

### C. Configurer les règles Firestore
Dans l'onglet **Règles**, remplacez le contenu par :
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
Cliquez sur **Publier**

### D. Ajouter l'application Android
1. Dans **Aperçu du projet**, cliquez sur l'icône **Android**
2. Package Android : `com.example.applicatho`
3. Pseudo de l'app : Applicatho
4. Cliquez **Enregistrer l'app**
5. **Téléchargez google-services.json**
6. **Placez-le dans** : `android/app/google-services.json`

## 📊 Étape 2 : Créer les données de test (30 min)

### Dans Firebase Console > Firestore Database

#### Collection `saints` (obligatoire pour l'accueil)
Cliquez "Démarrer une collection" > ID : `saints`

**Document 1** (ID automatique) :
```
name (string): Saint Joseph
imageUrl (string): https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Guido_Reni_-_St_Joseph_with_the_Infant_Jesus_-_WGA19304.jpg/400px-Guido_Reni_-_St_Joseph_with_the_Infant_Jesus_-_WGA19304.jpg
description (string): Époux de la Vierge Marie et père nourricier de Jésus
```

**IMPORTANT** : L'application choisit un saint **aléatoirement** parmi tous les saints dans la collection. Vous pouvez ajouter autant de saints que vous voulez !

#### Collection `verses` (obligatoire pour l'accueil)
**Document 1** :
```
text (string): Je suis le chemin, la vérité et la vie. Nul ne vient au Père que par moi.
reference (string): Jean 14:6
```

**IMPORTANT** : L'application choisit un verset **aléatoirement** parmi tous les versets. Vous pouvez en ajouter plusieurs !

#### Collection `members` (obligatoire pour l'accueil)
**Document 1** :
```
name (string): LESCURE Maël
role (string): Président de l'association
photoUrl (string): https://via.placeholder.com/150
order (number): 1
```

**Document 2** :
```
name (string): KLEIN Thomas
role (string): Vice Président
photoUrl (string): https://via.placeholder.com/150
order (number): 2
```

**Document 3** :
```
name (string): Père Jean-Yves
role (string): Aumonier de l'ICAM
photoUrl (string): https://via.placeholder.com/150
order (number): 3
```

#### Collection `events` (optionnel mais recommandé)
**Document 1** :
```
title (string): Messe de Noël
description (string): Célébration de la naissance du Christ
date (timestamp): 25 décembre 2024 à 19:00
location (string): Cathédrale Notre-Dame
imageUrl (string): [vide ou URL]
```

#### Collection `prayers` (optionnel)
**Document 1** :
```
title (string): Notre Père
text (string): Notre Père qui es aux cieux, que ton nom soit sanctifié, que ton règne vienne...
category (string): Prières essentielles
```

#### Collection `churches` (optionnel)
**Document 1** :
```
name (string): Cathédrale Notre-Dame de Paris
address (string): 6 Parvis Notre-Dame, 75004 Paris
latitude (number): 48.853
longitude (number): 2.3499
phone (string): +33 1 42 34 56 10
description (string): Cathédrale emblématique de Paris
```

#### Collection `faqs` (optionnel)
**Document 1** :
```
question (string): Quels sont les horaires des messes ?
answer (string): Les messes ont lieu tous les dimanches à 10h30 et en semaine à 18h30.
order (number): 1
```

## 🧪 Étape 3 : Tester l'application (5 min)

```bash
# Nettoyer le projet
flutter clean

# Réinstaller les dépendances
flutter pub get

# Lancer l'application
flutter run
```

### Vérifications :
- ✅ Application démarre sans erreur
- ✅ Saint du jour s'affiche
- ✅ Verset du jour s'affiche
- ✅ 3 membres s'affichent
- ✅ Menu latéral fonctionne
- ✅ Navigation fonctionne

## 🎨 Étape 4 : Personnalisation (optionnel, 10 min)

### Modifier les couleurs
Fichier : [lib/utils/constants.dart](lib/utils/constants.dart)
```dart
class AppColors {
  static const primary = Color(0xFF8B4513); // Changez ici
  static const secondary = Color(0xFFD4AF37); // Et ici
}
```

### Modifier les liens sociaux
Même fichier :
```dart
class SocialLinks {
  static const whatsapp = 'https://wa.me/33612345678';
  static const instagram = 'https://instagram.com/votre_compte';
  static const youtube = 'https://youtube.com/@votre_chaine';
}
```

### Modifier les mentions légales
Fichier : [lib/widgets/social_footer.dart](lib/widgets/social_footer.dart:56)
Ligne 56 : Modifiez le texte du dialogue

## 📱 Étape 5 : Remplir toutes les données (quand prêt)

### Préparez vos contenus :

#### Saints
- [ ] Liste des saints pour chaque jour de l'année
- [ ] Images haute qualité (recommandé : Wikimedia Commons)
- [ ] Descriptions courtes mais informatives

#### Versets
- [ ] Sélection de versets quotidiens
- [ ] Références précises
- [ ] Traduction choisie

#### Événements
- [ ] Calendrier complet des événements
- [ ] Lieux précis
- [ ] Descriptions détaillées
- [ ] Photos si disponibles

#### Églises
- [ ] Liste des églises de votre région
- [ ] Coordonnées GPS précises
- [ ] Adresses complètes
- [ ] Numéros de téléphone
- [ ] Horaires des messes (dans description)

#### Prières
- [ ] Collection de prières classées
- [ ] Catégories : Essentielles, Matinales, Vespérales, etc.
- [ ] Textes complets et corrects

#### Photos des membres
- [ ] Vraies photos des 3 membres
- [ ] Uploadez sur Firebase Storage ou utilisez un service d'hébergement
- [ ] Remplacez les URLs placeholder

## 🚀 Étape 6 : Build Release (avant publication)

```bash
# Build APK
flutter build apk --release

# L'APK sera dans : build/app/outputs/flutter-apk/app-release.apk
```

### Tests avant publication :
- [ ] Testé sur plusieurs appareils Android
- [ ] Toutes les fonctionnalités testées
- [ ] Performance vérifiée
- [ ] Pas de crash
- [ ] Données complètes

## 📝 Documents de référence

- **[README.md](README.md)** : Documentation complète
- **[FIREBASE_SETUP.md](FIREBASE_SETUP.md)** : Guide détaillé Firebase
- **[QUICK_START.md](QUICK_START.md)** : Démarrage rapide
- **[CHECKLIST.md](CHECKLIST.md)** : Liste de vérification

## ⚠️ Important à savoir

### Interface Admin
Pour accéder à l'admin (actuellement juste un menu) :
1. Ouvrez l'application
2. Sur l'écran d'accueil
3. Tapez **5 fois rapidement** sur "Applicatho" en haut

### Sécurité
- ⚠️ Ne commitez JAMAIS `google-services.json` sur Git
- ⚠️ Les règles Firestore actuelles permettent la lecture publique
- ⚠️ Pour activer l'édition depuis l'app, modifiez les règles

### Performance
- Images optimisées recommandées (< 500 KB)
- Utilisez Firebase Storage pour héberger les images
- Testez sur réseau lent

## 🆘 Problèmes courants

### "No Firebase App"
➡️ Vérifiez que `google-services.json` est bien placé
➡️ Relancez avec `flutter clean && flutter pub get`

### Rien ne s'affiche
➡️ Vérifiez que les collections Firestore existent
➡️ Vérifiez les règles Firestore
➡️ Regardez les logs : `flutter run -v`

### Erreur de permission localisation
➡️ Acceptez les permissions quand demandé
➡️ Vérifiez AndroidManifest.xml

## 💡 Conseils

1. **Commencez simple** : Testez avec les données de base d'abord
2. **Remplissez progressivement** : Ajoutez des données petit à petit
3. **Testez régulièrement** : Après chaque modification
4. **Demandez des retours** : Faites tester par vos utilisateurs cibles
5. **Documentez** : Notez ce que vous faites pour l'équipe

## 🎯 Objectif immédiat

**MAINTENANT** :
1. ✅ Créer le projet Firebase (15 min)
2. ✅ Ajouter les 3 collections minimales (saints, verses, members)
3. ✅ Télécharger et placer google-services.json
4. ✅ Tester avec `flutter run`

**Ça devrait marcher !** 🎉

Une fois que ça fonctionne, vous pourrez remplir les autres données tranquillement.

## 📞 Support

Si vous êtes bloqué :
1. Consultez [FIREBASE_SETUP.md](FIREBASE_SETUP.md)
2. Vérifiez [CHECKLIST.md](CHECKLIST.md)
3. Regardez les logs : `flutter run -v`

Bon courage ! 🙏
