# 📱 Installer l'app sur Android via WiFi (sans câble)

## Option 1 : Build APK et installer (RECOMMANDÉ)

### Étape 1 : Builder l'APK
Dans ton terminal :

```bash
flutter build apk --release
```

Attends que le build se termine (2-5 minutes).

### Étape 2 : Trouver l'APK
L'APK sera créé ici :
```
build\app\outputs\flutter-apk\app-release.apk
```

### Étape 3 : Transférer l'APK sur ton téléphone

**Méthode A : Par Email**
1. Attache `app-release.apk` à un email
2. Envoie-le à ton adresse email
3. Ouvre l'email sur ton téléphone
4. Télécharge l'APK
5. Ouvre le fichier et installe

**Méthode B : Google Drive / OneDrive**
1. Upload `app-release.apk` sur Drive
2. Ouvre Drive sur ton téléphone
3. Télécharge l'APK
4. Installe

**Méthode C : WhatsApp / Telegram**
1. Envoie-toi l'APK via WhatsApp ou Telegram
2. Télécharge sur ton téléphone
3. Installe

### Étape 4 : Installer sur le téléphone
1. Quand tu ouvres l'APK, Android va demander "Installer des applications inconnues"
2. Autorise l'installation depuis cette source
3. Clique sur "Installer"
4. Une fois installé, clique sur "Ouvrir"

✅ **L'app est installée !**

---

## Option 2 : ADB via WiFi (plus technique)

Si tu as déjà connecté ton téléphone une fois en USB, tu peux utiliser ADB en WiFi.

### Prérequis
- Ton téléphone doit être sur le même WiFi que ton PC
- ADB doit être installé (inclus avec Flutter)
- Activer le mode développeur sur ton téléphone

### Étape 1 : Activer le mode développeur
1. Va dans **Paramètres** > **À propos du téléphone**
2. Tape 7 fois sur **Numéro de build**
3. Le mode développeur est activé

### Étape 2 : Activer le débogage USB
1. **Paramètres** > **Options de développeur**
2. Active **Débogage USB**

### Étape 3 : Connecter en USB (une seule fois)
1. Connecte ton téléphone en USB
2. Autorise le débogage USB sur le téléphone
3. Dans le terminal :

```bash
adb devices
```

Tu devrais voir ton appareil.

### Étape 4 : Activer ADB en WiFi
```bash
adb tcpip 5555
```

### Étape 5 : Trouver l'IP de ton téléphone
Sur ton téléphone :
1. **Paramètres** > **WiFi**
2. Clique sur ton réseau WiFi
3. Note l'adresse IP (ex: 192.168.1.45)

### Étape 6 : Connecter en WiFi
```bash
adb connect 192.168.1.45:5555
```

### Étape 7 : Débrancher le câble USB
Tu peux maintenant débrancher le câble !

### Étape 8 : Vérifier la connexion
```bash
flutter devices
```

Tu devrais voir ton téléphone listé.

### Étape 9 : Lancer l'app
```bash
flutter run
```

---

## Option 3 : Android Studio Wireless Debugging (Android 11+)

Si ton téléphone est sous Android 11 ou supérieur :

### Sur ton téléphone :
1. **Paramètres** > **Options de développeur**
2. Active **Débogage sans fil**
3. Note le code de jumelage

### Sur ton PC :
1. Ouvre Android Studio
2. Va dans **Run** > **Pair Devices Using WiFi**
3. Entre le code de jumelage

Puis lance :
```bash
flutter run
```

---

## 🎯 Quelle option choisir ?

### Pour une installation simple et rapide :
➡️ **Option 1** (Build APK) - Plus simple, pas besoin de câble du tout

### Pour du développement continu :
➡️ **Option 2** (ADB WiFi) - Tu pourras faire des hot reload sans fil

### Pour Android 11+ :
➡️ **Option 3** (Wireless Debugging) - La plus moderne

---

## ⚠️ Important pour l'Option 1 (APK)

### Avant de builder l'APK, vérifie :

1. **Le fichier google-services.json est bien présent**
   ```
   android/app/google-services.json
   ```

2. **Firebase est bien configuré**
   - Les règles Firestore permettent la lecture
   - Tes collections existent (saints, verses, members)

3. **Build l'APK en release**
   ```bash
   flutter build apk --release
   ```

### Taille de l'APK
L'APK fera environ 20-40 MB.

---

## 🚀 Après l'installation

Une fois l'app installée sur ton téléphone, tu verras :
- ✅ Le saint aléatoire (avec image)
- ✅ Le verset aléatoire
- ✅ Les 3 membres du BDSPIE
- ✅ Toutes les fonctionnalités

---

## 🆘 Problèmes courants

### "Impossible d'installer l'app"
➡️ Va dans Paramètres > Sécurité > Autoriser les sources inconnues

### "L'app crash au démarrage"
➡️ Vérifie que google-services.json est bien dans android/app/
➡️ Rebuild l'APK : `flutter build apk --release`

### "Pas de données affichées"
➡️ Vérifie ta connexion Internet
➡️ Vérifie les règles Firestore
➡️ Vérifie que les collections existent dans Firestore

---

## 💡 Conseil

Pour la première fois, je recommande **l'Option 1** (Build APK) :
- C'est le plus simple
- Pas besoin de configurer ADB
- Tu peux partager l'APK avec d'autres personnes

Tu veux que je lance le build maintenant ?
