#!/bin/bash

# Check if llmlite directory exists, create if not
if [ ! -d llmlite ]; then
  echo "Creating directory llmlite..."
  mkdir -p llmlite
fi

cd llmlite

# Check if virtual environment exists, create if not
if [ ! -d venv ]; then
  echo "Creating virtual environment..."
  python3 -m venv venv
  # Install LiteLLM CLI
  source venv/bin/activate
  echo "Installing LiteLLM CLI..."
  pip install 'litellm[proxy]'
fi

# Activate virtual environment
source venv/bin/activate

function create_config() {
  echo "Creating config.yaml for OpenAI gpt-4 model..."
  cat <<EOF > config.yaml
  model_list:
    - model_name: gpt-4
      litellm_params:
        model: openai/gpt-4
        api_key: os.environ/OPENAI_API_KEY
        api_base: https://api.openai.com/v1
  EOF
}

# Check if config.yaml exists, create if not
if [ ! -f config.yaml ]; then
  create_config
fi

echo "Starting LiteLLM Proxy with config.yaml..."
litellm --config config.yaml --detailed_debug
