FROM php:8.1-fpm

LABEL maintainer="facturadorpro"

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    wget \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libxml2-dev \
    libonig-dev \
    libgmp-dev \
    libicu-dev \
    tesseract-ocr \
    ghostscript \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# PHP Extensions requeridas por el proyecto
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo \
        pdo_mysql \
        mysqli \
        mbstring \
        exif \
        pcntl \
        bcmath \
        gd \
        zip \
        intl \
        gmp \
        xml \
        soap \
        opcache \
        calendar

# Redis PHP extension
RUN pecl install redis \
    && docker-php-ext-enable redis

# Composer (version 2)
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Entrypoint de arranque
COPY docker/php/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/html

# Copy only composer files first (cache layer)
COPY composer.json composer.lock ./

# Install PHP dependencies
RUN composer install --no-autoloader --no-interaction --no-scripts --no-dev --prefer-dist --ignore-platform-reqs

# Copy remaining project files
COPY . .

# Crear directorios necesarios antes de composer scripts
RUN mkdir -p storage/framework/{sessions,views,cache} \
             storage/logs \
             bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Run composer scripts (autoload, package:discover, etc.)
# --no-scripts evita que artisan package:discover corra en build time
# (no hay .env disponible durante el build — el entrypoint lo corre en runtime)
RUN composer dump-autoload --optimize --no-scripts \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm"]
