FROM		alpine:3.16

RUN			apk add --no-cache mariadb && \
			mkdir -p /var/lib/mysql && \
			chown -R mysql:mysql /var/lib/mysql && \
			rm -rf /etc/my.cnf.d/*

COPY		conf/mysqld.cnf /etc/my.cnf.d/mysqld.conf
COPY		conf/setup_db.sql /tmp/setup_db.sql
COPY		tools/setup_mariadb.sh /tmp/setup_mariadb.sh

RUN			chmod +x /tmp/setup_mariadb.sh

ENTRYPOINT	["/tmp/setup_mariadb.sh"]

CMD			["/usr/bin/mysqld", "-F"]
