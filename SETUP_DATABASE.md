# Configuration de la Base de Données

## Problème
L'erreur `Unknown database 'laravel'` signifie que Laravel essaie de se connecter à une base de données qui n'existe pas.

## Solution

### Étape 1 : Créer la base de données

**Option A : Via phpMyAdmin (Recommandé avec Laragon)**
1. Ouvrez votre navigateur et allez sur `http://localhost/phpmyadmin`
2. Cliquez sur "Nouvelle base de données" (ou "New")
3. Nommez-la : `moukogi3`
4. Choisissez l'encodage : `utf8mb4_unicode_ci`
5. Cliquez sur "Créer"

**Option B : Via MySQL en ligne de commande**
```sql
CREATE DATABASE IF NOT EXISTS `moukogi3` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### Étape 2 : Configurer le fichier .env

Ouvrez le fichier `.env` à la racine du projet et modifiez ces lignes :

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=moukogi3
DB_USERNAME=root
DB_PASSWORD=
```

**Important :** Remplacez `moukogi3` par le nom de votre base de données si vous en avez choisi un autre.

### Étape 3 : Exécuter les migrations

Dans le terminal Laragon (ou PowerShell), exécutez :

```bash
php artisan migrate
```

### Étape 4 : Remplir avec des données de test (optionnel)

```bash
php artisan db:seed
```

## Vérification

Après ces étapes, vous devriez pouvoir :
- Vous connecter à l'application
- Voir les tables dans phpMyAdmin
- Utiliser toutes les fonctionnalités

## Comptes de test (après db:seed)

- **Admin** : admin@example.com / password
- **Gestionnaire** : gestionnaire@example.com / password
- **Observateur** : observateur@example.com / password
