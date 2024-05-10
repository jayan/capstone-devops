#!/bin/bash

# Docker Hub username
DOCKER_USERNAME="cjayanth"

# Check the argument passed
if [[ "$1" == "devchanged" ]]; then
    echo "Tagging and pushing image to dev repository..."
    # Define the IMAGE_COUNT variable (assuming it is calculated in another script)
    IMAGE_COUNT=1  # Example value, replace with actual calculation
    docker tag "react${IMAGE_COUNT}:latest" "${DOCKER_USERNAME}/dev:latest"
    docker push "${DOCKER_USERNAME}/dev:latest"
elif [[ "$1" == "devmergedmaster" ]]; then
    echo "Tagging and pushing image to prod repository..."
    # Define the IMAGE_COUNT variable (assuming it is calculated in another script)
    IMAGE_COUNT=1  # Example value, replace with actual calculation
    docker tag "react${IMAGE_COUNT}:latest" "${DOCKER_USERNAME}/prod:latest"
    docker push "${DOCKER_USERNAME}/prod:latest"
else
    echo "Invalid argument. Please provide either 'devchanged' or 'devmergedmaster'."
    exit 1
fi

