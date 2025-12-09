#!/usr/bin/env bash
set -euo pipefail
NAMESPACE=${1:-releaseflow}
DEPLOYMENT=${2:-releaseflow-app}
IMAGE=${3:?"Usage: deploy.sh <image:tag>"}
echo "Deploying $IMAGE to $DEPLOYMENT in namespace $NAMESPACE"
kubectl -n $NAMESPACE set image deployment/$DEPLOYMENT $DEPLOYMENT=$IMAGE --record
kubectl -n $NAMESPACE rollout status deployment/$DEPLOYMENT --timeout=120s
echo "Deployment finished"
