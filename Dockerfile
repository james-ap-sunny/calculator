FROM python:3.9-slim

# Install required packages
RUN apt-get update && apt-get install -y \
    python3-tk \
    xvfb \
    x11vnc \
    novnc \
    wget \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /app

# Copy application files
COPY calculator.py .
COPY calculator_engine.py .
COPY calculator_gui.py .
COPY requirements.txt .

# Install Python dependencies (if any)
RUN pip install --no-cache-dir -r requirements.txt

# Set up noVNC - handle different installation paths
RUN if [ ! -f /usr/share/novnc/utils/launch.sh ]; then \
        if [ -f /usr/share/novnc/utils/novnc_proxy ]; then \
            ln -s /usr/share/novnc/utils/novnc_proxy /usr/share/novnc/utils/launch.sh; \
        else \
            mkdir -p /usr/local/novnc/utils && \
            git clone https://github.com/novnc/noVNC.git /usr/local/novnc && \
            ln -s /usr/local/novnc/utils/launch.sh /usr/share/novnc/utils/launch.sh; \
        fi; \
    fi

# Ensure index.html exists
RUN if [ ! -f /usr/share/novnc/index.html ]; then \
        if [ -f /usr/share/novnc/vnc.html ]; then \
            ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html; \
        elif [ -f /usr/local/novnc/vnc.html ]; then \
            mkdir -p /usr/share/novnc && \
            ln -s /usr/local/novnc/vnc.html /usr/share/novnc/index.html; \
        fi; \
    fi

# Expose ports for noVNC
EXPOSE 8080 5900

# Create startup script with error handling
RUN echo '#!/bin/bash\n\
set -e\n\
echo "Starting Xvfb..."\n\
Xvfb :1 -screen 0 1024x768x16 &\n\
sleep 1\n\
export DISPLAY=:1\n\
echo "Starting x11vnc..."\n\
x11vnc -display :1 -forever -shared &\n\
sleep 1\n\
echo "Starting noVNC..."\n\
if [ -f /usr/share/novnc/utils/launch.sh ]; then\n\
    /usr/share/novnc/utils/launch.sh --vnc localhost:5900 --listen 8080 &\n\
elif [ -f /usr/local/novnc/utils/launch.sh ]; then\n\
    /usr/local/novnc/utils/launch.sh --vnc localhost:5900 --listen 8080 &\n\
elif [ -f /usr/share/novnc/utils/novnc_proxy ]; then\n\
    /usr/share/novnc/utils/novnc_proxy --vnc localhost:5900 --listen 8080 &\n\
else\n\
    echo "Error: Could not find noVNC launch script"\n\
    exit 1\n\
fi\n\
sleep 1\n\
echo "Starting calculator application..."\n\
python3 calculator.py\n\
' > /app/start.sh && chmod +x /app/start.sh

# Set the entrypoint
ENTRYPOINT ["/app/start.sh"]
