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