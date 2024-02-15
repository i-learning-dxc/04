FROM drupal:10.2.3-php8.3-apache-bullseye

# Drushインストール
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer require drush/drush && drush --version

#  初回起動時にDrupalをインストールする⽤のshellを配置
COPY docker-entrypoint.sh /tmp
RUN sed -i 's/\r//g' /tmp/docker-entrypoint.sh

