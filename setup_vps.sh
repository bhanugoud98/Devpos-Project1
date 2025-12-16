#!/bin/bash

# Setup Script for Generic Linux VPS (Ubuntu/Debian)
# Installs Docker, Docker Compose, and Git

set -e

echo "Updating system..."
sudo apt-get update && sudo apt-get upgrade -y

echo "Installing Git..."
sudo apt-get install -y git curl

echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

echo "Installing Docker Compose..."
sudo apt-get install -y docker-compose-plugin

echo "Verifying installation..."
docker --version
docker compose version

echo "Setup complete! Please logout and login again to use Docker without sudo."
