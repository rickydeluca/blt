#!/usr/bin/env bas
#
# Load a Docker image from a .tar archive.
#

# Export variables in .env
set -a
if [[ -f docker/.env ]]; then
  source docker/.env
fi
set +a

# Check if the tar archive path is given
if [ $# -lt 1 ]; then
  echo "Usage: $0 <archive-file.tar> [output-image-name]"
  exit 1
fi

ARCHIVE_FILE="$1"
OUTPUT_NAME="$2"

# If no explicit output name is given, use the image name defined in .env
if [ -z "$OUTPUT_NAME" ] && [ -n "$IMAGE_NAME" ]; then
  OUTPUT_NAME="$IMAGE_NAME"
fi

# Verify the archive exists
if [ ! -f "$ARCHIVE_FILE" ]; then
  echo "Error: File '$ARCHIVE_FILE' does not exist."
  exit 2
fi

echo "Loading Docker image from '$ARCHIVE_FILE'..."

# Load the image
if [ -n "$OUTPUT_NAME" ]; then
  # Load and retag if an output name is provided
  docker load -i "$ARCHIVE_FILE" \
    | sed -n 's/^Loaded image: //p' \
    | xargs -I {} docker tag {} "$OUTPUT_NAME"
else
  # Otherwise, standard load
  docker load -i "$ARCHIVE_FILE"
fi

echo "Image loaded successfully. You can list images with:"
echo "  docker images"
