apt-get update

apt install isc-dhcp-server -y

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

host Lugner{
    hardware ethernet 7a:9b:02:ec:b3:ba;
    fixed-address 192.196.3.1;
}

host Linie{
    hardware ethernet ee:e7:0b:68:0d:b0;
    fixed-address 192.196.3.2;
}

host Lawine{
    hardware ethernet ea:f6:65:34:86:39;
    fixed-address 192.196.3.3;
}

host Fern{
    hardware ethernet 56:41:1c:92:43:bd;
    fixed-address 192.196.4.1;
}
host Flamme{
    hardware ethernet e6:fa:f8:05:b9:39;
    fixed-address 192.196.4.2;
}
host Frieren{
    hardware ethernet 22:6a:39:35:bf:00;
    fixed-address 192.196.4.3;
}

host Denken{
    hardware ethernet 3e:2d:4f:bf:9f:ad;
    fixed-address 192.196.2.1;
}
host Eisen{
    hardware ethernet 6e:76:17:d0:27:e8;
    fixed-address 192.196.2.2;
}
' > /etc/dhcp/dhcpd.conf

echo 'INTERFACESv4="eth0"' > /etc/default/isc-dhcp-server

service isc-dhcp-server start