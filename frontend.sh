#!/bin/bash

# Update package lists
sudo apt update

# Install Nginx
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx


cp /home/ubuntu/index.html /var/www/html
PUBLIC_IP=$(curl ifconfig.me)
sed -i "s/http:\/\/public_ip:3000/http:\/\/$PUBLIC_IP:3000/" /var/www/html/index.html
# Restart Nginx to apply changes
sudo systemctl restart nginx

# Install Node.js, NPM, and MySQL Client
sudo apt update
sudo apt install -y nodejs npm mysql-client

# Create a backend directory
sudo mkdir -p /home/ubuntu/simple-backend

sudo cp /home/ubuntu/server.js /home/ubuntu/simple-backend
sudo cd /home/ubuntu/simple-backend

# Initialize a Node.js project and install dependencies
npm init -y
npm install express body-parser mysql2
npm install cors


nohup node server.js > server.log 2>&1 &
