#!/usr/bin/env bash
# ============================================================================
# deploy.sh — deep-merge skills/ + private/skills/ into ~/.claude/skills/
#
# private/skills/ wins on any file conflict. This is how the public,
# generic framework and your gitignored private overlay combine into a
# fully firm-branded set of live skills.
#
# Usage:
#   ./scripts/deploy.sh [--target <dir>]
# ============================================================================
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PUBLIC_SKILLS="$REPO_ROOT/skills"
PRIVATE_SKILLS="$REPO_ROOT/private/skills"
TARGET="${HOME}/.claude/skills"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target) TARGET="$2"; shift 2 ;;
    *) echo "Unknown argument: $1" >&2; exit 1 ;;
  esac
done

if [ ! -d "$PUBLIC_SKILLS" ]; then
  echo "!! No skills/ directory found at $PUBLIC_SKILLS" >&2
  exit 1
fi

mkdir -p "$TARGET"

echo "==> Deploying to $TARGET"
echo "==> Layer 1 (public):  $PUBLIC_SKILLS"

# Layer 1: copy public skills as the base layer
for skill_dir in "$PUBLIC_SKILLS"/*/; do
  [ -d "$skill_dir" ] || continue
  name="$(basename "$skill_dir")"
  rm -rf "${TARGET:?}/${name}"
  mkdir -p "$TARGET/$name"
  cp -R "$skill_dir." "$TARGET/$name/"
  echo "    installed $name (public)"
done

# Layer 2: overlay private skills, private wins on every conflicting file
if [ -d "$PRIVATE_SKILLS" ]; then
  echo "==> Layer 2 (private): $PRIVATE_SKILLS"
  for skill_dir in "$PRIVATE_SKILLS"/*/; do
    [ -d "$skill_dir" ] || continue
    name="$(basename "$skill_dir")"
    mkdir -p "$TARGET/$name"
    cp -R "$skill_dir." "$TARGET/$name/"
    echo "    overlaid $name (private wins on conflicts)"
  done
else
  echo "==> No private overlay found at $PRIVATE_SKILLS — deploying public content only."
  echo "    (This is expected for a fresh fork before you've set up your private/ assets.)"
fi

echo
echo "==> Deploy complete. Installed skills:"
ls -1 "$TARGET"
