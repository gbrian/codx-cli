#!/bin/bash

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
mkdir -p /home/worker/app
cd /home/worker/app
gir clone --depth 1 -b main https://github.com/gbrian/privateGPT.git /home/worker/app
cp $PWD/pyproject.toml $PWD/poetry.lock ./
poetry install --with local
poetry install --with ui

# App stage
export PYTHONUNBUFFERED=1
export PORT=6080

# Prepare a non-root user
adduser --system worker
mkdir -p /home/worker/app
chown worker /home/worker/app
cd /home/worker/app
mkdir local_data; chown worker local_data
mkdir models; chown worker models

# Copy files and directories
cp --preserve=timestamps --recursive --update $PWD/.venv/ .venv
cp --preserve=timestamps --recursive --update $PWD/private_gpt/ private_gpt
cp --preserve=timestamps --recursive --update $PWD/docs/ docs
cp --preserve=timestamps --update $PWD/*.yaml $PWD/*.md ./

# Change ownership
chown -R worker:worker .

# Switch to non-root user
su worker -c '.venv/bin/python -m private_gpt'
