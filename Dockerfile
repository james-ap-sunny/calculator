FROM python:3.9-slim

# Install required packages
RUN apt-get update && apt-get install -y \
    python3-tk \
    xvfb \
    x11vnc \
    novnc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /app

# Copy application files
COPY calculator.py .
COPY calculator_engine.py .
COPY calculator_gui.py .
COPY requirements.txt .
COPY tests/ ./tests/

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set up noVNC
RUN mkdir -p /usr/share/novnc
RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# Expose ports for noVNC
EXPOSE 8080 5900

# Create startup script
RUN echo '#!/bin/bash\n\
Xvfb :1 -screen 0 1024x768x16 &\n\
export DISPLAY=:1\n\
x11vnc -display :1 -forever -shared &\n\
/usr/share/novnc/utils/launch.sh --vnc localhost:5900 --listen 8080 &\n\
python3 calculator.py\n\
' > /app/start.sh && chmod +x /app/start.sh

# Set the entrypoint
ENTRYPOINT ["/app/start.sh"]