#!/usr/bin/env bash

set -euo pipefail

IMAGE=$(echo $1 | tr [A-Z] [a-z])
VERSION=$(semversioner current-version)

docker build --target bb-pipe -t "teletracking/${IMAGE}/bb-pipe:latest" -t "teletracking/${IMAGE}/bb-pipe:${VERSION}" .
docker build --target cci-orb -t "teletracking/${IMAGE}/cci-orb:latest" -t "teletracking/${IMAGE}/cci-orb:${VERSION}" .
