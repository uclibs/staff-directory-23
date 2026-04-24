#!/usr/bin/env bash
set -euo pipefail

yarn build

manifest_path=""
if [[ -x "bin/rails" ]]; then
  manifest_path="$(
    bin/rails runner '
      candidates = []
      candidates << (Shakapacker.config.public_manifest_path.to_s if defined?(Shakapacker) && Shakapacker.respond_to?(:config) && Shakapacker.config.respond_to?(:public_manifest_path))
      candidates << (Shakapacker.config.manifest_path.to_s if defined?(Shakapacker) && Shakapacker.respond_to?(:config) && Shakapacker.config.respond_to?(:manifest_path))
      candidates << (Shakapacker.manifest.path.to_s if defined?(Shakapacker) && Shakapacker.respond_to?(:manifest) && Shakapacker.manifest.respond_to?(:path))
      path = candidates.compact.map(&:strip).find { |value| !value.empty? }
      puts(path || "")
    ' 2>/dev/null || true
  )"
fi

if [[ -n "$manifest_path" && -f "$manifest_path" ]]; then
  echo "Manifest found at $manifest_path"
  exit 0
fi

fallback_paths=("public/packs/manifest.json")
if [[ "${RAILS_ENV:-development}" == "test" ]]; then
  fallback_paths=("public/packs-test/manifest.json" "public/packs/manifest.json")
fi

for fallback_path in "${fallback_paths[@]}"; do
  if [[ -f "$fallback_path" ]]; then
    echo "Manifest found at $fallback_path"
    exit 0
  fi
done

echo "manifest.json missing; checked Rails path '${manifest_path:-<none>}' and fallbacks: ${fallback_paths[*]}"
exit 1