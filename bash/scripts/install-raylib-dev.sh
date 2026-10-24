#!/usr/bin/env bash
# System development libraries for raylib's Linux X11/OpenGL backend.
set -euo pipefail
sudo apt install build-essential git
sudo apt install libasound2-dev libx11-dev libxrandr-dev libxi-dev libgl1-mesa-dev libglu1-mesa-dev libxcursor-dev libxinerama-dev libwayland-dev libxkbcommon-dev

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
    libgl-dev libx11-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev
