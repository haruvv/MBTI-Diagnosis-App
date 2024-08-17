#!/bin/bash
cd /var/www/MBTI-Diagnosis-App

# 必要な依存関係のインストールや設定
# 例: composer install, npm install など

# アプリケーションの再起動やキャッシュのクリアなど
    sudo systemctl restart php-fpm
    sudo systemctl restart nginx