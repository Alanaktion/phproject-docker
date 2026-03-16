FROM docker.io/library/php:8.4-fpm

COPY --from=ghcr.io/mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions exif gd zip pdo_mysql intl xdebug

RUN echo 'upload_max_filesize = 1024M' > /usr/local/etc/php/conf.d/limits.ini
