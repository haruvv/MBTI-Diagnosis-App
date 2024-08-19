#!/bin/bash
# 既存のファイルをバックアップ（オプション）
# if [ -d "/var/www/MBTI-Diagnosis-App" ]; then
#   sudo mv /var/www/MBTI-Diagnosis-App /var/www/MBTI-Diagnosis-App_backup_$(date +%Y%m%d_%H%M%S)
# fi

rm -rf /var/www/MBTI-Diagnosis-App/.editorconfig
rm -rf /var/www/MBTI-Diagnosis-App/*

# デプロイ先ディレクトリの作成
# sudo mkdir -p /var/www/MBTI-Diagnosis-App
# sudo chown -R ec2-user:ec2-user /var/www/MBTI-Diagnosis-App