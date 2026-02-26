FROM php:8.2-fpm-alpine

# Installation des dépendances système et extensions PHP pour MySQL
RUN apk add --no-cache \
    zip libzip-dev libpng-dev icu-dev \
    nginx supervisor ca-certificates

RUN docker-php-ext-install pdo_mysql gd zip intl

WORKDIR /var/www/html
COPY . .

# Installation de Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev --optimize-autoloader

# Droits pour Laravel
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 10000
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=10000"]
