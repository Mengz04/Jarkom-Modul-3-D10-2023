# Jarkom-Modul-3-D10-2023

| Nama | NRP |
| ------- | ------- |
| Muhammad Rafi Insan Fillah | 5025211169  |
| Ken Anargya Alkausar | 5025211168  |

### Topologi
![WhatsApp Image 2023-11-14 at 18 05 03_2b682218](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/a47fdeb8-6f22-4c35-a6eb-fe6b872d296b)

#### **Aura** (DHCP Relay)
```
auto eth0
iface eth0 inet dhcp
up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.196.0.0/16

auto eth1
iface eth1 inet static
	address 192.196.1.0
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.196.2.0
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 192.196.3.0
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 192.196.4.0
	netmask 255.255.255.0
```

#### **Himmel** (DHCP Server)
```
auto eth0
iface eth0 inet static
	address 192.196.1.1
	netmask 255.255.255.0
	gateway 192.196.1.0
```

#### Heiter (DNS Server)
```
auto eth0
iface eth0 inet static
	address 192.196.1.2
	netmask 255.255.255.0
	gateway 192.196.1.0
```

#### Denken (Database Server)
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 3e:2d:4f:bf:9f:ad
```

#### Eisen (Load Balancer)
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 6e:76:17:d0:27:e8
```

#### Lugner (PHP Worker)
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 7a:9b:02:ec:b3:ba
```

#### Linie (PHP Worker)
```
auto eth0
iface eth0 inet dhcp
hwaddress ether ee:e7:0b:68:0d:b0
```

#### Lawine (PHP Worker)
```
auto eth0
iface eth0 inet dhcp
hwaddress ether ea:f6:65:34:86:39
```
#### Freiren (Laravel Worker)
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 22:6a:39:35:bf:00
```

#### Flamme (Laravel Worker)
```
auto eth0
iface eth0 inet dhcp
hwaddress ether e6:fa:f8:05:b9:39
```
#### Fern (Laravel Worker)
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 56:41:1c:92:43:bd
```
#### Richter (Client)
```
auto eth0
iface eth0 inet dhcp
```

#### Revolte (Client)
```
auto eth0
iface eth0 inet dhcp
```

#### Stark (Client)
```
auto eth0
iface eth0 inet dhcp
```

#### Sein (Client)
```
auto eth0
iface eth0 inet dhcp
```

## 1. Konfigurasi DHCP dan melakukan register domain berupa riegel.canyon.yyy.com untuk worker Laravel dan granz.channel.yyy.com untuk worker PHP

### Penyelesaian
Konfigurasi pada DNS Server Heiter

```sh
echo '
zone "riegel.canyon.d10.com"{
    type master;
    file "/etc/bind/jarkom/riegel.canyon.d10.com";
};

zone "granz.channel.d10.com"{
    type master;
    file "/etc/bind/jarkom/granz.channel.d10.com";
};

zone "4.196.192.in-addr.arpa"{
    type master;
    file "/etc/bind/jarkom/4.196.192.in-addr.arpa";
};

zone "3.196.192.in-addr.arpa"{
    type master;
    file "/etc/bind/jarkom/3.196.192.in-addr.arpa";
};
' > /etc/bind/named.conf.local

mkdir -p /etc/bind/jarkom

cp /etc/bind/db.local /etc/bind/jarkom/riegel.canyon.d10.com

cp /etc/bind/db.local /etc/bind/jarkom/granz.channel.d10.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     riegel.canyon.d10.com. root.riegel.canyon.d10.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      riegel.canyon.d10.com.
@       IN      A       192.196.4.1 ; IP Fern (x.1)
' > /etc/bind/jarkom/riegel.canyon.d10.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     granz.channel.d10.com. root.granz.channel.d10.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      granz.channel.d10.com.
@       IN      A       192.196.3.1 ; IP Lugner (x.1)
' > /etc/bind/jarkom/granz.channel.d10.com

cp /etc/bind/db.local /etc/bind/jarkom/3.196.192.in-addr.arpa

cp /etc/bind/db.local /etc/bind/jarkom/4.196.192.in-addr.arpa

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     riegel.canyon.d10.com. root.riegel.canyon.d10.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
4.196.192.in-addr.arpa.       IN      NS      riegel.canyon.d10.com.
1       IN      PTR       riegel.canyon.d10.com.
' > /etc/bind/jarkom/4.196.192.in-addr.arpa

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     granz.channel.d10.com. root.granz.channel.d10.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
3.196.192.in-addr.arpa.       IN      NS      granz.channel.d10.com.
1       IN      PTR       granz.channel.d10.com.
' > /etc/bind/jarkom/3.196.192.in-addr.arpa

