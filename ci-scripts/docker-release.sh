#!/usr/bin/env bash

set -euo pipefail

IMAGE=$(echo $1 | tr [A-F] [a-f])
VERSION=$(semversioner current-version)

docker build --target bb-pipe -t "${IMAGE}/bb-pipe:latest" -t "${IMAGE}/bb-pipe:${VERSION}" .
docker build --target cci-orb -t "${IMAGE}/cci-orb:latest" -t "${IMAGE}/cci-orb:${VERSION}" .


docker push "${IMAGE}/bb-pipe:latest"
docker push "${IMAGE}/bb-pipe:${VERSION}"

docker push "${IMAGE}/cci-pipe:latest"
docker push "${IMAGE}/cci-pipe:${VERSION}"
