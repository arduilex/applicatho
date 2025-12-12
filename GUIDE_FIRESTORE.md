# Guide Simplifié : Créer les Collections Firestore

Ce guide explique comment créer les collections dans Firestore **étape par étape**, comme si tu le faisais pour la première fois.

## Étape 1 : Collection `saints`

### 1.1 Créer la collection

1. Va dans **Firestore Database** dans Firebase Console
2. Clique sur **"Démarrer une collection"** (ou "Ajouter une collection")
3. Dans **"ID de la collection"**, tape exactement : `saints`
4. Clique sur **"Suivant"**

### 1.2 Ajouter le premier document

Tu es maintenant sur l'écran pour ajouter le premier document.

1. **ID du document** : Laisse sur **"ID automatique"** (ne change rien)

2. **Ajouter les champs** (clique sur "Ajouter un champ" entre chaque) :

   **Champ 1 :**
   - Nom du champ : `name`
   - Type : `string`
   - Valeur : `Saint Joseph`

   **Champ 2 :**
   - Nom du champ : `imageUrl`
   - Type : `string`
   - Valeur : `https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Guido_Reni_-_St_Joseph_with_the_Infant_Jesus_-_WGA19304.jpg/400px-Guido_Reni_-_St_Joseph_with_the_Infant_Jesus_-_WGA19304.jpg`

   **Champ 3 :**
   - Nom du champ : `description`
   - Type : `string`
   - Valeur : `Époux de la Vierge Marie et père nourricier de Jésus`

3. Clique sur **"Enregistrer"** en bas

✅ **C'est fait !** Tu as créé ta première collection avec un saint.

### 1.3 Ajouter d'autres saints (optionnel)

Pour ajouter plus de saints :
1. Clique sur **"Ajouter un document"** dans la collection `saints`
2. ID automatique
3. Ajoute les 3 mêmes champs (name, imageUrl, description)
4. Enregistrer

**Conseil** : Plus tu ajoutes de saints, plus l'application aura de variété !

---

## Étape 2 : Collection `verses`

### 2.1 Créer la collection

1. Clique sur **"Démarrer une collection"** (en haut, à côté de "Cloud Firestore")
2. ID de la collection : `verses`
3. Suivant

### 2.2 Ajouter le premier verset

1. **ID du document** : ID automatique

2. **Ajouter les champs** :

   **Champ 1 :**
   - Nom : `text`
   - Type : `string`
   - Valeur : `Je suis le chemin, la vérité et la vie. Nul ne vient au Père que par moi.`

   **Champ 2 :**
   - Nom : `reference`
   - Type : `string`
   - Valeur : `Jean 14:6`

3. Enregistrer

✅ **Collection verses créée !**

### 2.3 Ajouter d'autres versets (recommandé)

Quelques exemples de versets à ajouter :

**Verset 2 :**
```
text: Car Dieu a tant aimé le monde qu'il a donné son Fils unique, afin que quiconque croit en lui ne périsse point, mais qu'il ait la vie éternelle.
reference: Jean 3:16
```

**Verset 3 :**
```
text: L'Éternel est mon berger, je ne manquerai de rien.
reference: Psaume 23:1
```

**Verset 4 :**
```
text: Je puis tout par celui qui me fortifie.
reference: Philippiens 4:13
```

---

## Étape 3 : Collection `members`

### 3.1 Créer la collection

1. Nouvelle collection : `members`
2. Suivant

### 3.2 Ajouter le premier membre

1. ID automatique

2. **Ajouter les champs** :

   **Champ 1 :**
   - Nom : `name`
   - Type : `string`
   - Valeur : `LESCURE Maël`

   **Champ 2 :**
   - Nom : `role`
   - Type : `string`
   - Valeur : `Président de l'association`

   **Champ 3 :**
   - Nom : `photoUrl`
   - Type : `string`
   - Valeur : `https://via.placeholder.com/150`

   **Champ 4 :**
   - Nom : `order`
   - Type : `number` ⚠️ (pas string !)
   - Valeur : `1`

