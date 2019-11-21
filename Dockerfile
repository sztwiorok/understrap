FROM composer/composer:php7 as composer

# Install composer
WORKDIR /var/www/html/wp-content

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer

COPY composer.json /var/www/html/wp-content
# COPY composer.lock ./
RUN composer install --no-scripts --no-autoloader
# COPY ./ /var/www/
RUN composer dump-autoload --optimize

FROM wordpress

COPY --from=build /var/www/html/wp-content /var/www/html/wp-content

# Expose a port to run on
EXPOSE 80
