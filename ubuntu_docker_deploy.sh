#!/bin/bash

# One-click Docker deployment script for Python Calculator on Ubuntu
echo "===== Python Calculator Docker Deployment Script for Ubuntu ====="

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Install Docker if not already installed
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker $USER
    echo "Docker installed successfully!"
    echo "NOTE: You may need to log out and back in for group changes to take effect."
fi

# Install Docker Compose if not already installed
if ! command -v docker-compose &> /dev/null; then
    echo "Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose installed successfully!"
fi

# Clone the repository if it doesn't exist
if [ ! -d "python-calculator" ]; then
    echo "Cloning the repository..."
    git clone https://github.com/james-ap-sunny/python-calculator.git
    cd python-calculator
else
    echo "Repository already exists, updating..."
    cd python-calculator
    git pull
fi

# Build and run the Docker container
echo "Building and starting the Docker container..."
docker-compose up -d --build

echo "===== Deployment complete! ====="
echo "The calculator is now running in a Docker container."
echo "Access the calculator via web browser at: http://localhost:8080/vnc.html"
echo "Click 'Connect' in the browser to access the calculator GUI."
echo ""
echo "To stop the container, run: docker-compose down"