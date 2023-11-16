apt-get update

apt-get install nginx -y

apt-get install php -y

apt-get install php-fpm -y

apt-get install wget -y

apt-get install unzip -y

apt-get install htop -y

php -v

wget -O /var/www/granz.channel.yyy.com.zip "https://drive.google.com/u/0/uc?id=1ViSkRq7SmwZgdK64eRbr5Fm1EGCTPrU1&export=download"

unzip -d /var/www /var/www/granz.channel.yyy.com.zip && rm /var/www/granz.channel.yyy.com.zip

mv /var/www/modul-3 /var/www/granz.channel.d10


echo '
server {

 	listen 80;

 	root /var/www/granz.channel.d10;

 	index index.php index.html index.htm;
 	server_name granz.channel.d10.com;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
 	}

 location ~ /\.ht {
 			deny all;
 	}

    error_log /var/log/nginx/granz.channel_error.log;
 	access_log /var/log/nginx/granz.channel_access.log;

 }' > /etc/nginx/sites-available/granz.channel.d10

ln -s /etc/nginx/sites-available/granz.channel.d10 /etc/nginx/sites-enabled

service php7.3-fpm start

service php7.3-fpm restart

rm -rf /etc/nginx/sites-enabled/default

service nginx restart

nginx -t