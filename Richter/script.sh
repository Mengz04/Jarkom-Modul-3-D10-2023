apt-get update

apt-get install dnsutils lynx apache2-utils -y

ab -A netics:ajkd10 -n 100 -c 10 http://192.196.2.2:81/worker1