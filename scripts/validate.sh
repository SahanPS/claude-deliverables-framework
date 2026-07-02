#!/usr/bin/env bash
# ============================================================================
# validate.sh — lint SKILL.md frontmatter, check asset references resolve,
# and guard against private/ content ever being staged for commit.
#
# Run this before every push. Exits non-zero on any failure.
#
# Usage:
#   ./scripts/validate.sh
# ============================================================================
set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

FAILED=0

fail() {
  echo "FAIL: $1" >&2
  FAILED=1
}

# ---------------------------------------------------------------------------
# Guard 1: nothing under private/ may ever be staged or tracked
# ---------------------------------------------------------------------------
echo "==> Checking private/ is not tracked or staged..."
# private/README.md is the one intentional exception — it documents the
# overlay pattern itself and contains no firm-specific content.
PRIVATE_PATTERN='^(private/|.*-private/)'
ALLOWED_EXCEPTION='^private/README\.md$'

if git rev-parse --git-dir > /dev/null 2>&1; then
  TRACKED_PRIVATE="$(git ls-files | grep -E "$PRIVATE_PATTERN" | grep -vE "$ALLOWED_EXCEPTION" || true)"
  if [ -n "$TRACKED_PRIVATE" ]; then
    fail "private/ content is tracked by git:"
    echo "$TRACKED_PRIVATE" >&2
  fi

  STAGED_PRIVATE="$(git diff --cached --name-only | grep -E "$PRIVATE_PATTERN" | grep -vE "$ALLOWED_EXCEPTION" || true)"
  if [ -n "$STAGED_PRIVATE" ]; then
    fail "private/ content is staged for commit:"
    echo "$STAGED_PRIVATE" >&2
  fi

  if [ -z "$TRACKED_PRIVATE" ] && [ -z "$STAGED_PRIVATE" ]; then
    echo "    OK — no private/ content tracked or staged."
  fi
else
  echo "    Skipped (not a git repository)."
fi

# ---------------------------------------------------------------------------
# Guard 2: every SKILL.md has valid YAML frontmatter with name + description
# ---------------------------------------------------------------------------
echo "==> Checking SKILL.md frontmatter..."
while IFS= read -r -d '' skill_md; do
  rel="${skill_md#$REPO_ROOT/}"

  first_line="$(head -n 1 "$skill_md")"
  if [ "$first_line" != "---" ]; then
    fail "$rel — missing opening '---' frontmatter delimiter"
    continue
  fi

  frontmatter="$(awk '/^---$/{c++; next} c==1' "$skill_md")"

  if ! echo "$frontmatter" | grep -qE '^name:'; then
    fail "$rel — frontmatter missing 'name' field"
  fi
  if ! echo "$frontmatter" | grep -qE '^description:'; then
    fail "$rel — frontmatter missing 'description' field"
  fi
  echo "    checked $rel"
done < <(find skills -name 'SKILL.md' -print0)

# ---------------------------------------------------------------------------
# Guard 3: every asset/reference/script path referenced in a SKILL.md
# (as a relative path like assets/foo.png, references/foo.md, scripts/foo.sh)
# actually resolves relative to that SKILL.md's directory.
# ---------------------------------------------------------------------------
echo "==> Checking asset/reference/script paths resolve..."
while IFS= read -r -d '' skill_md; do
  skill_dir="$(dirname "$skill_md")"
  rel="${skill_md#$REPO_ROOT/}"

  refs="$(grep -oE '(assets|references|scripts)/[A-Za-z0-9_./-]+' "$skill_md" | sort -u || true)"
  while IFS= read -r ref; do
    [ -z "$ref" ] && continue
    if [ ! -e "$skill_dir/$ref" ]; then
      fail "$rel — references '$ref' which does not exist at $skill_dir/$ref"
    fi
  done <<< "$refs"
done < <(find skills -name 'SKILL.md' -print0)

echo
if [ "$FAILED" -eq 0 ]; then
  echo "==> All checks passed."
  exit 0
else
  echo "==> Validation FAILED. Fix the issues above before pushing." >&2
  exit 1
fi
