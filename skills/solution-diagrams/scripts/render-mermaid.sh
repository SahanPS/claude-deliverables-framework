#!/usr/bin/env bash
# ============================================================================
# render-mermaid.sh — render a Mermaid diagram to SVG or PNG using the
# firm's themed config, via @mermaid-js/mermaid-cli (mmdc).
#
# Usage:
#   ./render-mermaid.sh <input.mmd> <output.svg|output.png> [--width N]
#
# Example:
#   ./render-mermaid.sh flow.mmd flow.svg
#   ./render-mermaid.sh sequence.mmd sequence.png --width 1600
# ============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
THEME_CONFIG="$SKILL_DIR/references/mermaid-theme.json"

if [ $# -lt 2 ]; then
  echo "Usage: $0 <input.mmd> <output.svg|output.png> [--width N]" >&2
  exit 1
fi

INPUT="$1"
OUTPUT="$2"
WIDTH=1600
shift 2 || true

while [[ $# -gt 0 ]]; do
  case "$1" in
    --width) WIDTH="$2"; shift 2 ;;
    *) echo "Unknown argument: $1" >&2; exit 1 ;;
  esac
done

if [ ! -f "$INPUT" ]; then
  echo "!! Input file not found: $INPUT" >&2
  exit 1
fi

# Generate the default themed config on first run if it doesn't exist yet.
# See references/mermaid-conventions.md for what these values mean and how
# to point them at your real brand-core palette.
if [ ! -f "$THEME_CONFIG" ]; then
  echo "==> No theme config found — writing default from mermaid-conventions.md"
  cat > "$THEME_CONFIG" <<'JSON'
{
  "theme": "base",
  "themeVariables": {
    "primaryColor": "#2563EB",
    "primaryTextColor": "#FFFFFF",
    "primaryBorderColor": "#1E293B",
    "lineColor": "#64748B",
    "secondaryColor": "#F59E0B",
    "tertiaryColor": "#10B981",
    "fontFamily": "Arial, sans-serif"
  }
}
JSON
fi

echo "==> Rendering $INPUT -> $OUTPUT (width ${WIDTH}px, theme: $THEME_CONFIG)"
npx --yes @mermaid-js/mermaid-cli -i "$INPUT" -o "$OUTPUT" -w "$WIDTH" -c "$THEME_CONFIG" -b transparent

echo "==> Done: $OUTPUT"
