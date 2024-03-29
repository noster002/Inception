#!/bin/sh

if [ ! -d /run/mysqld ]
then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
	echo 'MySQL already initialized'
else
	echo 'Initializing MySQL...'

	mkdir -p /var/lib/mysql
	chown -R mysql:mysql /var/lib/mysql

	mysql_install_db --user=mysql --datadir=/var/lib/mysql

	echo 'Initialization successful'
fi

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
	echo "MySQL database: $MYSQL_DATABASE already set up"
else
	echo "Setting up MySQL database: $MYSQL_DATABASE"

	echo "Changing MySQL root password to: $MYSQL_ROOT_PASSWORD"
	
	tempfile=`mktemp`
	if [ ! -f "$tempfile" ]; then
		return 1
	fi

	echo "Creating tempfile: $tempfile"
	cat << EOF > $tempfile
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE user='' AND db LIKE 'test%';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
EOF

	echo "Creating database: $MYSQL_DATABASE"
	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" >> $tempfile

	echo "Creating user: $MYSQL_USER with password: $MYSQL_PASSWORD"
	echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tempfile

	echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';" >> $tempfile

	echo "FLUSH PRIVILEGES;" >> $tempfile

	echo "Applying changes by running tempfile: $tempfile in bootstrap mode"
	/usr/bin/mysqld --user=mysql --bootstrap < $tempfile
	rm -f $tempfile
fi

sed -i "s/skip-networking/#skip-networking/g" /etc/my.cnf.d/mariadb-server.cnf
echo "[mysqld]\nbind-address=0.0.0.0" >> /etc/my.cnf.d/mariadb-server.cnf

sleep 5

echo 'Starting /usr/bin/mysqld process'
exec "$@"
