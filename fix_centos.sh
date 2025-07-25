#!/bin/bash

# This script creates the deploy_centos.sh file and runs it
echo "Creating deployment script..."

cat > deploy_centos.sh << 'EOF'
#!/bin/bash

# One-click deployment script for Python Calculator on CentOS
echo "===== Python Calculator Deployment Script for CentOS ====="

# Update package lists
echo "Updating package lists..."
sudo yum update -y

# Install Python 3 and development tools
echo "Installing Python 3 and development tools..."
sudo yum install -y python3 python3-devel python3-pip

# Install tkinter for GUI
echo "Installing tkinter for GUI..."
sudo yum install -y python3-tkinter

# Install X11 forwarding if running on a server without GUI
echo "Installing X11 forwarding support..."
sudo yum install -y xorg-x11-xauth

# Create virtual environment
echo "Setting up virtual environment..."
python3 -m venv venv

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "Installing dependencies..."
pip install -r requirements.txt

# Run the calculator
echo "Starting the calculator..."
python3 calculator.py

echo "===== Deployment complete! ====="
echo "If you're connecting remotely, make sure to use SSH with X11 forwarding:"
echo "ssh -X user@server"
echo "Then run this script again."
EOF

# Make the script executable
chmod +x deploy_centos.sh

echo "Deployment script created. Running it now..."
./deploy_centos.sh