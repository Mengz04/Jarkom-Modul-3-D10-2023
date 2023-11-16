apt-get update

apt-get install nginx -y

apt-get install htop -y

apt-get install apache2-utils -y

mkdir /etc/nginx/rahasiakita

echo 'netics:$apr1$6mMkZqDC$BqIpSPJBrWjAVIGiOGKkU1' > /etc/nginx/rahasiakita/.htpasswd

echo '
upstream backend  {
    server 192.196.3.1 weight=4; #IP Lugner
    server 192.196.3.2 weight=2; #IP Linie
    server 192.196.3.3 weight=1; #IP Lawine
}

server {
    listen 80;
    server_name granz.channel.d10.com;

    location / {
        allow 192.196.3.69;
        allow 192.196.3.70;
        allow 192.196.4.167;
        allow 192.196.4.168;
        deny all;

        proxy_pass http://backend;
        proxy_set_header    X-Real-IP $remote_addr;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    Host $http_host;

        auth_basic "Administrator'\''s Area";
        auth_basic_user_file /etc/nginx/rahasiakita/.htpasswd;
    }

    location ~ /\.ht {
        deny all;
    }

    location /its {
        allow 192.196.3.69;
        allow 192.196.3.70;
        allow 192.196.4.167;
        allow 192.196.4.168;
        deny all;
        
        proxy_pass https://www.its.ac.id;

        auth_basic "Administrator'\''s Area";
        auth_basic_user_file /etc/nginx/rahasiakita/.htpasswd;
    }

    error_log /var/log/nginx/lb_error.log;
    access_log /var/log/nginx/lb_access.log;

}
' > /etc/nginx/sites-available/lb-granz.channel.d10

echo '
upstream backendriegel {
    least_conn;
    server 192.196.4.1:8001; #IP Fern
    server 192.196.4.2:8002; #IP Flamme
    server 192.196.4.3:8003; #IP Frieren
}

server {
    listen 81;
    server_name riegel.canyon.d10.com;

    location / {
        proxy_bind 192.196.2.2;

        proxy_pass http://backendriegel;
        proxy_set_header    X-Real-IP $remote_addr;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    Host $http_host;
    }  

    error_log /var/log/nginx/lb_error.log;
    access_log /var/log/nginx/lb_access.log;

}
' > /etc/nginx/sites-available/lb-riegel.canyon.d10

unlink /etc/nginx/sites-enabled/default

ln -s /etc/nginx/sites-available/lb-granz.channel.d10 /etc/nginx/sites-enabled

ln -s /etc/nginx/sites-available/lb-riegel.canyon.d10 /etc/nginx/sites-enabled

service nginx restart