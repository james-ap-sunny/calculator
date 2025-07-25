# Troubleshooting Guide for Calculator in Ubuntu

This guide provides solutions for common issues when running the calculator application in Ubuntu environments.

## Common Issues and Solutions

### 1. Docker Installation Issues

If you're having trouble with Docker:

```bash
# Install Docker on Ubuntu
sudo apt update
sudo apt install -y docker.io docker-compose

# Add your user to the docker group to run Docker without sudo
sudo usermod -aG docker $USER

# Log out and log back in for the group changes to take effect
# Or run this command to apply changes in the current session:
newgrp docker
```

### 2. Permission Issues

If you encounter permission issues:

```bash
# Make sure all files have the correct permissions
chmod +x calculator.py
chmod +x start.sh  # If you've extracted this file from the Docker container
```

### 3. Port Conflicts

If ports 8080 or 5900 are already in use:

```bash
# Check what's using the ports
sudo lsof -i :8080
sudo lsof -i :5900

# Modify docker-compose.yml to use different ports if needed
# For example, change "8080:8080" to "8081:8080"
```

### 4. Display Issues

If you're trying to run the application directly on Ubuntu (without Docker):

```bash
# Install required packages
sudo apt update
sudo apt install -y python3-tk

# Set the DISPLAY variable if running in a headless environment
export DISPLAY=:0

# Run the application
python3 calculator.py
```

### 5. Docker Container Not Starting

If the Docker container fails to start:

```bash
# Check container logs
docker logs $(docker ps -qf "name=calculator")

# Run the container in interactive mode to debug
docker-compose run --rm calculator bash
```

### 6. noVNC Issues

If you can't access the noVNC interface:

1. Make sure the container is running:
   ```bash
   docker ps
   ```

2. Check if noVNC is listening on the correct port:
   ```bash
   docker exec -it $(docker ps -qf "name=calculator") netstat -tulpn | grep 8080
   ```

3. Try accessing with different browsers or in incognito mode.

## Running the Application

### Using Docker (Recommended)

```bash
# Build and start the container
docker-compose up -d --build

# Access the calculator via web browser at:
# http://localhost:8080/vnc.html or http://localhost:8080/
```

### Running Directly (Without Docker)

If you prefer to run without Docker:

```bash
# Install dependencies
sudo apt update
sudo apt install -y python3-tk

# Run the application
python3 calculator.py
```

## Debugging

If you're still having issues:

1. Check the Docker logs:
   ```bash
   docker-compose logs
   ```

2. Try running the container with an interactive shell:
   ```bash
   docker-compose run --rm calculator bash
   ```

3. Inside the container, you can manually start each component:
   ```bash
   Xvfb :1 -screen 0 1024x768x16 &
   export DISPLAY=:1
   x11vnc -display :1 -forever -shared &
   python3 calculator.py