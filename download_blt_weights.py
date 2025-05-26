import os

import typer
from huggingface_hub import snapshot_download


def main():
    # Modified weights directory
    root_dir = "/ifs/hpc/home/rdeluca"
    local_dir = "hf-weights"
    weights_dir = os.path.join(root_dir, local_dir)

    if not os.path.exists(weights_dir):
        os.makedirs(weights_dir)
    snapshot_download(f"facebook/blt", local_dir=weights_dir)


if __name__ == "__main__":
    typer.run(main)
