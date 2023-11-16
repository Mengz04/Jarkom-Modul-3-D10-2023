apt-get update

apt install isc-dhcp-relay -y

echo '
SERVERS="192.196.1.1"
INTERFACES="eth1 eth2 eth3 eth4"
OPTIONS=""
' > /etc/default/isc-dhcp-relay

echo 'net.ipv4.ip_forward=1' >  /etc/sysctl.conf

service isc-dhcp-relay start