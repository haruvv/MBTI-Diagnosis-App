FROM php:8.3-fpm

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y     git     curl     libpng-dev     libonig-dev     libxml2-dev     zip     unzip

# PHP拡張のインストール
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Composerのインストール
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

COPY . .

RUN composer install

CMD php artisan serve --host=0.0.0.0 --port=8000