3. Enregistrer

### 3.3 Ajouter le deuxième membre

1. Dans la collection `members`, clique sur **"Ajouter un document"**
2. ID automatique
3. Ajoute les champs :
   ```
   name (string): KLEIN Thomas
   role (string): Vice Président
   photoUrl (string): https://via.placeholder.com/150
   order (number): 2
   ```
4. Enregistrer

### 3.4 Ajouter le troisième membre

1. Ajouter un document
2. ID automatique
3. Champs :
   ```
   name (string): Père Jean-Yves
   role (string): Aumonier de l'ICAM
   photoUrl (string): https://via.placeholder.com/150
   order (number): 3
   ```
4. Enregistrer

✅ **Tu as maintenant les 3 collections obligatoires !**

---

## Étape 4 : Tester l'application

Maintenant tu peux tester :

```bash
flutter clean
flutter pub get
flutter run
```

Tu devrais voir :
- ✅ Un saint aléatoire avec son image
- ✅ Un verset aléatoire
- ✅ Les 3 membres du BDSPIE

---

## Collections optionnelles (à faire plus tard)

### Collection `events` (pour l'agenda)

```
ID de collection: events
Document:
  - title (string): Messe de Noël
  - description (string): Célébration de la naissance du Christ
  - date (timestamp): [choisis une date future]
  - location (string): Cathédrale Notre-Dame
  - imageUrl (string): [vide pour l'instant]
```

### Collection `prayers` (pour les prières)

```
ID de collection: prayers
Document:
  - title (string): Notre Père
  - text (string): Notre Père qui es aux cieux, que ton nom soit sanctifié...
  - category (string): Prières essentielles
```

### Collection `churches` (pour la carte)

```
ID de collection: churches
Document:
  - name (string): Cathédrale Notre-Dame de Paris
  - address (string): 6 Parvis Notre-Dame, 75004 Paris
  - latitude (number): 48.853
  - longitude (number): 2.3499
  - phone (string): +33 1 42 34 56 10
  - description (string): Cathédrale emblématique
```

### Collection `faqs`

```
ID de collection: faqs
Document:
  - question (string): Quels sont les horaires des messes ?
  - answer (string): Les messes ont lieu tous les dimanches à 10h30...
  - order (number): 1
```

---

## Récapitulatif : Les 3 collections obligatoires

```
Collection: saints
└── Document (ID auto)
    ├── name (string)
    ├── imageUrl (string)
    └── description (string)

Collection: verses
└── Document (ID auto)
    ├── text (string)
    └── reference (string)

Collection: members
├── Document 1 (ID auto)
│   ├── name (string)
│   ├── role (string)
│   ├── photoUrl (string)
│   └── order (number) = 1
├── Document 2 (ID auto)
│   ├── name (string)
│   ├── role (string)
│   ├── photoUrl (string)
│   └── order (number) = 2
└── Document 3 (ID auto)
    ├── name (string)
    ├── role (string)
    ├── photoUrl (string)
    └── order (number) = 3
```

---

## Points importants

1. **Noms exacts** : Les noms de collections et de champs doivent être exactement comme indiqué (avec la même casse)
2. **Types** : Attention aux types (string vs number)
3. **ID automatique** : Toujours laisser Firebase générer l'ID automatiquement
4. **Aléatoire** : L'app choisit un saint et un verset **aléatoirement** à chaque lancement
5. **Plus de contenu = mieux** : Plus tu ajoutes de saints et versets, plus l'app sera intéressante !

---

## Astuce : Ajouter rapidement plusieurs documents

Si tu veux ajouter plein de saints ou versets :
1. Crée le premier manuellement
2. Ensuite, clique sur les `...` à côté du document
3. Copie l'ID du document
4. Clique sur "Ajouter un document"
5. Change juste les valeurs

Bon courage ! 🙏
