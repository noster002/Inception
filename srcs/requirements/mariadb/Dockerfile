FROM		alpine:3.16

RUN			apk add --no-cache mariadb mariadb-client

COPY		tools/setup_mariadb.sh /tmp/setup_mariadb.sh

RUN			chmod +x /tmp/setup_mariadb.sh

ENTRYPOINT	["/tmp/setup_mariadb.sh"]

CMD			["/usr/bin/mysqld", "--user=mysql"]
