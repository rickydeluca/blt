#!/usr/bin/env bash
set -euo pipefail

# Export environemnt variables
set -a
if [[ -f docker/.env ]]; then
  source docker/.env
fi
set +a

# Login to huggingface
huggingface-cli login --token $HF_TOKEN

# Download model weights
echo ">>> Downloading model weights..."
python download_model_weights.py

# Run container's main command
exec "$@"
