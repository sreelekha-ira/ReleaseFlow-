#!/usr/bin/env bash
set -euo pipefail
NAMESPACE=${1:-releaseflow}
DEPLOYMENT=${2:-releaseflow-app}
REV=${3:-1}
kubectl -n $NAMESPACE rollout undo deployment/$DEPLOYMENT --to-revision=$REV
kubectl -n $NAMESPACE rollout status deployment/$DEPLOYMENT
echo "Rollback executed to revision $REV"
