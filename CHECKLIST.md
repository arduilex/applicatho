# Checklist de Configuration - Applicatho

Utilisez cette checklist pour vous assurer que tout est bien configuré.

## ✅ Configuration de base Flutter

- [x] Flutter installé et configuré
- [x] Dépendances installées (`flutter pub get`)
- [x] Permissions Android ajoutées dans AndroidManifest.xml
- [x] Permissions iOS ajoutées dans Info.plist
- [x] Plugin Google Services ajouté dans build.gradle.kts

## 🔥 Configuration Firebase

### Création du projet
- [ ] Projet Firebase créé sur https://console.firebase.google.com
- [ ] Nom du projet : `applicatho` (ou votre choix)
- [ ] Firestore Database activé (mode production)
- [ ] Storage activé (optionnel)

### Configuration Android
- [ ] Application Android ajoutée dans Firebase Console
- [ ] Package name : `com.example.applicatho`
- [ ] Fichier `google-services.json` téléchargé
- [ ] Fichier placé dans `android/app/google-services.json`

### Configuration iOS (optionnel)
- [ ] Application iOS ajoutée dans Firebase Console
- [ ] Bundle ID : `com.example.applicatho`
- [ ] Fichier `GoogleService-Info.plist` téléchargé
- [ ] Fichier placé dans `ios/Runner/GoogleService-Info.plist`

### Règles Firestore
- [ ] Règles de sécurité configurées (allow read: if true)
- [ ] Règles testées

## 📊 Collections Firestore

### Saints (Saint du jour)
- [ ] Collection `saints` créée
- [ ] Au moins 1 document avec la date d'aujourd'hui
- [ ] Champs : name, imageUrl, date, description

### Versets (Verset du jour)
- [ ] Collection `verses` créée
- [ ] Au moins 1 document avec la date d'aujourd'hui
- [ ] Champs : text, reference, date

### Membres BDSPIE
- [ ] Collection `members` créée
- [ ] 3 membres ajoutés (LESCURE Maël, KLEIN Thomas, Père Jean-Yves)
- [ ] Champs : name, role, photoUrl, order

### Événements
- [ ] Collection `events` créée
- [ ] Au moins 1 événement futur ajouté
- [ ] Champs : title, description, date, location, imageUrl

### Prières
- [ ] Collection `prayers` créée
- [ ] Au moins 1 prière ajoutée
- [ ] Champs : title, text, category

### Églises
- [ ] Collection `churches` créée
- [ ] Au moins 1 église ajoutée
- [ ] Champs : name, address, latitude, longitude, phone, description

### FAQ
- [ ] Collection `faqs` créée
- [ ] Au moins 1 question ajoutée
- [ ] Champs : question, answer, order

## 🎨 Personnalisation

### Couleurs
- [ ] Couleurs modifiées dans `lib/utils/constants.dart` (optionnel)
- [ ] Testées sur l'interface

### Réseaux sociaux
- [ ] Liens WhatsApp configurés dans `lib/utils/constants.dart`
- [ ] Lien Instagram configuré
- [ ] Lien YouTube configuré

### Textes
- [ ] Nom de l'application vérifié
- [ ] Mentions légales personnalisées dans `social_footer.dart`

## 🧪 Tests

### Tests fonctionnels
- [ ] Application lance sans erreur
- [ ] Écran d'accueil affiche le saint du jour
- [ ] Verset du jour s'affiche
- [ ] Membres du BDSPIE affichés
- [ ] 3 prochains événements visibles
- [ ] FAQ fonctionne (expansion/collapse)

### Navigation
- [ ] Menu latéral s'ouvre
- [ ] Navigation vers Carte des Églises fonctionne
- [ ] Navigation vers Agenda fonctionne
- [ ] Navigation vers Prier fonctionne
- [ ] Retour à l'accueil fonctionne

### Carte des Églises
- [ ] Carte OpenStreetMap s'affiche
- [ ] Géolocalisation demandée et acceptée
- [ ] Églises visibles sur la carte
- [ ] Clic sur marqueur affiche les détails
- [ ] Distance calculée depuis position utilisateur

### Agenda
- [ ] Calendrier s'affiche
- [ ] Événements marqués sur le calendrier
- [ ] Clic sur date affiche les événements du jour
- [ ] Détails des événements accessibles

### Prières et Versets
- [ ] Onglet Prières accessible
- [ ] Prières groupées par catégorie
- [ ] Expansion des prières fonctionne
- [ ] Onglet Versets accessible
- [ ] Versets affichés correctement

### Interface Admin
- [ ] 5 taps sur titre "Applicatho" ouvre l'admin
- [ ] Liste des sections admin visible

### Footer
- [ ] Icônes réseaux sociaux affichées
- [ ] Liens fonctionnent
- [ ] Mentions légales affichent le dialogue

## 🚀 Build et Déploiement

### Build de test
- [ ] `flutter clean` exécuté
- [ ] `flutter pub get` exécuté
- [ ] `flutter run` fonctionne sans erreur
- [ ] Application testée sur émulateur/appareil

### Build Release (avant publication)
- [ ] `flutter build apk --release` fonctionne
- [ ] APK testé sur appareil réel
- [ ] Toutes les fonctionnalités testées en release

### Optimisations
- [ ] Images optimisées pour le web
- [ ] Taille de l'APK raisonnable (< 50 MB idéalement)
- [ ] Temps de chargement acceptable

## 📱 Tests utilisateur

### Android
- [ ] Testé sur Android 8+ minimum
- [ ] Permissions de localisation fonctionnent
- [ ] Pas de crash
- [ ] Performance acceptable

### iOS (si applicable)
- [ ] Testé sur iOS 12+ minimum
- [ ] Permissions de localisation fonctionnent
- [ ] Pas de crash
- [ ] Performance acceptable

## 📝 Documentation

- [ ] README.md à jour
- [ ] FIREBASE_SETUP.md consulté
- [ ] QUICK_START.md consulté
- [ ] Équipe informée de l'accès admin (5 taps)

## 🔐 Sécurité

### Règles Firebase
- [ ] Règles Firestore empêchent l'écriture non autorisée
- [ ] Règles Storage configurées
- [ ] Pas de données sensibles exposées

### Application
- [ ] Pas de clés API hardcodées (sauf Firebase)
- [ ] Pas de mots de passe dans le code
- [ ] google-services.json dans .gitignore

## ✨ Avant la mise en production

- [ ] Toutes les collections remplies avec vraies données
- [ ] Vraies photos des membres uploadées
- [ ] Liste complète des églises
- [ ] Événements à jour
- [ ] Prières complètes
- [ ] Versets pour plusieurs jours/semaines
- [ ] FAQ complète
- [ ] Liens réseaux sociaux vérifiés
- [ ] Mentions légales complètes et correctes
- [ ] Tests sur plusieurs appareils
- [ ] Feedback utilisateurs recueillis

## 📊 Métriques de succès

À vérifier après le lancement :
- [ ] Nombre d'utilisateurs actifs
- [ ] Crash rate < 1%
- [ ] Temps de chargement < 3s
- [ ] Taux de rétention satisfaisant
- [ ] Retours utilisateurs positifs

---

**Note** : Cette checklist peut être adaptée selon vos besoins spécifiques.

**Légende** :
- [x] = Déjà fait (configuration de base)
- [ ] = À faire (votre configuration)
