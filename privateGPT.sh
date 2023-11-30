#!/bin/bash
# Depensencies
codx python_311

# Dependencies to build llama-cpp
sudo apt update && apt install -y \
  libopenblas-dev\
  ninja-build\
  build-essential\
  pkg-config\
  wget

# Clone repository
mkdir -p ${CODX_APPS}/privateGPT
cd ${CODX_APPS}/privateGPT
# Clones repository
git clone --depth 1 -b main https://github.com/gbrian/privateGPT.git ${CODX_APPS}/privateGPT

# Install poetry
pip install pipx
python3 -m pipx ensurepath
pipx install poetry
export PATH="/root/.local/bin:$PATH"

# Set environment variable for poetry
export POETRY_VIRTUALENVS_IN_PROJECT=true

# Check if .env file exists, create virtual environment if not
if [ ! -f $PWD/.env ]; then
  poetry env use python3
fi

poetry install --with local
poetry install --with ui

# App stage
export PYTHONUNBUFFERED=1
export PORT=6080

# Switch to non-root user
echo "alias private-gpt='${CODX_APPS}/privateGPT/.venv/bin/python -m private_gpt'" >> ~/.bashrc
