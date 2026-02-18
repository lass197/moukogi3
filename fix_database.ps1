# Script PowerShell pour corriger la configuration de la base de données
# Exécutez ce script dans PowerShell ou le terminal Laragon

Write-Host "=== Configuration de la base de données ===" -ForegroundColor Cyan

# Vérifier le fichier .env
if (Test-Path .env) {
    Write-Host "✓ Fichier .env trouvé" -ForegroundColor Green
    
    # Afficher la configuration actuelle
    Write-Host "`nConfiguration actuelle de la base de données:" -ForegroundColor Yellow
    Get-Content .env | Select-String -Pattern "DB_"
    
    # Demander le nom de la base de données
    $dbName = Read-Host "`nEntrez le nom de la base de données (ou appuyez sur Entrée pour 'moukogi3')"
    if ([string]::IsNullOrWhiteSpace($dbName)) {
        $dbName = "moukogi3"
    }
    
    # Mettre à jour le fichier .env
    Write-Host "`nMise à jour de DB_DATABASE vers: $dbName" -ForegroundColor Yellow
    (Get-Content .env) -replace 'DB_DATABASE=.*', "DB_DATABASE=$dbName" | Set-Content .env
    
    Write-Host "✓ Fichier .env mis à jour" -ForegroundColor Green
    
    # Vider le cache Laravel (si PHP est disponible)
    $phpPath = "C:\laragon\bin\php\php-8.1.10-Win32-vs16-x64\php.exe"
    if (Test-Path $phpPath) {
        Write-Host "`nVidage du cache Laravel..." -ForegroundColor Yellow
        & $phpPath artisan config:clear
        & $phpPath artisan cache:clear
        Write-Host "✓ Cache vidé" -ForegroundColor Green
    } else {
        Write-Host "`n⚠ PHP non trouvé. Videz le cache manuellement avec:" -ForegroundColor Yellow
        Write-Host "  php artisan config:clear" -ForegroundColor White
        Write-Host "  php artisan cache:clear" -ForegroundColor White
    }
    
    Write-Host "`n=== Prochaines étapes ===" -ForegroundColor Cyan
    Write-Host "1. Assurez-vous que la base de données '$dbName' existe dans MySQL" -ForegroundColor White
    Write-Host "2. Si elle n'existe pas, créez-la via phpMyAdmin (http://localhost/phpmyadmin)" -ForegroundColor White
    Write-Host "3. Exécutez: php artisan migrate" -ForegroundColor White
    Write-Host "4. (Optionnel) Exécutez: php artisan db:seed" -ForegroundColor White
    
} else {
    Write-Host "✗ Fichier .env non trouvé!" -ForegroundColor Red
    Write-Host "Créez le fichier .env à partir de .env.example" -ForegroundColor Yellow
}
