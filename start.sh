#!/bin/bash
curl -o /usr/local/bin/wp-cli.phar -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x /usr/local/bin/wp-cli.phar
/usr/local/bin/wp-cli.phar core download --allow-root --force --skip-content
mkdir -p /var/www/html/wp-content/themes/kacper
cp -a /tmp/build/dist/* /var/www/html/wp-content/themes/kacper
apache2-foreground
