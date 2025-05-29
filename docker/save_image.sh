#!/usr/bin/env bash
#
# Save a Docker image to a .tar archive for later loading.
#

set -euo pipefail

# Export variables in .env
set -a
if [[ -f docker/.env ]]; then
  source docker/.env
fi
set +a

# If an image name is given, use it.
# Otherwise, use the image name defined in .env
if [[ -n "${1-}" ]]; then
  IMAGE_NAME="$1"
elif [[ -z "${IMAGE_NAME-}" ]]; then
  echo "Usage: $0 <image[:tag]> [output-file.tar]"
  exit 1
fi


# If no output filename is specified, compute it using the image name.
# Otherwise, use the given output filename.
DEFAULT_FILE="$(printf '%s' "$IMAGE_NAME" | tr '/:' '__').tar"
OUTPUT_FILE="${2:-$DEFAULT_FILE}"

echo "Saving Docker image '$IMAGE_NAME' to '$OUTPUT_FILE'..."

# Save the image (all tags/layers/metadata) into the tar archive
docker save -o "$OUTPUT_FILE" "$IMAGE_NAME"

echo "Done! You can load it later with:"
echo "  docker load -i $OUTPUT_FILE"

