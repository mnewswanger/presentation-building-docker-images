#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"

# Build the basic image
echo "Building automatic build tool image..."
docker build -f ${DIR}/dockerfiles/docker-automatic-build -t docker-automatic-build-demo-02 ${DIR}
echo ""
echo "Press ENTER to continue"
read

# Run the basic image
echo "Starting Demo 02 image..."
docker run --rm docker-automatic-build-demo-02 /usr/local/bin/docker-automatic-build -h
echo ""
echo "Press ENTER to continue"
read

# Build the inspection image
echo "Building inspection image..."
docker build -f ${DIR}/dockerfiles/docker-inspector -t docker-inspector-demo-02 ${DIR}
echo ""

echo "Inspecting images..."
# Inspect the images
echo "Base docker alpine image size:"
docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    docker-inspector-demo-02 \
    /bin/bash -c '/human-readable-file-size.sh "$(docker inspect -f {{.Size}} docker)"'
echo "Automatic Build Tool image"
docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    docker-inspector-demo-02 \
    /bin/bash -c '/human-readable-file-size.sh "$(docker inspect -f {{.Size}} docker-automatic-build-demo-02)"'
echo ""
echo "DEMO COMPLETE"
