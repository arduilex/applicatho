# Script de configuration Firebase pour Applicatho
# Ce script va te guider pour configurer Firebase

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Configuration Firebase - Applicatho" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Etape 1: Aller sur Firebase Console" -ForegroundColor Yellow
Write-Host "1. Ouvre ton navigateur" -ForegroundColor White
Write-Host "2. Va sur: https://console.firebase.google.com" -ForegroundColor White
Write-Host "3. Selectionne ton projet" -ForegroundColor White
Write-Host "4. Clique sur Parametres (roue dentee) > Parametres du projet" -ForegroundColor White
Write-Host "5. Descends jusqu'a 'Vos applications'" -ForegroundColor White
Write-Host ""

Write-Host "Etape 2: Ajouter l'app Web (si pas deja fait)" -ForegroundColor Yellow
Write-Host "1. Clique sur l'icone </> (Web)" -ForegroundColor White
Write-Host "2. Nom: Applicatho Web" -ForegroundColor White
Write-Host "3. NE COCHE PAS Firebase Hosting" -ForegroundColor White
Write-Host "4. Enregistrer l'app" -ForegroundColor White
Write-Host ""

Write-Host "Etape 3: Copier ta configuration" -ForegroundColor Yellow
Write-Host "Tu vas voir un code JavaScript comme ca:" -ForegroundColor White
Write-Host ""
Write-Host "const firebaseConfig = {" -ForegroundColor Gray
Write-Host '  apiKey: "AIzaSy...",' -ForegroundColor Gray
Write-Host '  authDomain: "ton-projet.firebaseapp.com",' -ForegroundColor Gray
Write-Host '  projectId: "ton-projet",' -ForegroundColor Gray
Write-Host "  ..." -ForegroundColor Gray
Write-Host "};" -ForegroundColor Gray
Write-Host ""

Write-Host "Maintenant, entre les valeurs UNE PAR UNE:" -ForegroundColor Green
Write-Host ""

# Demander les valeurs
$apiKey = Read-Host "apiKey (commence par AIzaSy...)"
$authDomain = Read-Host "authDomain (ex: applicatho-xxxxx.firebaseapp.com)"
$projectId = Read-Host "projectId (ex: applicatho-xxxxx)"
$storageBucket = Read-Host "storageBucket (ex: applicatho-xxxxx.appspot.com)"
$messagingSenderId = Read-Host "messagingSenderId (des chiffres)"
$appId = Read-Host "appId (ex: 1:123456:web:abc...)"

Write-Host ""
Write-Host "Verification de ta configuration:" -ForegroundColor Yellow
Write-Host "apiKey: $apiKey" -ForegroundColor White
Write-Host "authDomain: $authDomain" -ForegroundColor White
Write-Host "projectId: $projectId" -ForegroundColor White
Write-Host "storageBucket: $storageBucket" -ForegroundColor White
Write-Host "messagingSenderId: $messagingSenderId" -ForegroundColor White
Write-Host "appId: $appId" -ForegroundColor White
Write-Host ""

$confirm = Read-Host "Est-ce correct? (o/n)"

if ($confirm -eq "o" -or $confirm -eq "O") {
    # Lire le fichier firebase_options.dart
    $filePath = "lib\firebase_options.dart"
    $content = Get-Content $filePath -Raw

    # Remplacer les valeurs
    $content = $content -replace "apiKey: 'VOTRE_API_KEY_WEB'", "apiKey: '$apiKey'"
    $content = $content -replace "appId: 'VOTRE_APP_ID_WEB'", "appId: '$appId'"
    $content = $content -replace "messagingSenderId: 'VOTRE_SENDER_ID'", "messagingSenderId: '$messagingSenderId'"
    $content = $content -replace "projectId: 'VOTRE_PROJECT_ID'", "projectId: '$projectId'"
    $content = $content -replace "authDomain: 'VOTRE_PROJECT_ID.firebaseapp.com'", "authDomain: '$authDomain'"
    $content = $content -replace "storageBucket: 'VOTRE_PROJECT_ID.appspot.com'", "storageBucket: '$storageBucket'"

    # Sauvegarder
    Set-Content -Path $filePath -Value $content

    Write-Host ""
    Write-Host "Configuration sauvegardee avec succes!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Maintenant, lance l'application:" -ForegroundColor Yellow
    Write-Host "flutter run -d chrome" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host "Configuration annulee. Relance le script pour recommencer." -ForegroundColor Red
}

Write-Host ""
Write-Host "Appuie sur une touche pour fermer..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
