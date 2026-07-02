#!/usr/bin/env bash
# ============================================================================
# package.sh — zip each merged skill (public + private overlay) for
# upload to claude.ai as a custom skill.
#
# Runs deploy.sh into a scratch directory first (so the zips reflect the
# fully merged skill, not just the public placeholder content), then zips
# each top-level skill folder independently.
#
# Usage:
#   ./scripts/package.sh [--out <dir>]
# ============================================================================
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="$REPO_ROOT/dist"
SCRATCH="$(mktemp -d)"
trap 'rm -rf "$SCRATCH"' EXIT

while [[ $# -gt 0 ]]; do
  case "$1" in
    --out) OUT_DIR="$2"; shift 2 ;;
    *) echo "Unknown argument: $1" >&2; exit 1 ;;
  esac
done

echo "==> Merging skills into scratch dir: $SCRATCH"
"$REPO_ROOT/scripts/deploy.sh" --target "$SCRATCH"

mkdir -p "$OUT_DIR"
echo
echo "==> Packaging zips into $OUT_DIR"
for skill_dir in "$SCRATCH"/*/; do
  [ -d "$skill_dir" ] || continue
  name="$(basename "$skill_dir")"
  zip_path="$OUT_DIR/${name}.zip"
  rm -f "$zip_path"
  (cd "$SCRATCH" && zip -rq "$zip_path" "$name")
  echo "    $zip_path"
done

echo
echo "==> Done. Upload the .zip files in $OUT_DIR to claude.ai as custom skills."
