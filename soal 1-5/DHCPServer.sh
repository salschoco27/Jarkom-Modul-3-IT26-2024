# Pada Tybur konfigurasi DHCP Server (Soal 1)

echo 'INTERFACESv4="eth0"' > /etc/default/isc-dhcp-server

echo 'subnet 192.246.1.0 netmask 255.255.255.0 {
#Soal 2 Range IP Marley
        range 192.246.1.05 192.246.1.25;
        range 192.246.1.50 192.246.1.100;
        option routers 192.246.1.1;
#Soal 4 DNS Server Fritz
        option broadcast-address 192.246.1.255;
        option domain-name-servers 192.246.4.2;
#Soal 5 Durasi DHCP Marley
        default-lease-time 1800;
        max-lease-time 5220;
}

subnet 192.246.2.0 netmask 255.255.255.0 {
#Soal 3 Range IP Eldia
        range 192.246.2.09 192.246.2.27;
        range 192.246.2.81 192.246.2.243;
        option routers 192.246.2.1;
#Soal 4 DNS Server Fritz
        option broadcast-address 192.246.2.255;
        option domain-name-servers 192.246.4.2;
#Soal 5 Durasi DHCP Eldia
        default-lease-time 360;
        max-lease-time 5220;
}

subnet 192.246.3.0 netmask 255.255.255.0 {
        option routers 192.246.3.1;
}

subnet 192.246.4.0 netmask 255.255.255.0 {
        option routers 192.246.4.1;
} ' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart