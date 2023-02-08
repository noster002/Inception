#!/bin/sh

if [ -f ./wordpress/wp-config-sample.php ]; then
	echo 'Wordpress already installed'
	echo 'Skipping download...'
else
	echo 'Downloading Wordpress...'

	wget https://wordpress.org/latest.tar.gz > /dev/null
	tar -xzvf /var/www/html/latest.tar.gz > /dev/null
	rm -f latest.tar.gz
	chown -R www-data:www-data wordpress

	echo 'Download successful'
fi

if [ -f ./wordpress/wp-config.php ]; then
	echo 'Wordpress already initialized'
	echo 'Skipping configuration...'
else
	echo 'Creating wp-config.php...'

	sed -i "s/database_name_here/$MYSQL_DATABASE/g" ./wordpress/wp-config-sample.php
	sed -i "s/username_here/$MYSQL_USER/g" ./wordpress/wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" ./wordpress/wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" ./wordpress/wp-config-sample.php
	cp ./wordpress/wp-config-sample.php ./wordpress/wp-config.php
fi

echo 'Starting /usr/sbin/php-fpm8 process in foreground'

exec "$@"
