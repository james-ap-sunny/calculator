# Python Calculator

A simple calculator application with a graphical user interface built using Python and Tkinter, containerized with Docker.

## Features

- Basic arithmetic operations (addition, subtraction, multiplication, division)
- Clean and intuitive user interface
- Error handling for invalid inputs and division by zero
- Docker containerization for easy deployment

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
