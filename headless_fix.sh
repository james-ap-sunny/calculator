#!/bin/bash

# Script to fix the "no display name and no $DISPLAY environment variable" error
echo "===== Python Calculator Headless Fix for CentOS ====="

# Check if DISPLAY environment variable is set
if [ -z "$DISPLAY" ]; then
    echo "❌ Error: No DISPLAY environment variable found."
    echo "This means X11 forwarding is not properly set up."
    echo ""
    echo "You have two options to fix this:"
    echo ""
    echo "Option 1: Connect with X11 forwarding enabled"
    echo "----------------------------------------"
    echo "1. Exit this server"
    echo "2. Reconnect using: ssh -X username@server-address"
    echo "3. Run the deployment script again"
    echo ""
    echo "Option 2: Run in headless mode (no GUI)"
    echo "----------------------------------------"
    echo "This will install the calculator but won't launch the GUI."
    echo "You can still run the tests to verify functionality."
    echo ""
    read -p "Would you like to proceed with headless installation? (y/n): " choice
    
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        echo "Installing in headless mode..."
        
        # Update package lists
        echo "Updating package lists..."
        sudo yum update -y
        
        # Install Python 3 and development tools
        echo "Installing Python 3 and development tools..."
        sudo yum install -y python3 python3-devel python3-pip
        
        # Create virtual environment
        echo "Setting up virtual environment..."
        python3 -m venv venv
        
        # Activate virtual environment
        echo "Activating virtual environment..."
        source venv/bin/activate
        
        # Install dependencies
        echo "Installing dependencies..."
        pip install -r requirements.txt
        
        # Run tests to verify functionality
        echo "Running tests to verify calculator functionality..."
        pip install pytest
        pytest tests/
        
        echo ""
        echo "===== Headless installation complete! ====="
        echo "The calculator has been installed but cannot display the GUI."
        echo "Tests have been run to verify functionality."
        echo ""
        echo "To run the calculator with GUI:"
        echo "1. Connect to this server with X11 forwarding: ssh -X username@server-address"
        echo "2. Navigate to this directory: cd python-calculator"
        echo "3. Activate the virtual environment: source venv/bin/activate"
        echo "4. Run the calculator: python3 calculator.py"
    else
        echo "Installation cancelled. Please reconnect with X11 forwarding enabled."
        exit 1
    fi
else
    echo "✅ DISPLAY environment variable is set to: $DISPLAY"
    echo "Proceeding with normal installation..."
    
    # Run the original fix_centos.sh script
    curl -s https://raw.githubusercontent.com/james-ap-sunny/python-calculator/master/fix_centos.sh -o fix_centos.sh
    chmod +x fix_centos.sh
    ./fix_centos.sh
fi