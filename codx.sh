#!/bin/bash

# Exit immediately if a command fails, or if an uninitialized variable is used
set -euo pipefail

COMMAND="${1:-}"
CODX_APPS="$HOME/codx-cli"

# 1. Handle the fallback installer logic first if NO command is provided
if [ -z "$COMMAND" ]; then
  echo "No command provided. Running installer..."
  
  sudo apt update
  sudo apt install -y git wget
  
  # Ensure clean clone path
  rm -rf "$CODX_APPS"
  git clone https://github.com/gbrian/codx-cli.git "$CODX_APPS"
  chmod +x "$CODX_APPS/codx.sh"
  
  # Update symlink securely
  sudo rm -f /usr/local/bin/codx
  sudo ln -s "$CODX_APPS/codx.sh" /usr/local/bin/codx
  echo "Installation complete!"
  exit 0
fi

# Shift arguments only if a command was actually passed
shift

echo "codx running command $COMMAND"

# 2. Update logic
if [ "$COMMAND" = "--update" ]; then
  # Verify directory exists before attempting cd
  if [ ! -d "$CODX_APPS" ]; then
    echo "Error: $CODX_APPS directory does not exist." >&2
    exit 1
  fi
  cd "$CODX_APPS"
  sudo git config --global --add safe.directory "$CODX_APPS"
  sudo git pull
  exit 0
fi

# 3. List logic
if [ "$COMMAND" = "--list" ]; then
  # Avoid glob failures if no .sh files exist
  if compgen -G "${CODX_APPS}/*.sh" > /dev/null; then
    basename --suffix=.sh -- "${CODX_APPS}"/*.sh
  else
    echo "No .sh script applications found."
  fi
  exit 0
fi

echo "Executing codx $COMMAND"

# 4. Version check (POSIX uniform '=' operator)
if [ "$COMMAND" = "--version" ] || [ "$COMMAND" = "-v" ]; then
  echo "codx ver 0.1"
  exit 0
fi

# 5. Application script execution
SCRIPT_PATH="$CODX_APPS/${COMMAND}.sh"
if [ -f "$SCRIPT_PATH" ]; then 
  # Safe execution context using double quotes for all passed arguments
  (cd "$HOME" && bash "$SCRIPT_PATH" "$@")
  exit 0
else
  echo "Error: Command script '$COMMAND' not found at $SCRIPT_PATH" >&2
  exit 1
fi
