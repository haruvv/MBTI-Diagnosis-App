#!/bin/bash

# デプロイディレクトリに移動
cd /var/www/MBTI-Diagnosis-App

# Composerの依存関係をインストール
composer install --no-interaction --no-dev --prefer-dist

# アプリケーション全体の所有権とパーミッションの確認
sudo chown -R ec2-user:www-data /var/www/MBTI-Diagnosis-App
sudo chmod -R 775 /var/www/MBTI-Diagnosis-App

# 必要なディレクトリを作成し、権限を設定
mkdir -p bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache
sudo chown -R ec2-user:www-data storage bootstrap/cache

# キャッシュのクリア
php artisan config:clear
php artisan cache:clear
php artisan route:clear

# キャッシュのリロード
php artisan config:cache
php artisan route:cache
php artisan view:cache

# シンボリックリンクの作成
php artisan storage:link

# 設定のキャッシュ
php artisan config:cache

# ルートのキャッシュ
php artisan route:cache

# アプリケーション全体の最適化
php artisan optimize
