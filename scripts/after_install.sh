#!/bin/bash

LOGFILE="/var/www/MBTI-Diagnosis-App/deploy.log"

echo "Starting deployment at $(date)" >> $LOGFILE

# デプロイディレクトリに移動
cd /var/www/MBTI-Diagnosis-App
echo "Moved to deployment directory" >> $LOGFILE

# Composerの依存関係をインストール
composer install --no-interaction --no-dev --prefer-dist >> $LOGFILE 2>&1
echo "Composer install completed" >> $LOGFILE

# アプリケーション全体の所有権とパーミッションの確認
sudo chown -R ec2-user:nginx /var/www/MBTI-Diagnosis-App
sudo chmod -R 775 /var/www/MBTI-Diagnosis-App
echo "Ownership and permissions set" >> $LOGFILE

# 必要なディレクトリを作成し、権限を設定
mkdir -p bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache
sudo chown -R ec2-user:nginx storage bootstrap/cache
echo "Directories created and permissions set" >> $LOGFILE

sudo touch /var/www/MBTI-Diagnosis-App/storage/logs/laravel.log
sudo chown ec2-user:nginx /var/www/MBTI-Diagnosis-App/storage/logs/laravel.log
sudo chmod 664 /var/www/MBTI-Diagnosis-App/storage/logs/laravel.log

sudo mkdir -p /var/www/MBTI-Diagnosis-App/storage/logs
sudo chown -R ec2-user:nginx /var/www/MBTI-Diagnosis-App/storage
sudo chmod -R 775 /var/www/MBTI-Diagnosis-App/storage

mkdir -p /var/www/MBTI-Diagnosis-App/vendor
sudo chmod -R 775 /var/www/MBTI-Diagnosis-App/vendor
sudo chown -R ec2-user:nginx /var/www/MBTI-Diagnosis-App/vendor

touch /var/www/MBTI-Diagnosis-App/database/database.sqlite
chmod 664 /var/www/MBTI-Diagnosis-App/database/database.sqlite
chown ec2-user:nginx /var/www/MBTI-Diagnosis-App/database/database.sqlite

php artisan migrate

# vendor フォルダの存在を確認
if [ -d "vendor" ]; then
  echo "Vendor directory exists before cache clear" >> $LOGFILE
else
  echo "Vendor directory does NOT exist before cache clear" >> $LOGFILE
fi

# キャッシュのクリア
php artisan config:clear
php artisan cache:clear
php artisan route:clear
echo "Cache cleared" >> $LOGFILE

# 再度、vendor フォルダの存在を確認
if [ -d "vendor" ]; then
  echo "Vendor directory exists after cache clear" >> $LOGFILE
else
  echo "Vendor directory does NOT exist after cache clear" >> $LOGFILE
fi

# キャッシュのリロード
php artisan config:cache
php artisan route:cache
php artisan view:cache
echo "Cache reloaded" >> $LOGFILE

# シンボリックリンクの作成
php artisan storage:link
echo "Storage link created" >> $LOGFILE

# 設定のキャッシュ
php artisan config:cache
php artisan route:cache
echo "Config and route cache completed" >> $LOGFILE

sudo systemctl restart php-fpm
sudo systemctl restart nginx

# アプリケーション全体の最適化
php artisan optimize
echo "Application optimized" >> $LOGFILE

echo "Deployment finished at $(date)" >> $LOGFILE
