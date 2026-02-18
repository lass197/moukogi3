# Instructions pour corriger l'erreur de base de données

## ✅ Ce qui a été fait
Le fichier `.env` a été mis à jour pour utiliser `DB_DATABASE=moukogi3` au lieu de `laravel`.

## 📋 Étapes à suivre maintenant

### 1. Vérifier que la base de données existe

**Via phpMyAdmin (Recommandé avec Laragon):**
1. Ouvrez votre navigateur : `http://localhost/phpmyadmin`
2. Dans la liste à gauche, vérifiez si `moukogi3` existe
3. Si elle n'existe pas :
   - Cliquez sur "Nouvelle base de données"
   - Nom : `moukogi3`
   - Encodage : `utf8mb4_unicode_ci`
   - Cliquez sur "Créer"

**Via MySQL en ligne de commande:**
```sql
CREATE DATABASE IF NOT EXISTS `moukogi3` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 2. Vider le cache Laravel

Dans le **terminal Laragon** (ou PowerShell avec PHP dans le PATH), exécutez :

```bash
php artisan config:clear
php artisan cache:clear
```

**Note:** Si `php` n'est pas reconnu, utilisez le terminal intégré de Laragon qui a PHP dans le PATH.

### 3. Vérifier la configuration

Vérifiez que votre fichier `.env` contient bien :

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=moukogi3
DB_USERNAME=root
DB_PASSWORD=
```

### 4. Exécuter les migrations

```bash
php artisan migrate
```

### 5. (Optionnel) Remplir avec des données de test

```bash
php artisan db:seed
```

## 🔍 Vérification

Après ces étapes, testez à nouveau l'application. L'erreur devrait être résolue.

## ⚠️ Si l'erreur persiste

1. **Vérifiez que MySQL est démarré** dans Laragon
2. **Vérifiez les identifiants MySQL** dans `.env` (username/password)
3. **Vérifiez que la base de données existe** dans phpMyAdmin
4. **Videz tous les caches** :
   ```bash
   php artisan config:clear
   php artisan cache:clear
   php artisan route:clear
   php artisan view:clear
   ```

## 📝 Script automatique

Un script PowerShell `fix_database.ps1` a été créé pour vous aider. Exécutez-le dans PowerShell :

```powershell
.\fix_database.ps1
```
