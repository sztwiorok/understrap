#!/usr/bin/env bash

cp -a /tmp/build/dist/ /var/www/html/wp-content/themes/kacper/
apache2-foreground
