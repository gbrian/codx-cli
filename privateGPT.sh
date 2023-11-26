#!/bin/bash

# Clone repository
mkdir -p /home/worker/privateGPT
git clone --depth 1 -b main https://github.com/gbrian/privateGPT.git /home/worker/privateGPT

# Install poetry
pip install pipx
python3 -m pipx ensurepath
pipx install poetry
export PATH="/root/.local/bin:$PATH"

# Dependencies to build llama-cpp
apt update && apt install -y \
  libopenblas-dev\
  ninja-build\
  build-essential\
  pkg-config\
  wget

# Set environment variable for poetry
export POETRY_VIRTUALENVS_IN_PROJECT=true

# Build dependencies stage
cd /home/worker/privateGPT

# Check if .env file exists, create virtual environment if not
if [ ! -f $PWD/.env ]; then
  poetry env use python3
fi

poetry install --with local
poetry install --with ui

# App stage
export PYTHONUNBUFFERED=1
export PORT=6080

# Prepare a non-root user
adduser --system worker
chown worker /home/worker/privateGPT
mkdir local_data; chown worker local_data
mkdir models; chown worker models

# Change ownership
chown -R worker:worker .

# Switch to non-root user
su worker -c '.venv/bin/python -m private_gpt'
