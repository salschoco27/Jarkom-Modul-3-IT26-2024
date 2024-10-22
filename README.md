# Laporan Resmi Jarkom-Modul-3-IT26-2024
**Salsabila Rahmah (5027231005)** <br>
**Rafael Ega Krisaditya (5027231025)**
## Daftar Isi

### IP Node
1. Paradis:
    - eth1: 192.246.1.1
    - eth2: 192.246.2.1
    - eth3: 192.246.3.1
    - eth4: 192.246.4.1
2. Annie: 192.246.1.2
3. Berdholdt: 192.246.1.3
4. Reiner: 192.246.1.4
5. Armin: 192.246.2.2
6. Eren: 192.246.2.3
7. Mikasa: 192.246.2.4
8. Beast: 192.246.3.2
9. Colossal: 192.246.3.3
10. Warhammer: 192.246.3.4
11. Fritz: 192.246.4.2
12. Tybur: 192.246.4.3

### Network Configuration
1. Paradis
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 192.246.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.246.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 192.246.3.1
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 192.246.4.1
	netmask 255.255.255.0
```

2. Annie
```
auto eth0
iface eth0 inet static
	address 192.246.1.2
	netmask 255.255.255.0
	gateway 192.246.1.1
```
3. Berdholdt
```
auto eth0
iface eth0 inet static
    address 192.246.1.3
    netmask 255.255.255.0
    gateway 192.246.1.1
```

4. Reiner
```
auto eth0
iface eth0 inet static
    address 192.246.1.4
    netmask 255.255.255.0
    gateway 192.246.1.1
```

5. Armin
```
auto eth0
iface eth0 inet static
    address 192.246.2.2
    netmask 255.255.255.0
    gateway 192.246.2.1
```

6. Eren
```
auto eth0
iface eth0 inet static
    address 192.246.2.3
    netmask 255.255.255.0
    gateway 192.246.2.1
```

7. Mikasa
```
auto eth0
iface eth0 inet static
    address 192.246.2.4
    netmask 255.255.255.0
    gateway 192.246.2.1
```

8. Beast
```
auto eth0
iface eth0 inet static
    address 192.246.3.2
    netmask 255.255.255.0
    gateway 192.246.3.1
```

9. Colossal
```
auto eth0
iface eth0 inet static
    address 192.246.3.3
    netmask 255.255.255.0
    gateway 192.246.3.1
```

10. Warhammer
```
auto eth0
iface eth0 inet static
    address 192.246.3.4
    netmask 255.255.255.0
    gateway 192.246.3.1
```

11. Fritz
```
auto eth0
iface eth0 inet static
    address 192.246.4.2
    netmask 255.255.255.0
    gateway 192.246.4.1
```

12. Tybur
```
auto eth0
iface eth0 inet static
    address 192.246.4.3
    netmask 255.255.255.0
    gateway 192.246.4.1
```

13. Zeke & Erwin
```
auto eth0
iface eth0 inet dhcp
```

### .bashrc
1. DHCP Relay (Paradis)
```bash
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.246.0.0/16
apt-get update
apt install isc-dhcp-relay -y
```

2. DHCP Server (Tybur)
```bash
echo 'nameserver 192.246.4.2' > /etc/resolv.conf
apt-get update
apt-get install isc-dhcp-server -y
```

3. DNS Server (Fritz)
```bash
echo 'nameserver 192.168.122.1' > /etc/resolv.conf
apt-get update
apt-get install bind9 -y

echo 'options {
        directory "/var/cache/bind";

        forwarders {
                192.168.122.1;
        };

        // dnssec-validation auto;
        allow-query{any;};
        auth-nxdomain no;
        listen-on-v6 { any; };
}; ' >/etc/bind/named.conf.options

service bind9 restart
```

4. PHP Worker (Armin, Eren, Mikasa)
```bash
echo 'nameserver 192.246.4.2' > /etc/resolv.conf
apt-get update
apt-get install lynx -y
apt-get install wget -y
apt-get install unzip -y
apt-get install nginx -y
apt install software-properties-common -y
apt install php7.3 -y
apt install php7.3-fpm -y
```

5. PHP Load Balancer (Colossal)
```bash
echo 'nameserver 192.246.4.2' > /etc/resolv.conf
apt-get update
apt-get install bind9 -y
apt-get install apache2-utils -y
apt-get install nginx -y
apt-get install lynx -y

service nginx start
```
Client (Zeke, Erwin)
```bash
apt update
apt install lynx -y
apt install htop -y
apt install apache2-utils -y
apt-get install jq -y
```

## Soal 0
Pulau Paradis telah menjadi tempat yang damai selama 1000 tahun, namun kedamaian tersebut tidak bertahan selamanya. Perang antara kaum Marley dan Eldia telah mencapai puncak. Kaum Marley yang dipimpin oleh Zeke, me-register domain name **marley.yyy.com** untuk worker Laravel mengarah pada **Annie**. Namun ternyata tidak hanya kaum Marley saja yang berinisiasi, kaum Eldia ternyata sudah mendaftarkan domain name **eldia.yyy.com** untuk worker PHP **(0)** mengarah pada **Armin**.

```bash
#Pada Fritz