echo '
options {
    directory "/var/cache/bind";
    forwarders {
        192.168.122.1;
    };
    // dnssec-validation auto;
    allow-query{any;};
    auth-nxdomain no; # conform to RFC1035
    listen-on-v6 { any; };
};
' > /etc/bind/named.conf.options

service bind9 restart
```

### Output
![image](https://github.com/kenanargya/Jarkom-Modul-2-D10-2023/assets/92387421/a7d74b21-b371-4cdd-ac8f-0b6d13ab9bd1)

## 2. Setting CLIENT Switch3 dengan range IP 192.196.3.16 - 192.196.3.32 dan 192.196.3.64 - 192.196.3.80

### Penyelesaian
Menambahkan konfigurasi pada DHCP Server Himmel untuk switch 3.

```sh
echo '
subnet 192.196.1.0 netmask 255.255.255.0 {}

subnet 192.196.2.0 netmask 255.255.255.0 {
    option routers 192.196.2.0;
    option broadcast-address 192.196.2.255;
    option domain-name-servers 192.196.1.2;
}

subnet 192.196.3.0 netmask 255.255.255.0 {
    range 192.196.3.16 192.196.3.32;
    range 192.196.3.64 192.196.3.80;
    option routers 192.196.3.0;
    option broadcast-address 192.196.3.255;
    option domain-name-servers 192.196.1.2;
    default-lease-time 180;
    max-lease-time 5760;
}
```

## 3. Setting CLIENT Switch3 dengan range IP 192.196.4.12 - 192.196.4.20 dan 192.196.4.160 - 192.196.4.168

### Penyelesaian
```sh
echo '
subnet 192.196.1.0 netmask 255.255.255.0 {}

subnet 192.196.2.0 netmask 255.255.255.0 {
    option routers 192.196.2.0;
    option broadcast-address 192.196.2.255;
    option domain-name-servers 192.196.1.2;
}

subnet 192.196.3.0 netmask 255.255.255.0 {
    range 192.196.3.16 192.196.3.32;
    range 192.196.3.64 192.196.3.80;
    option routers 192.196.3.0;
    option broadcast-address 192.196.3.255;
    option domain-name-servers 192.196.1.2;
    default-lease-time 180;
    max-lease-time 5760;
}

subnet 192.196.4.0 netmask 255.255.255.0 {
    range 192.196.4.12 192.196.4.20;
    range 192.196.4.160 192.196.4.168;
    option routers 192.196.4.0;
    option broadcast-address 192.196.4.255;
    option domain-name-servers 192.196.1.2;
    default-lease-time 720;
    max-lease-time 5760;
}
```

## 4. Client mendapatkan DNS dari Heiter dan dapat terhubung dengan internet

### Penyelesaian
Menambahkan option broadcast-address dan option domain-name-server pada DHCP Server Himmel agar DNS dapat digunakan.

```sh
echo '
subnet 192.196.1.0 netmask 255.255.255.0 {}

subnet 192.196.2.0 netmask 255.255.255.0 {
    option routers 192.196.2.0;
    option broadcast-address 192.196.2.255;
    option domain-name-servers 192.196.1.2;
}

subnet 192.196.3.0 netmask 255.255.255.0 {
    range 192.196.3.16 192.196.3.32;
    range 192.196.3.64 192.196.3.80;
    option routers 192.196.3.0;
    option broadcast-address 192.196.3.255;
    option domain-name-servers 192.196.1.2;
    default-lease-time 180;
    max-lease-time 5760;
}

subnet 192.196.4.0 netmask 255.255.255.0 {
    range 192.196.4.12 192.196.4.20;
    range 192.196.4.160 192.196.4.168;
    option routers 192.196.4.0;
    option broadcast-address 192.196.4.255;
    option domain-name-servers 192.196.1.2;
    default-lease-time 720;
    max-lease-time 5760;
}
echo 'INTERFACESv4="eth0"' > /etc/default/isc-dhcp-server

service isc-dhcp-server start
```

Menambahkan command pada DHCP Relay Aura
```sh
echo 'net.ipv4.ip_forward=1' >  /etc/sysctl.conf

