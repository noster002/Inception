FROM		alpine:3.16

RUN			adduser -S -G www-data www-data && \
			apk add --no-cache wget tar mariadb-client php8-fpm && \
			mkdir -p /var/www/html && \
			rm -rf /etc/php8/php-fpm.d/*

COPY		conf/www.conf /etc/php8/php-fpm.d/www.conf
COPY		tools/setup_wordpress.sh /tmp/setup_wordpress.sh

RUN			chmod +x /tmp/setup_wordpress.sh

WORKDIR		/var/www/html/

ENTRYPOINT	["/tmp/setup_wordpress.sh"]

CMD			["/usr/sbin/php-fpm8", "-F"]
