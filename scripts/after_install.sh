#!/bin/bash

# デプロイディレクトリに移動
cd /var/www/MBTI-Diagnosis-App

# 必要なディレクトリを作成し、権限を設定
mkdir -p bootstrap/cache
chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache

# ここにその他の設定やコマンドを続けます


# 必要なディレクトリを作成し、権限を設定
mkdir -p bootstrap/cache
chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache

# COMPOSER_ALLOW_SUPERUSERを設定してComposerを実行
export COMPOSER_ALLOW_SUPERUSER=1
composer install --no-interaction --no-dev --prefer-dist

# 環境設定
cp .env.example .env
php artisan key:generate

# データベースマイグレーション（必要な場合）
php artisan migrate --force

# キャッシュのクリア
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

# ストレージディレクトリのパーミッション設定
chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache

# シンボリックリンクの作成
php artisan storage:link

# 設定のキャッシュ
php artisan config:cache

# ルートのキャッシュ
php artisan route:cache

# ビューのキャッシュ
php artisan view:cache

# Composerのオートロードを最適化
composer dump-autoload --optimize

# アプリケーション全体の最適化
php artisan optimize
