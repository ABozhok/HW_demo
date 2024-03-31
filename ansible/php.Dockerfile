FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libxml2-dev \
    libonig-dev \
    default-mysql-client \
    && docker-php-ext-install \
    pdo_mysql \
    zip \
    mbstring \
    xml

# Видаляємо рядок з інсталяцією Composer останньої версії
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Додаємо команди для встановлення конкретної версії Composer
RUN curl -o /usr/local/bin/composer https://getcomposer.org/download/2.7.1/composer.phar \
    && echo "1ffd0be3f27e237b1ae47f9e8f29f96ac7f50a0bd9eef4f88cdbe94dd04bfff0  /usr/local/bin/composer" | sha256sum -c - \
    && chmod +x /usr/local/bin/composer

RUN useradd -m demo

RUN mkdir -p /var/www/demo && chown demo:demo /var/www/demo

WORKDIR /var/www/demo

COPY --chown=demo:demo app/demo/ /var/www/demo

USER demo

RUN composer install --no-interaction

COPY --chown=demo:demo www.conf /usr/local/etc/php-fpm.d/

EXPOSE 9000