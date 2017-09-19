#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"

echo "Listing base images..."
docker run --rm -t \
    -v ${DIR}/dockerfiles:/tmp/docker-build/dockerfiles \
    -v ${DIR}/deployments:/tmp/docker-build/deployments \
    docker-automatic-build-demo-02 \
    docker-automatic-build -v -d /tmp/docker-build/ list-base-images
echo ""
echo "Press ENTER to continue"
read

echo "Building base images..."
docker run --rm -t \
    -v ${DIR}/dockerfiles:/tmp/docker-build/dockerfiles \
    -v ${DIR}/deployments:/tmp/docker-build/deployments \
    -v /var/run/docker.sock:/var/run/docker.sock \
    docker-automatic-build-demo-02 \
    docker-automatic-build -vvv -d /tmp/docker-build/ -p local build-base-images -t latest --local-only \
    && echo "Build complete"
echo ""
echo "Press ENTER to continue"
read

echo "Listing deployments..."
docker run --rm -t \
    -v ${DIR}/dockerfiles:/tmp/docker-build/dockerfiles \
    -v ${DIR}/deployments:/tmp/docker-build/deployments \
    docker-automatic-build-demo-02 \
    docker-automatic-build -v -d /tmp/docker-build/ list-deployments
echo ""
echo "Press ENTER to continue"
read

echo "Building deployment..."
docker run --rm -t \
    -v ${DIR}/dockerfiles:/tmp/docker-build/dockerfiles \
    -v ${DIR}/deployments:/tmp/docker-build/deployments \
    -v /var/run/docker.sock:/var/run/docker.sock \
    docker-automatic-build-demo-02 \
    docker-automatic-build -vvv -d /tmp/docker-build/ -p local build-deployment -t latest basic-website --local-only \
    && echo "Build complete"
echo ""
echo "Press ENTER to continue"
read

echo "Starting Webserver..."
echo "Serving on http://localhost:9080"
echo "Press CTL+C to kill web server"
docker run --rm -p 9080:80 local/deployments/basic-website
echo ""
echo "DEMO COMPLETE"
