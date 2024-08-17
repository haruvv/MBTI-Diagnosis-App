#!/bin/bash
cd /var/www/MBTI-Diagnosis-App/backend

# Composerの依存関係をインストール
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

# アプリケーション全体の最適化（上記のコマンドを含む）
php artisan optimize