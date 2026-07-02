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

## Bundled Files

| File | When to read |
|---|---|
| `assets/icons/index.md` | Always, before drawing anything |
| `references/mermaid-conventions.md` | Any Mermaid diagram (flow/sequence/state/gantt) |
| `scripts/render-mermaid.sh` | Rendering any Mermaid diagram to SVG/PNG |
