apt-get update

apt-get install bind9 -y

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