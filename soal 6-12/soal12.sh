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