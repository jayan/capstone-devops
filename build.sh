#!/bin/bash

# Incremented count for image name
IMAGE_COUNT=$(($(docker images | grep -c "^react") + 1))

# Build and tag the Docker image
docker build -t react${IMAGE_COUNT} .
