#!/usr/bin/env bash
set -euo pipefail
REGISTRY=${1:-docker.io/youruser}
REPO=${2:-releaseflow-app}
TAG=${3:-latest}
IMAGE="$REGISTRY/$REPO:$TAG"
echo "Building $IMAGE"
docker build -t $IMAGE .
echo "Pushing $IMAGE"
docker push $IMAGE
echo "Done"
