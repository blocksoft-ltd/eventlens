#!/bin/bash

# Go to your project directory
cd /var/www/eventlens

# Fetch the latest changes from your repository
git pull

# Install any new dependencies
npm install

# Build your project
npm run build

# Restart the app with PM2
pm2 restart eventlens

echo "App deployed successfully!"
