#!/bin/bash

# Install necessary packages
sudo apt update
sudo apt install curl gnupg2 ca-certificates lsb-release ufw git fail2ban -y

sudo tee /etc/default/ufw > /dev/null <<EOF
IPV6=yes
IPV4=yes
DEFAULT_INPUT_POLICY="DROP"
DEFAULT_OUTPUT_POLICY="ACCEPT"
DEFAULT_FORWARD_POLICY="DROP"
EOF

sudo ufw --force enable
sudo ufw default deny incoming
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https

# Secure SSH
# Disable root login and password authentication, allow only PubkeyAuthentication
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/#PubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Install and configure Fail2ban
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Restart SSH
sudo systemctl restart sshd

# Add necessary repositories and keys
echo "deb http://nginx.org/packages/debian `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -

# Install Node.js, npm, PM2, nginx and certbot
sudo apt update
sudo apt install nodejs nginx certbot python3-certbot-nginx -y

sudo ufw allow 'Nginx Full'

# Set up nginx configuration
sudo tee /etc/nginx/conf.d/eventlens.conf > /dev/null <<EOF
server {
    listen 80;
    server_name eventlens.live www.eventlens.live;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-Host \$host;
        proxy_set_header X-Forwarded-Port \$server_port;
    }

    location /static/ {
        expires 1d;
        add_header Cache-Control "public, max-age=31536000, immutable";
    }

    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
}
EOF
sudo sed -i 's/PIDFile=\/var\/run\/nginx.pid/PIDFile=\/run\/nginx.pid/' /lib/systemd/system/nginx.service

# Restart nginx to load the new configuration
sudo systemctl restart nginx

# Set up SSL with Let's Encrypt
sudo certbot --nginx -d eventlens.live -d www.eventlens.live

# Reload nginx to apply the SSL configuration
sudo systemctl reload nginx

mkdir -p /var/www/eventlens

type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

npm i -g pm2

sudo adduser eventlens
sudo usermod -aG sudo eventlens

