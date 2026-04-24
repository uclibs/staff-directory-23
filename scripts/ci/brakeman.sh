#!/usr/bin/env bash
set -euo pipefail

mkdir -p tmp
bundle exec brakeman --no-exit-on-warn -o tmp/brakeman-output.json
HIGH_COUNT=$(ruby -rjson -e 'data = JSON.parse(File.read("tmp/brakeman-output.json")); puts data.fetch("warnings", []).count { |w| w["confidence"] == "High" }')
echo "High confidence Brakeman findings: $HIGH_COUNT"
if [ "$HIGH_COUNT" -gt 0 ]; then
  echo "Brakeman reported high-confidence findings."
  exit 1
fi
