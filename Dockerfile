FROM composer/composer:php7 as composer

# Install composer
WORKDIR /tmp/build

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer

COPY ./ /tmp/build
RUN composer install --no-scripts --no-autoloader
RUN composer dump-autoload --optimize

FROM node:6 as node

WORKDIR /tmp/build

COPY --from=composer /tmp/build /tmp/build

RUN npm install -g gulp && \
    npm install && \
    gulp compile

FROM wordpress

COPY --from=node /tmp/build/dist /tmp/build/dist
COPY start.sh /usr/local/bin/start.sh

# Expose a port to run on
EXPOSE 80

CMD ["/usr/local/bin/start.sh"]
