FROM php:8.2-apache
COPY src/ /var/www/html/

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends libfreetype6-dev libjpeg-dev libpng-dev libzip-dev unzip; \
    docker-php-ext-configure gd --with-freetype --with-jpeg; \
    docker-php-ext-install -j$(nproc) exif gd zip pdo pdo_mysql; \
    rm -rf /var/lib/apt/lists/* && \
    a2enmod rewrite

RUN echo 'upload_max_filesize = 1024M' > /usr/local/etc/php/conf.d/limits.ini
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