echo 'zone "marley.it26.com" { 
        type master; 
        file "/etc/bind/marley/marley.it26.com";
};

zone "eldia.it26.com" {
        type master;
        file "/etc/bind/eldia/eldia.it26.com";
}; ' >> /etc/bind/named.conf.local

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
@       IN      NS      eldia.16.com.
@       IN      A       192.246.2.2     ; IP Armin' > /etc/bind/eldia/eldia.it26.com

service bind9 restart
```

## Soal 1-5
Lakukan konfigurasi sesuai dengan peta yang sudah diberikan.**(1)**

Jauh sebelum perang dimulai, ternyata para keluarga bangsawan, Tybur dan Fritz, telah membuat kesepakatan sebagai berikut:
1. Semua **Client** harus menggunakan konfigurasi ip address dari keluarga **Tybur (dhcp)**.
2. **Client yang melalui bangsa marley** mendapatkan range IP dari [prefix IP].1.05 - [prefix IP].1.25 dan [prefix IP].1.50 - [prefix IP].1.100 **(2)**
3. **Client yang melalui bangsa eldia** mendapatkan range IP dari [prefix IP].2.09 - [prefix IP].2.27 dan [prefix IP].2 .81 - [prefix IP].2.243 **(3)**
4. **Client mendapatkan DNS** dari keluarga **Fritz** dan dapat terhubung dengan internet melalui DNS tersebut **(4)**
5. Dikarenakan keluarga **Tybur** tidak menyukai kaum eldia, maka mereka hanya meminjamkan ip address ke kaum **eldia** selama **6 menit**. Namun untuk kaum **marley**, keluarga Tybur meminjamkan ip address selama **30 menit**. **Waktu maksimal** dialokasikan untuk peminjaman alamat IP selama **87 menit**. **(5)**

### DHCP Relay (Paradis)
```bash
#Pada Paradis

echo 'SERVERS="192.246.4.3"
INTERFACES="eth1 eth2 eth3 eth4"' > /etc/default/isc-dhcp-relay

echo 'net.ipv4.ip_forward=1' > /etc/sysctl.conf

service isc-dhcp-relay restart
```

### DHCP Server (Tybur)
```bash
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
```

## Soal 6-12
Seiring berjalannya waktu kondisi semakin memanas, untuk bersiap perang. Kaum **Eldia** melakukan deployment sebagai berikut
1. **Armin** berinisiasi untuk memerintahkan setiap worker PHP untuk melakukan konfigurasi virtual host untuk website berikut https://intip.in/BangsaEldia dengan menggunakan php 7.3 **(6)**
2. Dikarenakan Armin sudah mendapatkan kekuatan titan colossal, maka bantulah kaum **eldia** menggunakan **colossal** agar dapat bekerja sama dengan baik. Kemudian lakukan testing dengan 6000 request dan 200 request/second. **(7)**
3. Karena Erwin meminta “laporan kerja Armin”, maka dari itu buatlah analisis hasil testing dengan 1000 request dan 75 request/second untuk masing-masing algoritma Load Balancer dengan ketentuan sebagai berikut:
- Nama Algoritma Load Balancer
- Report hasil testing pada Apache Benchmark
- Grafik request per second untuk masing masing algoritma. 
- Analisis **(8)**

3. Dengan menggunakan algoritma Least-Connection, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 1000 request dengan 10 request/second, kemudian tambahkan grafiknya pada “laporan kerja Armin”. **(9)**
4. Selanjutnya coba tambahkan keamanan dengan konfigurasi autentikasi di **Colossal** dengan dengan kombinasi username: “arminannie” dan password: “jrkmyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/supersecret/ **(10)**
5. Lalu buat untuk setiap request yang mengandung /titan akan di proxy passing menuju halaman https://attackontitan.fandom.com/wiki/Attack_on_Titan_Wiki **(11)** 
**hint: (proxy_pass)**
6. Selanjutnya Colossal ini hanya boleh diakses oleh client dengan IP [Prefix IP].1.77, [Prefix IP].1.88, [Prefix IP].2.144, dan [Prefix IP].2.156. **(12)** 
**hint: (fixed in dulu clientnya)**

### Soal 6
```bash
# Soal 6: Jalankan pada setiap PHP worker (Armin, Eren, Mikasa)
mkdir -p /var/www/eldia.it26.com

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1TvebIeMQjRjFURKVtA32lO9aL7U2msd6' -O /root/bangsaEldia.zip
unzip /root/bangsaEldia.zip -d /var/www/eldia.it26.com
rm -rf /root/bangsaEldia.zip

