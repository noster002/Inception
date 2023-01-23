#!/bin/sh

mysql_install_db

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then
	/usr/bin/mysqld --bootstrap < /tmp/setup_db.sql
	rm -f /tmp/setup_db.sql
fi

exec "$@"
