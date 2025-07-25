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

# Run the calculator with verification
echo "Starting the calculator..."
echo "Verifying calculator launch..."

# Create a verification script
cat > verify_calculator.sh << 'VERIFYEOF'
#!/bin/bash

# Check if Python is running the calculator
if pgrep -f "python3 calculator.py" > /dev/null; then
    echo "✅ Calculator is running successfully!"
    echo "   Process ID: $(pgrep -f 'python3 calculator.py')"
    echo "   If you can see the calculator GUI, the deployment is complete."
    echo "   Press Ctrl+C in the terminal to exit the calculator when done."
else
    echo "❌ Calculator failed to start. Please check the following:"
    echo "   1. Is X11 forwarding enabled? (ssh -X)"
    echo "   2. Is tkinter installed correctly?"
    echo "   3. Check for any error messages above"
fi
VERIFYEOF

chmod +x verify_calculator.sh

# Start the calculator in background and verify
python3 calculator.py &
CALC_PID=$!

# Wait a moment for the calculator to start
sleep 3

# Run verification
./verify_calculator.sh

# Inform user how to exit
echo ""
echo "===== Deployment complete! ====="
echo "If you're connecting remotely, make sure to use SSH with X11 forwarding:"
echo "ssh -X user@server"
echo "Then run this script again."
echo ""
echo "To exit the calculator, press Ctrl+C in this terminal."

# Wait for the calculator process to finish
wait $CALC_PID
EOF

# Make the script executable
chmod +x deploy_centos.sh

echo "Deployment script created. Running it now..."
./deploy_centos.sh