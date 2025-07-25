#!/bin/bash

# One-click installation script for Python Calculator on CentOS
echo "===== Python Calculator Installation Script for CentOS ====="

# Update package lists
echo "Updating package lists..."
sudo yum update -y

# Install Git, Python 3 and dependencies
echo "Installing Git, Python 3 and dependencies..."
sudo yum install -y git python3 python3-devel python3-pip python3-tkinter xorg-x11-xauth

# Clone the repository
echo "Cloning the repository..."
git clone https://github.com/james-ap-sunny/python-calculator.git
cd python-calculator

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

echo "===== Installation complete! ====="