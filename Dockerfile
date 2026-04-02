 7.2                        Dockerfile
FROM python:3.12-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install everything needed
RUN apt-get update && apt-get install -y \
    python3-pygame \
    xvfb \
    x11vnc \
    fluxbox \
    git \
    wget \
    net-tools \
    websockify \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsdl2-ttf-dev \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Setup noVNC properly
RUN git clone https://github.com/novnc/noVNC.git /opt/novnc && \
    git clone https://github.com/novnc/websockify.git /opt/novnc/utils/websockify

WORKDIR /app
COPY . /app

RUN pip install pygame

# Fix audio + runtime issues
ENV SDL_AUDIODRIVER=dummy
ENV DISPLAY=:1
ENV XDG_RUNTIME_DIR=/tmp/runtime-root

RUN mkdir -p /tmp/runtime-root

EXPOSE 6080

COPY start.sh /start.sh
RUN chmod +x /start.sh
