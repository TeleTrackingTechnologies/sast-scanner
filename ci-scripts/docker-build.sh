#!/usr/bin/env bash

set -euo pipefail

IMAGE="teletracking/$(echo $1 | tr [A-Z] [a-z] | xargs basename)"
VERSION=$(semversioner current-version)

docker build --target bb-pipe -t "${IMAGE}/bb-pipe:latest" -t "${IMAGE}/bb-pipe:${VERSION}" .
docker build --target cci-orb -t "${IMAGE}/cci-orb:latest" -t "${IMAGE}/cci-orb:${VERSION}" .
