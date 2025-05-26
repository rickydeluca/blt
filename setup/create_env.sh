#!/bin/bash
# Copyright (c) Meta Platforms, Inc. and affiliates.

#SBATCH --job-name=env_creation
#SBATCH --account=iacroma
#SBATCH	--partition=dev-gn
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gres=gpu:4		# Adjusted for CNR server
#SBATCH --exclusive
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64  	# Adjusted for CNR server
#SBATCH --mem=0
#SBATCH --time=01:00:00

# Exit immediately if a command exits with a non-zero status
set -e

# Start timer
start_time=$(date +%s)

# Get the current date
current_date=$(date +%y%m%d)

# Create environment name with the current date
env_prefix=blt_$current_date

# Create the conda environment
export CONDA_ROOT="/ifs/hpc/home/rdeluca/miniconda3"	# Modify to your conda installation
source $CONDA_ROOT/etc/profile.d/conda.sh
conda create -n $env_prefix python=3.12 -y
conda activate $env_prefix

echo "Currently in env $(which python)"

# Install packages
pip install --pre torch --index-url https://download.pytorch.org/whl/nightly/cu121
pip install ninja
pip install -v -U git+https://github.com/facebookresearch/xformers.git@de742ec3d64bd83b1184cc043e541f15d270c148
pip install -r requirements.txt

# End timer
end_time=$(date +%s)

# Calculate elapsed time in seconds
elapsed_time=$((end_time - start_time))

# Convert elapsed time to minutes
elapsed_minutes=$((elapsed_time / 60))

echo "Environment $env_prefix created and all packages installed successfully in $elapsed_minutes minutes!"