service isc-dhcp-relay start
```

## 5. Lease time Switch3 selama 3 menit Switch4 selama 12 menit Dengan waktu maksimal untuk peminjaman alamat IP selama 96 menit

### Penyelesaian
Mengubah default-lease-time pada switch3 menjadi 180 dan pada switch4 menjadi 720 dan max-lease-time pada kedua switch 5760.

```sh
echo '
subnet 192.196.1.0 netmask 255.255.255.0 {}

subnet 192.196.2.0 netmask 255.255.255.0 {
    option routers 192.196.2.0;
    option broadcast-address 192.196.2.255;
    option domain-name-servers 192.196.1.2;
}

subnet 192.196.3.0 netmask 255.255.255.0 {
    range 192.196.3.16 192.196.3.32;
    range 192.196.3.64 192.196.3.80;
    option routers 192.196.3.0;
    option broadcast-address 192.196.3.255;
    option domain-name-servers 192.196.1.2;
    default-lease-time 180;
    max-lease-time 5760;
}

subnet 192.196.4.0 netmask 255.255.255.0 {
    range 192.196.4.12 192.196.4.20;
    range 192.196.4.160 192.196.4.168;
    option routers 192.196.4.0;
    option broadcast-address 192.196.4.255;
    option domain-name-servers 192.196.1.2;
    default-lease-time 720;
    max-lease-time 5760;
}
```

## 6. Konfigurasi masing2 Worker PHP dengan berikut 

### Penyelesaian
Melakukan setup pada PHP Worker untuk melakukan download dan unzip pada drive yang diminta dan melakukan konfigurasi pada nginx
```sh
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

rm -rf /etc/nginx/sites-enabled/default

service nginx restart
```
### Output
![image](https://github.com/kenanargya/Jarkom-Modul-2-D10-2023/assets/92387421/90537ebf-86ca-4364-ad9b-0b9288518610)
![image](https://github.com/kenanargya/Jarkom-Modul-2-D10-2023/assets/92387421/5366e2f7-88e6-454e-a946-a9e4aea94c94)
![image](https://github.com/kenanargya/Jarkom-Modul-2-D10-2023/assets/92387421/4067116d-5d06-432f-8f88-259bd65da945)

## 7. Konfigurasi Eisen lalu lakukan testing dengan 1000 request dan 100 request/second
ab -n 1000 -c 100 http://granz.channel.d10.com/

### Penyelesaian
Pertama jangan lupa untuk melakukan konfigurasi pada DNS Server untuk mengarahkan domain pada IP Load Balancer Eisen. Kemudian lakukan konfigurasi pada Eisen.

```sh
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
        proxy_pass http://backend;
        proxy_set_header    X-Real-IP $remote_addr;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    Host $http_host;
    }

    location ~ /\.ht {
        deny all;
    }
    error_log /var/log/nginx/lb_error.log;
    access_log /var/log/nginx/lb_access.log;

}
' > /etc/nginx/sites-available/lb-granz.channel.d10
```
### Command
```sh
ab -n 1000 -c 100 http://granz.channel.d10.com/
```
### Output
![image](https://github.com/kenanargya/Jarkom-Modul-2-D10-2023/assets/92387421/f8e9eb29-bdbf-4857-ac66-b8cd764998c7)
![image](https://github.com/kenanargya/Jarkom-Modul-2-D10-2023/assets/92387421/7afb9b22-e290-4532-b04f-9e43a754362a)

## 8. Analisis hasil testing dengan 200 request dan 10 request/second ab -n 200 -c 10 http://granz.channel.d10.com/ 
### Command
```sh
ab -n 200 -c 10 http://granz.channel.d10.com/ 
```
### Output
* Round Robin  
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/3bfa7849-6fae-41f4-82c3-bf97e896ce94)

* Least-connection  
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/b92ec1a1-5167-4e56-a9e9-09d5d18f2ee9)

* IP Hash  
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/a4853c2a-cca6-48d6-b5ed-cdad9ab6764b)

* Generic Hash  
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/d8c97d37-7d7a-4e53-98c5-6e2729faecd0)

### Grafik
* Round Robin  
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/fb76e15f-284d-4b32-8cec-50037590d84a)  
Request per second = 762.70

* Least-connection   
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/ed96a74e-47b2-434e-b67e-d55e4925fb15)  
Request per second = 1000.14

* IP Hash  
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/321cde3a-60e1-4ece-a7d3-478e2631f5b5)  

Request per second = 1065.77

* Generic Hash  
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/b292ada7-7924-4772-9408-68f4f242029b)  
Request per second = 983.34

![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/f0974edf-57a4-4c40-a323-a35c89b17c8e)  

### Analisis
Berdasarkan grafik yang request per second masing-masing algoritma load balancing, dapat disimpulkan bahwa IP Hash lebih baik dibandingkan algoritma yang lain.

## 9.  Dengan algoritma Round Robin, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 100 request dengan 10 request/second, kemudian tambahkan grafiknya pada grimoire

### Penyelesaian
Melakukan testing pada Load Balancer dengan menggunakan 1 worker, 2 worker, 3 worker.

### Output
* Tiga Worker  
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/fc415028-ff25-4cfb-88fd-f09b15056ee0)
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/18a5d098-5fcd-4e05-8276-f9ed86b83984)

* Dua Worker  
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/c6d096f6-3e0d-4b06-a927-3f0b80f5c4db)
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/af6ea31f-c2f1-4410-8f1a-add29b7ce0d7)

* Satu Worker  
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/0cccfb19-d61c-4ff3-bc06-4ca7e232a673)
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/4dd70be6-fc73-4f95-9cc0-baa67f3edc7a)

### Grafik
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/1c489cd9-4b68-4ace-a3be-784a9442baa5)

## 10. konfigurasi autentikasi di LB dengan dengan kombinasi username: “netics” dan password: “ajkyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/rahasisakita/

### Penyelesaian
Menambahkan konfigurasi tambahan untuk autentikasi password pada Load Balancer Eisen.

```sh
mkdir /etc/nginx/rahasiakita

