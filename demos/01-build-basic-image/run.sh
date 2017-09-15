#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Build the basic image
echo "Building image..."
docker build -f ${DIR}/dockerfile -t image-demo-01 .
echo ""
read

# Run the basic image
echo "Starting Demo 01 image..."
docker run --rm image-demo-01
