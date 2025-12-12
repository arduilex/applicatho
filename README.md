# Applicatho

Application mobile Flutter pour la communauté catholique/chrétienne.

## Description

Applicatho est une application d'information destinée à aider les utilisateurs à s'approcher de la foi catholique. Elle permet de :
- Découvrir le saint du jour
- Lire le verset du jour
- Consulter l'agenda des événements
- Accéder à des prières et versets bibliques
- Localiser les églises à proximité
- Consulter les informations sur les membres du BDSPIE

## Fonctionnalités

### Écran d'accueil
- Image et nom du saint du jour
- Date actuelle
- Verset du jour
- Présentation des membres du BDSPIE (avec photos de profil rondes)
- Les 3 prochains événements à retenir
- FAQ avec réponses déroulantes
- Footer avec liens réseaux sociaux (WhatsApp, Instagram, YouTube)

### Carte des Églises
- Carte interactive utilisant OpenStreetMap
- Localisation des églises les plus proches
- Informations détaillées : nom, distance, adresse, téléphone
- Géolocalisation de l'utilisateur

### Agenda
- Calendrier mensuel
- Liste des événements
- Détails de chaque événement (date, heure, lieu, description)

### Prier
- Section Prières : accès à différentes prières classées par catégories
- Section Versets : bibliothèque de versets bibliques

### Interface d'administration (cachée)
- Accessible en tapant 5 fois sur le titre de l'application
- Permet de gérer tout le contenu (saints, versets, événements, prières, églises, membres, FAQ)

## Installation

### Prérequis
- Flutter SDK (version 3.10.3 ou supérieure)
- Un compte Firebase
- Android Studio ou VS Code avec les extensions Flutter

### Configuration

1. Cloner le projet
```bash
git clone [votre-repo]
cd applicatho
```

2. Installer les dépendances
```bash
flutter pub get
```

3. Configurer Firebase

#### Option 1 : Utiliser FlutterFire CLI (recommandé)
```bash
# Installer FlutterFire CLI si ce n'est pas déjà fait
dart pub global activate flutterfire_cli

# Configurer Firebase pour votre projet
flutterfire configure
```

#### Option 2 : Configuration manuelle
1. Créer un projet Firebase sur [console.firebase.google.com](https://console.firebase.google.com)
2. Activer Firestore Database
3. Activer Firebase Storage (pour les images)
4. Télécharger les fichiers de configuration :
   - Pour Android : `google-services.json` dans `android/app/`
   - Pour iOS : `GoogleService-Info.plist` dans `ios/Runner/`

5. Créer les collections Firestore suivantes :
   - `saints` : {name, imageUrl, date, description}
   - `verses` : {text, reference, date}
   - `events` : {title, description, date, location, imageUrl}
   - `prayers` : {title, text, category}
   - `churches` : {name, address, latitude, longitude, phone, description}
   - `members` : {name, role, photoUrl, order}
   - `faqs` : {question, answer, order}

### Configuration des permissions Android

Ajouter dans `android/app/src/main/AndroidManifest.xml` :
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### Configuration des permissions iOS

Ajouter dans `ios/Runner/Info.plist` :
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Cette application a besoin d'accéder à votre position pour afficher les églises à proximité.</string>
```

## Lancer l'application

```bash
flutter run
```

## Structure du projet

```
lib/
├── main.dart                 # Point d'entrée de l'application
├── models/                   # Modèles de données
│   ├── saint.dart
│   ├── verse.dart
│   ├── event.dart
│   ├── prayer.dart
│   ├── church.dart
│   ├── member.dart
│   └── faq.dart
├── services/                 # Services
│   └── firebase_service.dart # Service Firebase
├── screens/                  # Écrans
│   ├── home_screen.dart
│   ├── church_map_screen.dart
│   ├── agenda_screen.dart
│   ├── prayer_screen.dart
│   └── admin_screen.dart
├── widgets/                  # Widgets réutilisables
│   ├── app_drawer.dart
│   └── social_footer.dart
└── utils/                    # Utilitaires
    └── constants.dart
```

## Stack technique

- **Frontend** : Flutter
- **Backend** : Firebase (Firestore + Storage)
- **Carte** : OpenStreetMap via flutter_map
- **Gestion d'état** : Provider
- **Calendrier** : table_calendar

## Configuration des réseaux sociaux

Modifier les liens dans `lib/utils/constants.dart` :
```dart
class SocialLinks {
  static const whatsapp = 'https://wa.me/VOTRE_NUMERO';
  static const instagram = 'https://instagram.com/VOTRE_COMPTE';
  static const youtube = 'https://youtube.com/VOTRE_CHAINE';
}
```

## Gestion du contenu

### Via l'interface d'administration
1. Lancer l'application
2. Sur l'écran d'accueil, taper 5 fois rapidement sur le titre "Applicatho"
3. Accéder au panneau d'administration
4. Gérer le contenu (à implémenter)

### Via Firebase Console
1. Aller sur [console.firebase.google.com](https://console.firebase.google.com)
2. Sélectionner votre projet
3. Naviguer vers Firestore Database
4. Ajouter/modifier/supprimer les documents dans les collections

## Exemples de données Firestore

### Collection `saints`
```json
{
  "name": "Saint François d'Assise",
  "imageUrl": "https://...",
  "date": "2024-10-04T00:00:00.000Z",
  "description": "Fondateur de l'ordre franciscain..."
}
```

### Collection `verses`
```json
{
  "text": "Car Dieu a tant aimé le monde qu'il a donné son Fils unique...",
  "reference": "Jean 3:16",
  "date": "2024-01-15T00:00:00.000Z"
}
```

### Collection `members`
```json
{
  "name": "LESCURE Maël",
  "role": "Président de l'association",
  "photoUrl": "https://...",
  "order": 1
}
```

## Développement futur

- [ ] Implémenter les écrans de gestion admin complets
- [ ] Ajouter des notifications push pour les événements
- [ ] Intégrer un lecteur audio pour les prières
- [ ] Ajouter un mode hors-ligne
- [ ] Système de favoris pour les prières
- [ ] Partage de versets sur les réseaux sociaux

## Licence

Tous droits réservés - BDSPIE

## Contact

Pour toute question ou suggestion, contactez [votre email]
