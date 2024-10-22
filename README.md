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

