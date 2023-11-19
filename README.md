# Jarkom-Modul-3-D10-2023

| Nama | NRP |
| ------- | ------- |
| Muhammad Rafi Insan Fillah | 5025211169  |
| Ken Anargya Alkausar | 5025211168  |

## 1. Konfigurasi DHCP dan melakukan register domain berupa riegel.canyon.yyy.com untuk worker Laravel dan granz.channel.yyy.com untuk worker PHP

### Topologi
![WhatsApp Image 2023-11-14 at 18 05 04_37236602](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/a31eb205-89e5-4112-bd46-5528956efcb7)

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
Round Robin
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/3bfa7849-6fae-41f4-82c3-bf97e896ce94)

Least-connection
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/b92ec1a1-5167-4e56-a9e9-09d5d18f2ee9)

IP Hash
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/a4853c2a-cca6-48d6-b5ed-cdad9ab6764b)

Generic Hash
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/d8c97d37-7d7a-4e53-98c5-6e2729faecd0)

### Grafik
Round Robin
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/fb76e15f-284d-4b32-8cec-50037590d84a)
Request per second = 762.70

Least-connection
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/ed96a74e-47b2-434e-b67e-d55e4925fb15)
Request per second = 1000.14

IP Hash
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/321cde3a-60e1-4ece-a7d3-478e2631f5b5)
Request per second = 1065.77

Generic Hash
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/b292ada7-7924-4772-9408-68f4f242029b)
Request per second = 983.34

![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/f0974edf-57a4-4c40-a323-a35c89b17c8e)

### Analisis
Berdasarkan grafik yang request per second masing-masing algoritma load balancing, dapat disimpulkan bahwa IP Hash lebih baik dibandingkan algoritma yang lain.

## 9.  Dengan algoritma Round Robin, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 100 request dengan 10 request/second, kemudian tambahkan grafiknya pada grimoire

### Penyelesaian
Melakukan testing pada Load Balancer dengan menggunakan 1 worker, 2 worker, 3 worker.

### Output
Tiga Worker
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/fc415028-ff25-4cfb-88fd-f09b15056ee0)
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/18a5d098-5fcd-4e05-8276-f9ed86b83984)

Dua Worker
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/c6d096f6-3e0d-4b06-a927-3f0b80f5c4db)
![image](https://github.com/Mengz04/Jarkom-Modul-3-D10-2023/assets/92387421/af6ea31f-c2f1-4410-8f1a-add29b7ce0d7)

Satu Worker
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
