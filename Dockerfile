# 1. Utilisation de PHP avec Alpine pour la légèreté
FROM php:8.2-fpm-alpine

# 2. Installation des dépendances système et des certificats (pour Aiven)
RUN apk add --no-cache \
    zip libzip-dev libpng-dev icu-dev \
    nodejs npm ca-certificates

# 3. Installation des extensions PHP nécessaires
RUN docker-php-ext-install pdo_mysql gd zip intl

WORKDIR /var/www/html
COPY . .

# 4. Installation de Composer et des dépendances PHP
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev --optimize-autoloader --no-interaction --ignore-platform-reqs

# 5. --- LA PARTIE MANQUANTE : VITE ---
# Installation des packages JS et compilation des assets
RUN npm install
RUN npm run build

# 6. Gestion des permissions pour Laravel
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# 7. Lancement de l'application
EXPOSE 10000
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=10000"]
