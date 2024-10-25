#Pada Fritz

echo 'zone "marley.it26.com" { 
        type master; 
        file "/etc/bind/marley/marley.it26.com";
};

zone "eldia.it26.com" {
        type master;
        file "/etc/bind/eldia/eldia.it26.com";
}; ' > /etc/bind/named.conf.local

mkdir /etc/bind/marley
mkdir /etc/bind/eldia

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     marley.it26.com. root.marley.it26.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      marley.it26.com.
@       IN      A       192.246.1.2     ; IP Annie' > /etc/bind/marley/marley.it26.com

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     eldia.it26.com. root.eldia.it26.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      eldia.it26.com.
@       IN      A       192.246.2.2     ; IP Armin' > /etc/bind/eldia/eldia.it26.com

service bind9 restart