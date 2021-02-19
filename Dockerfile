FROM php:8-fpm

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends libfreetype6-dev libjpeg-dev libpng-dev libzip-dev unzip; \
    docker-php-ext-configure gd --with-freetype --with-jpeg; \
    docker-php-ext-install -j$(nproc) exif gd zip; \
    rm -rf /var/lib/apt/lists/*

RUN echo 'upload_max_filesize = 1024M' > /usr/local/etc/php/conf.d/limits.ini