echo 'netics:$apr1$6mMkZqDC$BqIpSPJBrWjAVIGiOGKkU1' > /etc/nginx/rahasiakita/.htpasswd

auth_basic "Administrator'\''s Area";
auth_basic_user_file /etc/nginx/rahasiakita/.htpasswd;
```

### Command
```sh
lynx 192.196.2.2
```

### Output
![image](https://github.com/kenanargya/Jarkom-Modul-2-D10-2023/assets/92387421/818c50dc-4e00-49ff-a45e-ee7caf3ea9d7)
![image](https://github.com/kenanargya/Jarkom-Modul-2-D10-2023/assets/92387421/b6f8b81f-4480-4f93-8bf8-3fea4b3cd456)

## 11. Lalu buat untuk setiap request yang mengandung /its akan di proxy passing menuju halaman https://www.its.ac.id.

### Penyelesaian
Menambahkan konfigurasi tambahan nginx untuk its.ac.id

```sh
location /its {
        proxy_pass https://www.its.ac.id;

        auth_basic "Administrator'\''s Area";
        auth_basic_user_file /etc/nginx/rahasiakita/.htpasswd;
    }
```

### Command
```sh
lynx 192.196.2.2/its
```

### Output
![image](https://github.com/kenanargya/Jarkom-Modul-2-D10-2023/assets/92387421/e08a72e3-f813-4dea-b98e-fe8e8fa63c43)

## 12. LB ini hanya boleh diakses oleh client dengan IP 192.196.3.69, 192.196.3.70, 192.196.4.167, dan 192.196.4.168.

### Penyelesaian
Penambahan konfigurasi nginx pada Load Balancer Eisen.

```sh
location / {
        allow 192.196.3.69;
        allow 192.196.3.70;
        allow 192.196.4.167;
        allow 192.196.4.168;
        deny all;
}
```
```sh
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
```

## 13. Konfigurasi Denken dan harus dapat diakses oleh Frieren, Flamme, dan Fern.

### Penyelesaian
Melakukan beberapa konfigurasi pada Database Server Denken.

```sh
echo '
[client-server]

!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mariadb.conf.d/

[mysqld]
skip-networking=0
skip-bind-address
' > /etc/mysql/my.cnf
```

```sh
echo '
bind-address            = 0.0.0.0
service mysql restart
' > /etc/mysql/mariadb.conf.d/50-server.cnf
```
Kemudian tambahkan pada sql

```sql
mysql <<EOF
CREATE USER 'kelompokd10'@'%' IDENTIFIED BY 'passwordd10';
CREATE USER 'kelompokd10'@'localhost' IDENTIFIED BY 'passwordd10';
CREATE DATABASE dbkelompokd10;
GRANT ALL PRIVILEGES ON *.* TO 'kelompokd10'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompokd10'@'localhost';
FLUSH PRIVILEGES;
EOF
```

### Output
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/dad20ffc-3ea4-4880-8c4a-b5300fac0495)

## 14. Laravel worker memiliki Riegel Channel sesuai dengan quest guide berikut. Jangan lupa melakukan instalasi PHP8.0 dan Composer

### Penyelesaian
Melakukan instalasi composer dan PHP 8.0 terlebih dahulu.

```sh
wget https://getcomposer.org/download/2.0.13/composer.phar
chmod +x composer.phar
mv composer.phar /usr/bin/composer

apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2

curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg

sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'

apt-get install php8.0-mbstring php8.0-xml php8.0-cli php8.0-common php8.0-intl php8.0-opcache php8.0-readline php8.0-mysql php8.0-fpm php8.0-curl unzip wget -y
```
Kemudian lakukan cloning pada resource github yang diminta.

```sh
apt-get install git -y
cd /var/www
git clone https://github.com/martuafernando/laravel-praktikum-jarkom.git
cd laravel-praktikum-jarkom
composer update
```

Setelah melakukan cloning, lakukan konfigurasi database pada masing-masing worker.
```sh
cp .env.example .env

echo '
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=192.196.2.1
DB_PORT=3306
DB_DATABASE=dbkelompokd10
DB_USERNAME=kelompokd10
DB_PASSWORD=passwordd10

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

VITE_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="${PUSHER_HOST}"
VITE_PUSHER_PORT="${PUSHER_PORT}"
VITE_PUSHER_SCHEME="${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"
' > .env

php artisan key:generate

php artisan config:cache

php artisan migrate

php artisan db:seed

php artisan storage:link

php artisan jwt:secret

php artisan config:clear
```
Kemudian lakukan konfigurasi nginx pada masing-masing worker.

```sh
server {

    listen [PORT];

    root /var/www/laravel-praktikum-jarkom/public;

    index index.php index.html index.htm;
    server_name _;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    # pass PHP scripts to FastCGI server
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
    }

    location ~ /\.ht {
            deny all;
    }

    error_log /var/log/nginx/riegel.canyon.d10_error.log;
    access_log /var/log/nginx/riegel.canyon.d10_access.log;
}
' > /etc/nginx/sites-available/riegel.canyon.d10

ln -s /etc/nginx/sites-available/riegel.canyon.d10 /etc/nginx/sites-enabled/
```

### Command
```sh
lynx localhost:[PORT]
```

### Output
![WhatsApp Image 2023-11-19 at 20 34 29_8947d342](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/c8b51930-4b72-4b9c-8c68-2bc191792c83)

## 15. Riegel Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire. 
POST /auth/register

### Penyelesaian
Melakukan testing menggunakan file .json.

```sh
echo '{"username": "testd10", "password": "testd10"}' > temp.json
```

### Output
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/0dfebb61-38b8-4bfe-b8be-3b8007f5f553)


## 16. POST /auth/login

### Output
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/cb47f9bb-b4e0-4793-bb40-f38833033abe)

## 17. GET /me.

### Penyelesaian
```sh
curl -X POST -H "Content-Type: application/json" -d @temp.json http://192.196.4.1:8001/api/auth/login > token.txt
```

### Output
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/00c87937-d578-4abb-9d79-7263b2499fc7)

## 18. implementasikan Proxy Bind pada Eisen untuk mengaitkan IP dari Frieren, Flamme, dan Fern.

### Penyelesaian
Menambahkan konfigurasi nginx berikut dengan port yang sesuai.

```sh
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
```

## 19. Untuk meningkatkan performa dari Worker, coba implementasikan PHP-FPM pada Frieren, Flamme, dan Fern. Untuk testing kinerja naikkan 
- pm.max_children
- pm.start_servers
- pm.min_spare_servers
- pm.max_spare_servers
sebanyak tiga percobaan dan lakukan testing sebanyak 100 request dengan 10 request/second kemudian berikan hasil analisisnya pada Grimoire.

### Penyelesaian
Konfigurasi pada masing-masing worker.

```sh
echo '
[www]
user = www-data
group = www-data
listen = /run/php/php8.0-fpm.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 50
pm.start_servers = 10
pm.min_spare_servers = 5
pm.max_spare_servers = 20
' > /etc/php/8.0/fpm/pool.d/www.conf
```

### Output
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/fa7f3896-868e-4fdd-87cc-585533fe7c46)


## 20. implementasikan Least-Conn pada Eisen. Untuk testing kinerja dari worker tersebut dilakukan sebanyak 100 request dengan 10 request/second.

### Penyelesaian
Penambahan algoritma least-connection pada Load Balancer.

```sh
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
```

### Output
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/6095fea7-04fa-46f9-bc70-e776cf5a40f7)

