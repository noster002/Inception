#!/bin/sh

if [ ! -d "/var/www/html/wordpress/wp-config.php" ]
then
	wget -P /var/www/html https://wordpress.org/latest.tar.gz
	tar -C /var/www/html -xzvf /var/www/html/latest.tar.gz
	rm -f /var/www/html/latest.tar.gz
	chown -R nginx:nginx /var/www/html/wordpress

	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php
fi

exec "$@"
