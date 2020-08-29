#!/usr/bin/env bash

set -euo pipefail

IMAGE=$(echo $1 | tr [A-Z] [a-z])
VERSION=$(semversioner current-version)

docker push "${IMAGE}/bb-pipe:latest"
docker push "${IMAGE}/bb-pipe:${VERSION}"

docker push "${IMAGE}/cci-orb:latest"
docker push "${IMAGE}/cci-orb:${VERSION}"
