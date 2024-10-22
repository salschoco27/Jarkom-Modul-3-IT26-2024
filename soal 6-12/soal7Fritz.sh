#Jalankan pada Fritz
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
@       IN      A       192.246.3.3     ; IP Colossal' > /etc/bind/eldia/eldia.it26.com

service bind9 restart