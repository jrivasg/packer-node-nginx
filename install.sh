#!/bin/bash

# Instalación de node y pm2 para el servidor de la aplicación
cd ~
curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh

sudo bash nodesource_setup.sh

sudo apt install nodejs -y

sudo apt install build-essential -y

sudo npm install pm2@latest -g

pm2 start hello.js

# Instalación y configuración de Nginx
sudo apt update

sudo apt install nginx -y

sudo ufw app list

sudo ufw allow 'Nginx HTTP'
