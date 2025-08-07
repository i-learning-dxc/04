FROM drupal:10.2.3-php8.3-apache-bullseye

# Drushインストール
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer require drush/drush && drush --version

# 初回起動時にDrupalをインストールする用のshellを配置
COPY docker-entrypoint.sh /tmp
RUN sed -i 's/\r//g' /tmp/docker-entrypoint.sh && \
    chmod +x /tmp/docker-entrypoint.sh

# 必要なディレクトリを事前に作成（オプション）
RUN mkdir -p /var/www/html/sites/default/files && \
    chown -R www-data:www-data /var/www/html/sites/default
