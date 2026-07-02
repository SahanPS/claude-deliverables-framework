---
name: brand-core
description: "Foundational, non-negotiable brand rules for any branded business deliverable — logo usage, colour palette, typography, and cross-document conventions (confidentiality footers, signature blocks, financial-model colour coding). Load this skill FIRST whenever producing a branded deck, diagram, Statement of Work, proposal, or estimate for [FIRM_NAME] — before deck-styles, solution-diagrams, sow-formats, or estimates. Trigger phrases: 'branded deck', '[FIRM_NAME] branding', 'company colours', 'our logo', 'brand guidelines', 'client-facing document', 'proposal deck', or any request to produce a deliverable that should look like it came from [FIRM_NAME]. THIS IS A TEMPLATE FILE — replace every [FIRM_NAME] / bracketed placeholder below, and the trigger phrases in this description, with your real firm's name and nicknames before use, or override this entire file via the private overlay."
---

# Brand Core

This is the foundation layer every other skill in this framework builds on. It defines what is
**non-negotiable** about [FIRM_NAME]'s brand — the things that must never change no matter which
style variant, diagram convention, or document format gets chosen for a given deliverable.

**This file ships as a generic template.** The values below (palette, fonts, logo files) are
placeholders so the public framework is safe to fork. Your real brand values belong in the private
overlay at `private/skills/brand-core/` — see [private/README.md](../../private/README.md) for the
merge pattern. Everything downstream (deck-styles, sow-formats, estimates, solution-diagrams)
references the *tokens* defined here (e.g. "primary colour", "accent-2") rather than hardcoding
hex values, so overriding this one file re-brands everything else automatically.

## What counts as an invariant vs. a style choice

This is the single most important judgment call this framework makes, and it's worth stating
explicitly so you calibrate the same way when you extend it:

- **Invariant (this file)**: the logo, the core palette, the type family, and the handful of rules
  that protect legal/commercial documents from looking sloppy (confidentiality footers, signature
  blocks, currency/tax phrasing). These never vary by style choice or audience.
- **Style choice (deck-styles, sow-formats, solution-diagrams)**: layout grammar, density, shape
  language, which accent colour gets emphasis, prose voice, diagram visual treatment. These *should*
  vary — that's the point of this framework. Don't promote a style habit to an invariant just
  because "that's how we've always done it."

## Logo & Brand Mark

Assets live in `assets/`:

| File | Use |
|------|-----|
| `assets/logo-dark.svg` | On light/white backgrounds |
| `assets/logo-light.svg` | On black/dark backgrounds |
| `assets/mark.svg` | The recurring brand motif (icon/mascot/geometric device), used sparingly as a visual accent on divider and closing slides |

### Non-negotiable logo rules
- The correct logo variant for the background must be used every time — never light-on-light or dark-on-dark.
- Never place the logo at an arbitrary position "because it looked fine there" — use the placement
  table below, or the placement convention defined by the active style/format skill.
- Never stretch, recolour, rotate, or crop the logo.
- The logo (or brand mark) should appear on every slide/page of a deliverable except where a format
  explicitly says otherwise (e.g. a cover slide may show only the mark, not the wordmark).

### Default placement (override per style/format as needed)
| Context | Variant | Position |
|---|---|---|
| Cover / title page | Light (on dark bg) or Dark (on light bg) | Top-left |
| Content pages | Dark | Bottom-left, small |
| Closing / signature page | Light or Dark matching background | Bottom-left |

## Colour Palette

Define your real palette in the private overlay. The public template ships this generic example —
downstream skills refer to these role names, not the hex values, so update this table and every
other skill inherits the change:

| Token | Example hex | Role |
|---|---|---|
| `primary` | `#1E293B` | Dominant brand colour — cover/divider backgrounds, primary text on light backgrounds |
| `secondary` | `#FFFFFF` | Primary background for content pages, text on dark backgrounds |
| `accent-1` | `#2563EB` | First category/highlight colour |
| `accent-2` | `#F59E0B` | Second category/highlight colour |
| `accent-3` | `#10B981` | Third category/highlight colour |
| `accent-4` | `#94A3B8` | Fourth category/highlight colour (neutral) |
| `ink` | `#0F172A` | Body text on light backgrounds |
| `muted` | `#64748B` | Secondary/caption text |

### Non-negotiable colour rules
- Only use colours from this palette. Never fall back to a design tool's default (e.g. PowerPoint's
  default blue, Word's default hyperlink blue).
- Maintain accessible contrast: body text must meet at least WCAG AA contrast against its background.
- Category/accent colours may be assigned differently by different style variants (that's a style
  choice) — but the *set* of colours available never expands beyond this palette without updating
  this file first.

