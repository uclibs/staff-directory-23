#!/usr/bin/env bash
set -euo pipefail

yarn build
test -f public/build/manifest.json || { echo "manifest.json missing"; exit 1; }