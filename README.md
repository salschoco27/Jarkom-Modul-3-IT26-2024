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
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.241.0.0/16
apt-get update
apt install isc-dhcp-relay -y
```


