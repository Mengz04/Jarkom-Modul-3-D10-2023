apt-get update

apt-get install mariadb-server -y

service mysql start

mysql <<EOF
CREATE USER 'kelompokd10'@'%' IDENTIFIED BY 'passwordd10';
CREATE USER 'kelompokd10'@'localhost' IDENTIFIED BY 'passwordd10';
CREATE DATABASE dbkelompokd10;
GRANT ALL PRIVILEGES ON *.* TO 'kelompokd10'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompokd10'@'localhost';
FLUSH PRIVILEGES;
EOF

echo '
[client-server]

!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mariadb.conf.d/

[mysqld]
skip-networking=0
skip-bind-address
' > /etc/mysql/my.cnf

echo '
[server]

[mysqld]

user                    = mysql
pid-file                = /run/mysqld/mysqld.pid
socket                  = /run/mysqld/mysqld.sock
#port                   = 3306
basedir                 = /usr
datadir                 = /var/lib/mysql
tmpdir                  = /tmp
lc-messages-dir         = /usr/share/mysql
#skip-external-locking

# Instead of skip-networking the default is now to listen only on
# localhost which is more compatible and is not less secure.
bind-address            = 0.0.0.0

query_cache_size        = 16M

log_error = /var/log/mysql/error.log

expire_logs_days        = 10

character-set-server  = utf8mb4
collation-server      = utf8mb4_general_ci

[embedded]

[mariadb]

[mariadb-10.3]
' > /etc/mysql/mariadb.conf.d/50-server.cnf

service mysql restart

