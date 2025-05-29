#!/usr/bin/env bash

#SBATCH --job-name=docker_image_building
#SBATCH --account=iacroma
#SBATCH --partition=dev-gn
#SBATCH --nodelist=gnode02
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gres=gpu:4            # Adjusted for CNR server
#SBATCH --exclusive
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64      # Adjusted for CNR server
#SBATCH --mem=0
#SBATCH --time=01:00:00

# Exit immediately if a command exits with a non-zero status.
set -e

# Automatically export every variable defined in .env
set -a
if [[ -f docker/.env ]]; then
  source docker/.env
fi
set +a

echo "Creating container: ${CONTAINER_NAME}"

# Run
docker run -it -d --gpus all --name $CONTAINER_NAME $IMAGE_NAME
