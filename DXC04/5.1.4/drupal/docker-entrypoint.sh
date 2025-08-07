#!/bin/sh
# 初回起動時Drupalインストールを走らせる
if [ ! -d "/tmp/check" ]; then
    mkdir /tmp/check
    
    # 必要なディレクトリを作成し、適切な権限を設定
    mkdir -p /opt/drupal/web/sites/default/files/translations/
    mkdir -p /var/www/html/sites/default/files
    
    # settings.phpファイルを準備
    if [ ! -f "/var/www/html/sites/default/settings.php" ]; then
        cp /var/www/html/sites/default/default.settings.php /var/www/html/sites/default/settings.php
    fi
    
    # 権限設定（Apacheユーザーwww-dataに書き込み権限を付与）
    chown -R www-data:www-data /var/www/html/sites/default/files
    chown -R www-data:www-data /var/www/html/sites/default
    chmod -R 755 /var/www/html/sites/default/files
    chmod 644 /var/www/html/sites/default/settings.php
    
    # 翻訳ファイルのダウンロード
    curl https://ftp.drupal.org/files/translations/all/drupal/drupal-${DRUPAL_VERSION}.ja.po \
        -o /opt/drupal/web/sites/default/files/translations/drupal-${DRUPAL_VERSION}.ja.po
    
    # MariaDBが起動するまで待機
    sleep 30s
    
    # Drupalインストール実行
    drush si -y ${PROFILE} \
        --account-name="admin" --account-pass="admin" --account-mail="example@example.com" \
        --db-url="mysql://root:password@mariadb:3306/drupal" \
        --site-mail="example@example.com" --site-name="Drupal Test" \
        --locale="ja"
    
    # UUID設定
    drush config-set system.site uuid e707291e-7532-46d1-822c-0983cb676f8d
    drush config-set language.entity.ja uuid 0a2ddbab-8662-4d8a-bc0b-e20dd875e041

    # 設定の読み込み/出力
    if [ -f "/opt/drupal/config/system.site.yml" ]; then
        # configのymlファイルが出力されているなら取り込む
        drush cim -y
    else
        # 出力されてないなら出力しておく
        drush cex -y
    fi
    
    # インストール後の権限調整
    chown -R www-data:www-data /var/www/html/sites/default/files
    chmod 444 /var/www/html/sites/default/settings.php
fi

exec "$@"
