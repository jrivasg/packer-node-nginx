#!/bin/bash

# Instalación de node y pm2 para el servidor de la aplicación
cd ~
curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh

sudo bash nodesource_setup.sh

sudo apt install nodejs -y

sudo apt install build-essential -y

sudo npm install pm2@latest -g

pm2 start ~/node-app/hello.js

sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu

pm2 save

# Instalación y configuración de Nginx
sudo apt update

sudo apt install nginx -y

sudo ufw app list

sudo ufw allow 'Nginx HTTP'

sudo bash -c 'cat > /etc/nginx/sites-available/default << EOF
server {
    listen 80;
    listen [::]:80;

    server_name _;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF'

sudo systemctl restart nginx