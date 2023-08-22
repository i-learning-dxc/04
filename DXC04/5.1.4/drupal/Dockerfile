FROM drupal:9.5.0-php8.1-apache-bullseye

# Drushインストール
RUN composer require drush/drush && drush --version

#  初回起動時にDrupalをインストールする⽤のshellを配置
COPY docker-entrypoint.sh /tmp
RUN sed -i 's/\r//g' /tmp/docker-entrypoint.sh