echo '
server {

        listen 80;

        root /var/www/eldia.it26.com;

        index index.php index.html index.htm;
        server_name _;

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

        error_log /var/log/nginx/jarkom_error.log;
        access_log /var/log/nginx/jarkom_access.log;
 }' > /etc/nginx/sites-available/eldia.it26.com

ln -s /etc/nginx/sites-available/eldia.it26.com /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default

service php7.3-fpm start
service php7.3-fpm restart
service nginx restart
nginx -t
```

### Soal 7
```bash
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
```

```bash
# Soal 7: Jalankan pada Colossal
echo '
 upstream myweb  {
        server 192.246.2.2; #IP Armin
        server 192.246.2.3; #IP Eren
        server 192.246.2.4; #IP Mikasa
 }

 server {
        listen 80;
        server_name eldia.it26.com;

        location / {
        proxy_pass http://myweb;
        }
 }' > /etc/nginx/sites-available/lb-php

ln -s /etc/nginx/sites-available/lb-php /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default

service nginx restart
nginx -t
```

```bash
#Pada Erwin lakukan sebagai langkah akhir untuk pengetesan
ab -n 6000 -c 200 http://eldia.it26.com/
```

### Soal 8
```bash
# Soal 8: Jalankan pada Colossal dan coba menggunakan tiap algoritma load balancing
echo '
 upstream myweb  {
#    hash $request_uri consistent;
#    least_conn;
#    ip_hash;
        server 192.246.2.2; #IP Armin
        server 192.246.2.3; #IP Eren
        server 192.246.2.4; #IP Mikasa
 }

 server {
        listen 80;
        server_name eldia.it26.com;

        location / {
        proxy_pass http://myweb;
        }
 }' > /etc/nginx/sites-available/lb-php

ln -s /etc/nginx/sites-available/lb-php /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default

service nginx restart
nginx -t
```

```bash
#Pada Erwin lakukan setiap kali algoritma load balancer diubah
ab -n 1000 -c 75 http://eldia.it26.com/
```

### Soal 9
```bash
# Ubah jumlah worker
service nginx stop
```

```bash
#Pada Erwin lakukan setiap kali jumlah worker diubah
ab -n 1000 -c 10 http://eldia.it26.com/
```

### Soal 10
```bash
#Pada Colossal

mkdir /etc/nginx/supersecret
htpasswd -b -c /etc/nginx/supersecret/htpasswd arminannie jrkmit26

echo '
 upstream myweb  {
        least_conn;
        server 192.246.2.2; #IP Armin
        server 192.246.2.3; #IP Eren
        server 192.246.2.4; #IP Mikasa
 }

 server {
        listen 80;
        server_name eldia.it26.com;

        location / {
        auth_basic "Restricted Access";
        auth_basic_user_file /etc/nginx/supersecret/htpasswd;
        proxy_pass http://myweb;
        }
 }' > /etc/nginx/sites-available/lb-php

ln -s /etc/nginx/sites-available/lb-php /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default

service nginx restart
nginx -t
```

Lalu akses di client dengan `lynx`

### Soal 11
```bash
#Pada Colossal

echo '
 upstream myweb  {
        least_conn;
        server 192.246.2.2; #IP Armin
        server 192.246.2.3; #IP Eren
        server 192.246.2.4; #IP Mikasa
 }

 server {
        listen 80;
        server_name eldia.it26.com;

        location / {
        auth_basic "Restricted Access";
        auth_basic_user_file /etc/nginx/supersecret/htpasswd;
        proxy_pass http://myweb;
        }

        location /titan/ {
        proxy_pass https://attackontitan.fandom.com/wiki/Attack_on_Titan_Wiki/;
        }
 }' > /etc/nginx/sites-available/lb-php

ln -s /etc/nginx/sites-available/lb-php /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default

service nginx restart
nginx -t
```

### Soal 12
```bash
# Pada Colossal

echo '
 upstream myweb  {
        least_conn;
        server 192.246.2.2; #IP Armin
        server 192.246.2.3; #IP Eren
        server 192.246.2.4; #IP Mikasa
 }

server {
	listen 80;
	server_name eldia.it26.com;

	location / {
		allow 192.246.1.77;
		allow 192.246.1.88;
		allow 192.246.2.144;
		allow 192.246.2.156;
		deny all;

		auth_basic "Restricted Content";
		auth_basic_user_file /etc/nginx/supersecret/htpasswd;
		proxy_pass http://myweb;
	}

	location /dune {
		proxy_pass https://attackontitan.fandom.com/wiki/Attack_on_Titan_Wiki/;
	}
}' > /etc/nginx/sites-available/lb-php

ln -s /etc/nginx/sites-available/lb-php /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default

service nginx restart
nginx -t

# Pada Tybur
echo 'host Zeke{
        hardware ethernet fa:61:fb:1a:8d:5b;
        fixed-address 192.246.1.77;
}
' >> /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart

# Pada Zeke
echo 'hwaddress ether fa:61:fb:1a:8d:5b' >> /etc/network/interfaces
```
