#!/bin/bash
set -e

# デバッグ情報の出力
echo "Current directory: $(pwd)"
echo "List of files in current directory:"
ls -la

# アプリケーションディレクトリに移動
cd /var/www/MBTI-Diagnosis-App
echo "Changed to application directory: $(pwd)"

# Composerのインストール（もし入っていない場合）
if ! [ -x "$(command -v composer)" ]; then
  echo "Installing Composer..."
  curl -sS https://getcomposer.org/installer | php
  sudo mv composer.phar /usr/local/bin/composer
  sudo chmod +x /usr/local/bin/composer
fi

# Composerのバージョン確認
composer --version

# 環境変数の確認
echo "PATH: $PATH"
echo "Composer command location: $(which composer)"

# Composer依存関係のインストール
composer install --no-interaction --prefer-dist --optimize-autoloader

# アプリケーション全体の所有権とパーミッションの確認
chown -R ec2-user:www-data /var/www/MBTI-Diagnosis-App
chmod -R 775 /var/www/MBTI-Diagnosis-App

# 必要なディレクトリを作成し、権限を設定
mkdir -p /var/www/MBTI-Diagnosis-App/bootstrap/cache
chmod -R 775 /var/www/MBTI-Diagnosis-App/bootstrap/cache
chown -R ec2-user:www-data /var/www/MBTI-Diagnosis-App/bootstrap/cache

mkdir -p /var/www/MBTI-Diagnosis-App/storage/framework/views
chmod -R 775 /var/www/MBTI-Diagnosis-App/storage/framework/views
chown -R ec2-user:www-data /var/www/MBTI-Diagnosis-App/storage/framework/views
sudo find /var/www/MBTI-Diagnosis-App/storage/framework/views -type f -exec chmod 775 {} \;

# 権限の設定
chown -R ec2-user:www-data /var/www/MBTI-Diagnosis-App/vendor
chmod -R 755 /var/www/MBTI-Diagnosis-App/vendor

# ストレージディレクトリとキャッシュディレクトリの権限を設定
sudo chown -R ec2-user:www-data /var/www/MBTI-Diagnosis-App/storage
sudo chmod -R 775 /var/www/MBTI-Diagnosis-App/storage

chown -R ec2-user:www-data /var/www/MBTI-Diagnosis-App/database
chmod -R 775 /var/www/MBTI-Diagnosis-App/database

# キャッシュのクリア
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

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

sudo systemctl restart nginx
sudo systemctl restart php-fpm

# アプリケーション全体の最適化
php artisan optimize

echo "Deployment completed successfully!"