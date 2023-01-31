#!/bin/sh

if [ ! -d "/var/www/html/wordpress/wp-config.php" ]
then
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf /var/www/html/latest.tar.gz
	rm -f latest.tar.gz
	chown -R www-data:www-data wordpress

	sed -i "s/database_name_here/$MYSQL_DATABASE/g" ./wordpress/wp-config-sample.php
	sed -i "s/username_here/$MYSQL_USER/g" ./wordpress/wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" ./wordpress/wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" ./wordpress/wp-config-sample.php
	cp ./wordpress/wp-config-sample.php ./wordpress/wp-config.php
fi

exec "$@"
