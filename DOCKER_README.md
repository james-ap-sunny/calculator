# Docker Deployment for Python Calculator

This guide explains how to deploy the Python Calculator application using Docker on Ubuntu.

## One-Click Deployment

For a quick one-click deployment on Ubuntu, run:

```bash
curl -s https://raw.githubusercontent.com/james-ap-sunny/python-calculator/master/ubuntu_docker_deploy.sh -o ubuntu_docker_deploy.sh && chmod +x ubuntu_docker_deploy.sh && ./ubuntu_docker_deploy.sh
```

This script will:
1. Install Docker and Docker Compose if they're not already installed
2. Clone the repository or update it if it already exists
3. Build and start the Docker container
4. Provide instructions for accessing the calculator

## Accessing the Calculator

After deployment, access the calculator via web browser at:
```
http://localhost:8080/vnc.html
```

Click the "Connect" button in the browser to access the calculator GUI.

## Manual Deployment

If you prefer to deploy manually:

1. Clone the repository:
   ```bash
   git clone https://github.com/james-ap-sunny/python-calculator.git
   cd python-calculator
   ```

2. Build and start the Docker container:
   ```bash
   docker-compose up -d --build
   ```

3. Access the calculator via web browser at `http://localhost:8080/vnc.html`

## Stopping the Container

To stop the container:
```bash
docker-compose down
```

## How It Works

The Docker deployment uses:
- A Python base image with Tkinter support
- Xvfb (X Virtual Frame Buffer) to create a virtual display
- x11vnc to share the virtual display
- noVNC to provide browser-based access to the VNC server

This allows you to run the GUI application in a container and access it through your web browser without needing X11 forwarding.