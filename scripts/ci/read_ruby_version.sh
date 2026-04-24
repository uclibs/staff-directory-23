#!/usr/bin/env bash
set -euo pipefail

# Read the Ruby version from .ruby-version and output for GitHub Actions
RUBY_VERSION=$(cat .ruby-version)
echo "ruby_version=$RUBY_VERSION" >> "$GITHUB_OUTPUT"
