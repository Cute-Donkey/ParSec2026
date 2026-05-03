FROM mcr.microsoft.com/devcontainers/dotnet:8.0

USER root

# Install Godot 4 dependencies and Godot itself
RUN apt-get update && apt-get install -y --no-install-recommends \
    libvulkan1 \
    libvulkan-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libx11-dev \
    libxcursor-dev \
    libxext-dev \
    libxi-dev \
    libxinerama-dev \
    libxrandr-dev \
    libxrender-dev \
    binutils \
    pkg-config \
    wget \
    unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Download and install Godot 4.2
RUN wget -O /tmp/godot-linux.x86_64.zip \
    https://github.com/godotengine/godot/releases/download/4.2-stable/godot-4.2-stable-linux.x86_64.zip \
    && unzip /tmp/godot-linux.x86_64.zip -d /opt/godot \
    && chmod +x /opt/godot/Godot \
    && ln -s /opt/godot/Godot /usr/local/bin/godot \
    && rm /tmp/godot-linux.x86_64.zip

# Switch back to vscode user
USER vscode
