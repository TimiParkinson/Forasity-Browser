#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./scripts/apply.sh /path/to/chromium/src
#
# Example:
#   ./scripts/apply.sh ~/work/chromium/src

SRC_DIR="${1:-}"
if [[ -z "$SRC_DIR" ]]; then
  echo "Usage: $0 /path/to/chromium/src"
  exit 1
fi

if [[ ! -d "$SRC_DIR/.git" ]]; then
  echo "Error: $SRC_DIR is not a git repo (expected chromium/src)"
  exit 1
fi

PATCH_DIR="$(cd "$(dirname "$0")/.." && pwd)/patches"

cd "$SRC_DIR"

echo "==> Resetting to upstream origin/main"
git fetch origin
git checkout -B forasity-work origin/main

echo "==> Applying patches from $PATCH_DIR"
shopt -s nullglob
PATCHES=("$PATCH_DIR"/*.patch)
if (( ${#PATCHES[@]} == 0 )); then
  echo "No patches found in $PATCH_DIR"
  exit 0
fi

git am --3way "${PATCHES[@]}"

echo "==> Done. Current branch: $(git branch --show-current)"
echo "==> Next: gn gen out/Default && autoninja -C out/Default chrome"
