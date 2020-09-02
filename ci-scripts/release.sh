#!/usr/bin/env bash

set -euo pipefail

IMAGE="teletracking/$(echo $1 | tr [A-Z] [a-z] | xargs basename)"
VERSION=$(semversioner current-version)

docker push "teletracking/${IMAGE}/bb-pipe:latest"
docker push "teletracking/${IMAGE}/bb-pipe:${VERSION}"

docker push "teletracking/${IMAGE}/cci-orb:latest"
docker push "teletracking/${IMAGE}/cci-orb:${VERSION}"
