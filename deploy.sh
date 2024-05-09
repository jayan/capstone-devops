#!/bin/bash


# Docker Hub username
DOCKER_USERNAME="cjayanth"

# Docker Hub access token
DOCKER_ACCESS_TOKEN="dckr_pat_G-VP6hpzdsyNUmpS3gLwKUEyk4A"

# Log in to Docker Hub using access token
docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_ACCESS_TOKEN}"

# Check the argument passed
if [[ "$1" == "devchanged" ]]; then
    echo "Tagging and pushing image to dev repository..."
    docker tag nginx:latest dev:latest
    docker push dev:latest
elif [[ "$1" == "devmergedmaster" ]]; then
    echo "Tagging and pushing image to prod repository..."
    docker tag nginx:latest prod:latest
    docker push nginx:latest
else
    echo "Invalid argument. Please provide either 'devchanged' or 'devmergedmaster'."
    exit 1
fi
