---
name: solution-diagrams
description: "Icon library and diagram conventions for architecture diagrams, flowcharts, sequence diagrams, and state diagrams in [FIRM_NAME] deliverables. Use this skill whenever a request needs a diagram embedded in a deck, SOW, or estimate — 'architecture diagram', 'solution diagram', 'draw the flow', 'sequence diagram', 'how does data move through', 'draw the integration', 'show the system topology', 'diagram this for the client'. Should be used alongside deck-styles (for decks) or sow-formats (for documents) — this skill governs the diagram itself, the other skill governs how it's embedded and how much slide/page real estate it gets."
---

# Solution Diagrams

This skill defines how diagrams get built for any deliverable — deck, SOW, or estimate appendix.
It has two tools depending on diagram type, and a shared icon library both draw from.

## Step 1 — Always Check the Icon Index First

Before drawing anything, read `assets/icons/index.md`. If an icon exists for a system, platform, or
concept you need, use it. Don't invent an ad hoc icon for something already in the library, and
don't draw a generic box when a proper icon exists — the icon library is what makes diagrams look
considered rather than improvised.

## Step 1.5 — Generating a Missing Icon or Illustration (fal.ai)

If no icon exists for a concept you need, and a plain labelled box genuinely isn't good enough (e.g.
a cover-slide hero illustration, a bespoke concept icon, a custom vector motif), generate one via
`scripts/generate-fal-asset.py` rather than improvising a rough shape by hand.

**Requires `FAL_KEY` in the environment** — get one from https://fal.ai/dashboard/keys and export it
in your shell (`export FAL_KEY=...`). Never paste the key into a prompt or hardcode it in any file.

| Need | Command |
|---|---|
| A true SVG icon/vector from a text prompt | `scripts/generate-fal-asset.py --mode text-to-vector --prompt "..." --out icon.svg --colors "#HEX1,#HEX2"` |
| A raster hero image/illustration from a text prompt | `scripts/generate-fal-asset.py --mode text-to-image --prompt "..." --out hero.png --style digital_illustration` |
| Converting an existing raster (e.g. an uploaded logo) into a true SVG | `scripts/generate-fal-asset.py --mode vectorize --image-url <public-url> --out result.svg` |

Pass `--colors` with the active `brand-core` palette hex values so generated assets land close to
on-brand from the start — still run them through the Quality Checkpoint afterward, since generated
output needs the same visual QA as anything else.

`--mode text-to-image --style vector_illustration` produces a *raster* styled to look like a vector
— it is not an actual SVG. If you need a real, editable vector file, use `--mode text-to-vector`
instead.

Once a generated asset earns its place as a recurring element, add it to `assets/icons/` (in the
appropriate category folder) and update `assets/icons/index.md` — don't regenerate the same icon
from scratch on every future use.

## Step 2 — Pick the Right Tool for the Diagram Type

| You're drawing... | Use |
|---|---|
| A process, decision flow, or activity sequence | **Mermaid** (`flowchart`) — see `references/mermaid-conventions.md` |
| A sequence of calls between systems/actors over time | **Mermaid** (`sequenceDiagram`) |
| A state machine or lifecycle | **Mermaid** (`stateDiagram-v2`) |
| A system/component architecture (boxes and connections, no time axis) | **Native shapes + icon library** — build directly in the target tool (SVG for documents, native shapes for decks) |
| A timeline/Gantt view | **Mermaid** (`gantt`) |

The dividing line: if the diagram has a *time or sequence axis*, it's Mermaid. If it's a *static
topology* (what talks to what, not in what order), it's native shapes + icons.

## Step 3 — Render and Embed

- **Mermaid diagrams**: always render via `scripts/render-mermaid.sh` before embedding — never embed
  raw Mermaid syntax into a final deliverable. The script applies the firm's themed colours
  automatically. **For a PowerPoint deck, render to PNG, not SVG** — deck-building libraries commonly
  don't rasterize SVG correctly on embed, producing a broken image in non-Microsoft viewers; SVG is
  fine for Word/document embeds. See `references/mermaid-conventions.md` for syntax conventions,
  theming detail, and the flowchart/sequence/state-specific rules.
- **Architecture diagrams**: build as SVG (for documents) or native shapes (for decks), using icons
  from `assets/icons/`, recoloured to the active brand palette (`brand-core`). Convert SVG to PNG at
  high resolution (1600px+ wide) for crisp embedding in Word/PowerPoint.
- Every diagram should be **self-contained and self-explanatory** — a reader who sees it out of
  context (forwarded, projected, screenshotted) should be able to follow it without the surrounding
  prose. Always title the diagram and label every major element.

## Architecture Diagram Structure Convention

Most solution architecture diagrams follow a left-to-right (or top-to-bottom) structure:

1. **Sources** — leftmost/topmost, the systems data or requests originate from
2. **Processing/platform** — the middle, what the deliverable is actually proposing to build
3. **Consumption** — rightmost/bottommost, where outputs land or who/what uses them

Use the icon library for recognisable systems (cloud platforms, databases, identity providers) and
plain labelled boxes for anything bespoke or client-specific that has no generic icon.

## Common Mistakes to Avoid

- **Don't skip brand-core's Quality Checkpoint.** Every diagram, once embedded, must be rendered
  and visually inspected for overlap between connectors/arrows and other elements before it's
  reported as ready — see `brand-core/SKILL.md`'s "Quality Checkpoint (Mandatory)" section.

- **Don't skip the icon index check.** A diagram that mixes "proper icon" and "improvised box" styles
  for the same category of thing (e.g. one cloud provider has an icon, another is just a rectangle)
  looks unfinished.
- **Don't use Mermaid for static architecture.** Mermaid's flowchart layout engine doesn't give you
  the control needed for a polished architecture diagram — use native shapes instead.
- **Don't embed raw Mermaid markup.** Always render to SVG/PNG first; not every downstream viewer
  (Word, PowerPoint, PDF) renders Mermaid natively.
- **Don't leave a diagram unthemed.** Default Mermaid colours or un-recoloured default icon colours
  are an immediate visual tell that a diagram wasn't finished — always apply the brand palette.
- **Don't let a diagram require the surrounding prose to make sense.** If you have to explain what a
  diagram means before showing it, the diagram itself needs another labelling pass.
- **Don't reach for `generate-fal-asset.py` before checking the icon index.** Generation is the
  fallback for a genuine gap, not the default path — reuse before you generate.
- **Don't ask the user for their fal.ai API key in chat.** It must be set as an environment
  variable (`FAL_KEY`) on their machine; never handle the raw key value directly.

## Bundled Files

| File | When to read |
|---|---|
| `assets/icons/index.md` | Always, before drawing anything |
| `references/mermaid-conventions.md` | Any Mermaid diagram (flow/sequence/state/gantt) |
| `scripts/render-mermaid.sh` | Rendering any Mermaid diagram to SVG/PNG |
| `scripts/generate-fal-asset.py` | Generating a missing icon, vector, or illustration when nothing suitable exists in the icon library |
