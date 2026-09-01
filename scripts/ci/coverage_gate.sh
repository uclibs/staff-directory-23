#!/usr/bin/env bash
set -euo pipefail

# Read coverage from SimpleCov's canonical summary (.last_run.json) rather than
# scraping the HTML report. The HTML layout is not a stable contract and changed
# in SimpleCov 1.x, which no longer renders a plain "NN.NN%" string. Artifact
# extraction can place the file at either coverage/.last_run.json or ./.last_run.json.
if [ -f coverage/.last_run.json ]; then
  LAST_RUN_PATH="coverage/.last_run.json"
elif [ -f .last_run.json ]; then
  LAST_RUN_PATH=".last_run.json"
else
  echo "SimpleCov summary .last_run.json not found."
  find . -maxdepth 3 -name '.last_run.json' -print || true
  exit 1
fi

# Extract the line-coverage percentage (e.g. 89.76) without depending on jq.
COVERAGE=$(grep -oE '"line"[[:space:]]*:[[:space:]]*[0-9]+(\.[0-9]+)?' "$LAST_RUN_PATH" \
  | grep -oE '[0-9]+(\.[0-9]+)?' | head -n1)
if [ -z "$COVERAGE" ]; then
  echo "Unable to parse line coverage from $LAST_RUN_PATH"
  cat "$LAST_RUN_PATH"
  exit 1
fi
echo "Current coverage: $COVERAGE%"

BASELINE_PATH="coverage/coverage_baseline.txt"
if [ ! -f "$BASELINE_PATH" ] && [ -f coverage_baseline.txt ]; then
  BASELINE_PATH="coverage_baseline.txt"
fi

if [ ! -f "$BASELINE_PATH" ]; then
  echo "Coverage baseline file not found. Expected coverage/coverage_baseline.txt"
  exit 1
fi

BASELINE=$(cat "$BASELINE_PATH")
echo "Baseline coverage: $BASELINE%"

if (( $(echo "$COVERAGE < $BASELINE" | bc -l) )); then
  echo "Coverage dropped: $COVERAGE% < $BASELINE%"
  exit 1
fi

if (( $(echo "$COVERAGE > $BASELINE" | bc -l) )); then
  echo "Coverage increased to $COVERAGE% - updating baseline"
  echo "$COVERAGE" > "$BASELINE_PATH"
  if [[ -n "${GITHUB_HEAD_REF:-}" ]]; then
    git add "$BASELINE_PATH"
    git -c user.name="ci-bot" -c user.email="ci-bot@example.com" commit -m "ci: update coverage baseline to $COVERAGE%" || true
    if ! git push origin "HEAD:${GITHUB_HEAD_REF}"; then
      echo "Skipping baseline push; likely fork PR or restricted token permissions."
    fi
  else
    echo "Skipping baseline commit/push; not running in a PR head ref context."
  fi
else
  echo "Coverage unchanged at $COVERAGE%"
fi
