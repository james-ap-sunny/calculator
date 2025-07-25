# Python Calculator

A simple calculator application with a graphical user interface built using Python and Tkinter, containerized with Docker.

## Features

- Basic arithmetic operations (addition, subtraction, multiplication, division)
- Clean and intuitive user interface
- Error handling for invalid inputs and division by zero
- Docker containerization for easy deployment

1. ubuntu 环境下，安装docker和docker-compose
sudo apt update
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker $USER
newgrp docker
---------------------------------------------------
2.运行
docker-compose up -d --build
http://43.154.22.123:8080/vnc.html

3. github常用命令
git init
git add .
git commit -m "Initial commit"
git remote set-url origin https://github.com/james-ap-sunny/calculator.git
git push -u origin main



## Docker Deployment

### Prerequisites

- Docker
- Docker Compose

### Running with Docker

1. Build and start the Docker container:
   ```
   docker-compose up -d --build
   ```

2. Access the calculator via web browser at:
   ```
   http://localhost:8080/vnc.html
   ```

3. Click the "Connect" button in the browser to access the calculator GUI.

### Stopping the Container

To stop the container:
```
docker-compose down
```

## How It Works

The Docker deployment uses:
- A Python base image with Tkinter support
- Xvfb (X Virtual Frame Buffer) to create a virtual display
- x11vnc to share the virtual display
- noVNC to provide browser-based access to the VNC server

This allows you to run the GUI application in a container and access it through your web browser.
