#!/bin/bash

sudo apt-get update -y

sudo apt-get install nginx -y

cat <<NGINX < /etc/nginx/sites-available/default
server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;

        root /usr/share/nginx/html;
        index index.html index.htm;

        gzip off;

        # Make site accessible from http://localhost/
        server_name localhost;

        location / {
                try_files $uri $uri/ =404;
                add_header Last-Modified $date_gmt;
                add_header Cache-Control 'no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0';
                if_modified_since off;
                expires off;
                etag off;
        }
}
NGINX

sudo service nginx restart

sudo update-rc.d nginx enable

cat <<EOF > /usr/share/nginx/html/index.html
<html>
    <head>
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
    </head>
    <body bgcolor="${var_bgcolor}">
        <div id="center" class="center">
            <h1>This is ${var_cloud}</h1>
        </div>
    </body>
</html>
EOF

