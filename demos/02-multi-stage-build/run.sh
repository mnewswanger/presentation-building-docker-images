#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Build the basic image
echo "Building image..."
docker build -f ${DIR}/dockerfile -t docker-automatic-build-demo-02 ${DIR}
echo ""
read

# Run the basic image
echo "Starting Demo 02 image..."
docker run --rm docker-automatic-build-demo-02 /usr/local/bin/docker-automatic-build -h
echo ""
read

# Inspect the image
docker inspect -f {{.Size}} docker-automatic-build-demo-02
