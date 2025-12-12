# 🚀 Builder l'APK avec GitHub Actions (GRATUIT)

## ✅ Ce que j'ai fait pour toi

J'ai créé un workflow GitHub Actions qui va :
- ✅ Builder automatiquement ton APK dans le cloud
- ✅ Le mettre en téléchargement
- ✅ Créer une release GitHub
- ✅ Tout ça GRATUITEMENT !

Le fichier est : `.github/workflows/build-android.yml`

---

## 📋 Étapes pour utiliser GitHub Actions

### Étape 1 : Créer un repo GitHub

Si tu n'as pas encore de compte GitHub :
1. Va sur https://github.com
2. Créé un compte (gratuit)

### Étape 2 : Créer un nouveau repo

1. Clique sur **"New repository"** (bouton vert)
2. Nom du repo : `applicatho`
3. Visibilité : **Public** (pour profiter du build gratuit)
4. NE COCHE PAS "Add README" (on l'a déjà)
5. Clique sur **"Create repository"**

### Étape 3 : Initialiser Git localement

Dans ton terminal (dans le dossier applicatho) :

```bash
# Initialiser git
git init

# Ajouter tous les fichiers
git add .

# Premier commit
git commit -m "Initial commit - Application Applicatho"
```

### Étape 4 : Lier au repo GitHub

GitHub va te montrer des commandes, utilise celles-ci :

```bash
# Ajouter le remote (remplace TON_USERNAME)
git remote add origin https://github.com/TON_USERNAME/applicatho.git

# Renommer la branche en main
git branch -M main

# Push vers GitHub
git push -u origin main
```

### Étape 5 : Le workflow se lance automatiquement !

Une fois que tu push :
1. Va sur GitHub > ton repo > onglet **"Actions"**
2. Tu verras le workflow "Build Android APK" en cours
3. Attends 5-10 minutes

### Étape 6 : Télécharger l'APK

Quand le build est terminé :
1. Clique sur le workflow terminé (coche verte ✅)
2. En bas, dans **"Artifacts"**, clique sur **"applicatho-release"**
3. Un fichier ZIP se télécharge
4. Extrais le ZIP pour obtenir `app-release.apk`

### Étape 7 : Installer sur ton téléphone

**Méthode A : Email**
1. Envoie-toi `app-release.apk` par email
2. Ouvre l'email sur ton téléphone
3. Télécharge et installe l'APK

**Méthode B : Google Drive**
1. Upload l'APK sur Google Drive
2. Télécharge depuis ton téléphone
3. Installe

**Méthode C : WhatsApp**
1. Envoie-toi l'APK via WhatsApp
2. Télécharge et installe

---

## 🎯 Lancer un build manuellement

Tu peux aussi lancer un build sans faire de commit :

1. Va sur GitHub > ton repo > **Actions**
2. Clique sur **"Build Android APK"** (à gauche)
3. Clique sur **"Run workflow"** (bouton à droite)
4. Sélectionne la branche `main`
5. Clique sur **"Run workflow"**

---

## ⚙️ Comment ça marche ?

Le workflow que j'ai créé :
1. ✅ Installe Java
2. ✅ Installe Flutter
3. ✅ Récupère les dépendances
4. ✅ Build l'APK en mode release
5. ✅ Upload l'APK comme artifact
6. ✅ Crée une release GitHub (optionnel)

Tout ça se passe sur les serveurs de GitHub, **gratuitement** !

---

## 📊 Limites de GitHub Actions (gratuit)

- ✅ 2000 minutes de build/mois (largement suffisant)
- ✅ Illimité pour les repos publics
- ✅ Stockage des artifacts : 500 MB

Un build prend environ 5-10 minutes, donc tu peux faire ~200-400 builds/mois gratuitement !

---

## 🔄 À chaque fois que tu veux un nouveau build

1. Fait tes modifications dans le code
2. Commit et push :
   ```bash
   git add .
   git commit -m "Description des changements"
   git push
   ```
3. GitHub Actions va builder automatiquement
4. Télécharge le nouvel APK

---

## 🆘 Problèmes courants

### Le workflow ne se lance pas
➡️ Vérifie que le repo est public
➡️ Va dans Settings > Actions > General > Autorise les workflows

### Le build échoue
➡️ Regarde les logs dans l'onglet Actions
➡️ Vérifie que google-services.json est bien commité

### Je ne vois pas l'artifact
➡️ Le workflow doit être terminé (coche verte)
➡️ Scroll en bas de la page du workflow

---

## 💡 Astuce PRO

Tu peux aussi créer des releases automatiques :
1. Le workflow crée une release avec un numéro de version
2. Chaque release contient l'APK
3. Tu peux partager le lien de la release directement !

---

## 🎉 Résumé

1. Push ton code sur GitHub
2. GitHub Actions build l'APK automatiquement
3. Télécharge l'APK
4. Installe sur ton téléphone

**C'est gratuit, automatique, et toujours disponible !**

---

## ⏱️ Temps estimé

- Setup GitHub : 5 minutes
- Premier push : 2 minutes
- Build automatique : 5-10 minutes
- Téléchargement : 1 minute

**Total : ~20 minutes pour avoir ton APK !**

Tu veux que je t'aide à pusher sur GitHub maintenant ?
