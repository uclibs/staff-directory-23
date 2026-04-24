#!/usr/bin/env bash
set -euo pipefail

mkdir -p tmp
set +e
bundle exec bundler-audit check --update > tmp/bundler-audit-output.txt
AUDIT_EXIT=$?
set -e
if [ $AUDIT_EXIT -ne 0 ] && [ $AUDIT_EXIT -ne 1 ]; then
  echo "bundler-audit failed unexpectedly (exit code $AUDIT_EXIT)"
  exit $AUDIT_EXIT
fi
if grep -Eq '^Criticality:\s*(Critical|High)' tmp/bundler-audit-output.txt; then
  echo "High or Critical vulnerabilities detected."
  cat tmp/bundler-audit-output.txt
  exit 1
fi
