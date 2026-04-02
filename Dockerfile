FROM python:3.12-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for pygame + GUI
RUN apt-get update && apt-get install -y \
    python3-pygame \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsdl2-ttf-dev \
    libglib2.0-0 \
    libsm6 libxext6 libxrender-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

# Install pygame
RUN pip install pygame

# Fix audio issue (VERY IMPORTANT)
ENV SDL_AUDIODRIVER=dummy

# Enable GUI
ENV DISPLAY=:0
ENV SDL_VIDEODRIVER=x11

CMD ["python3", "main.py"]