## Typography

| Role | Font | Fallback |
|---|---|---|
| Primary (headings, slides) | `[Brand Sans]` | `Arial`, `Helvetica` |
| Body (documents) | `[Brand Sans]` or a print-safe equivalent | `Calibri`, `Arial` |

Some brand fonts (e.g. a licensed display font) don't render reliably in generated PowerPoint/Word
files across every machine. When that's the case for your real font, note the fallback strategy here
explicitly — which font renders in which tool — rather than leaving it to guesswork per deliverable.

### Non-negotiable typography rules
- One font family per deliverable type — don't mix families within a single deck or document.
- Never substitute a serif font unless the brand family itself is serif.
- Avoid all-caps except for very short labels (2–3 words).

## Cross-Document Conventions

These apply to *any* client-facing document (SOW, estimate, proposal) regardless of format variant,
because they're about protecting the firm commercially and legally, not about look-and-feel.

### Confidentiality footer
Every multi-page client document should carry a footer stating who the document is confidential to:
> "Confidential — for the use of [Client] and [FIRM_NAME] [legal entity suffix]"

### Signature block (contracts, SOWs)
Always two blocks, client first: Name / Title / Date for each party, client's legal entity named
first, [FIRM_NAME]'s legal entity second.

### Currency & tax phrasing
Always state currency and tax treatment explicitly next to any headline price:
> "[Currency] [amount] (excluding [GST/VAT/sales tax as applicable])"

Never include tax in a headline number — handle it in the invoicing/payment section instead.

## Financial Model Colour Convention

This is a genuine invariant (a standard financial-modelling convention, not a house style) that
applies to any spreadsheet deliverable — see the `estimates` skill for the full workbook structure
that uses it:

| Element | Colour | Meaning |
|---|---|---|
| Hardcoded inputs | Blue | Anything a user is meant to edit |
| Formulas / calculations | Black | Computed values |
| Cross-sheet links | Green | A value pulled from another sheet |
| Section headers | White text on dark fill | Structural navigation |
| Total rows | Bold, distinct fill | Grand totals, subtotals |

This convention should never be abandoned even when a workbook's visual style otherwise varies —
finance/procurement reviewers on the client side rely on it to audit a model quickly.

## Quality Checkpoint (Mandatory — Every Deliverable, No Exceptions)

**Never tell the user a deliverable is ready without running this checkpoint first.** This applies
to every PowerPoint, Word, or Excel file this framework produces or edits — not just decks, and not
just on request. Generating the file is not the same as finishing the task.

1. **Render it.** Convert to an inspectable form before judging it — a PDF/JPEG render for
   pptx/docx (see the base `pptx`/`docx` skills' conversion tooling), or an actual open/read-back
   for xlsx. Never declare a deliverable ready from reading the source code/XML alone — defects
   that are invisible in markup are often obvious once rendered.
2. **Inspect with fresh eyes.** Use a subagent for the visual pass where practical — the model that
   just wrote the file is prone to seeing what it intended rather than what's actually on the page.
3. **Check specifically for:**
   - **Shape overlap** — do any shapes overlap each other, or overlap text?
   - **Arrow/connector overlap** — do arrows cross other elements awkwardly, or fail to cleanly
     connect to what they're pointing at?
   - **Text overflow** — is any text cut off, spilling past its container, or wrapping badly?
   - **Colour correctness** — does everything draw from the brand palette above, with no stray tool
     defaults or un-recoloured leftovers?
   - **Borders & spacing** — inconsistent gaps, missing margins, misaligned columns/rows,
     elements crammed too close together (or too far apart) compared to the rest of the deliverable.
   - Leftover placeholder text (`[insert]`, `TODO`, `Lorem ipsum`, etc.)
4. **Fix what you find, then re-check only the affected parts** — don't loop indefinitely chasing
   sub-pixel positioning, but don't skip a real, visible defect either.
5. **Only after this passes** should the deliverable be reported as ready to the user.

This is process infrastructure, not an optional nicety — treat it as a hard gate on every
deliverable this framework produces, regardless of format or how simple the request seemed.

## Checklist Before Generating Anything Branded

- [ ] Correct logo variant selected for the background
- [ ] All colours drawn from the palette (no tool defaults)
- [ ] Font family consistent throughout
- [ ] If it's a contract-adjacent document: confidentiality footer, signature block, currency/tax
      phrasing all present
- [ ] If it's a spreadsheet: financial model colour convention applied
- [ ] Everything else (layout, density, diagram style, prose voice) has been handed off to the
      relevant style-choice skill — don't make style decisions here
- [ ] The Quality Checkpoint above has been run and passed — this is not optional
