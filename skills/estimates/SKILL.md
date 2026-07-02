---
name: estimates
description: "Estimate workbook conventions for [FIRM_NAME] client engagements — phased methodology, workbook structure, rate card mechanics, resourcing shapes. Use this skill whenever asked to build, update, or review an estimate, proposal cost, SoW pricing, resourcing model, effort estimate, or engagement cost — 'build me an estimate', 'resourcing model for...', 'cost for the [client] proposal', 'rate card', 'effort model', 'horizon estimate'. Always read the main xlsx SKILL.md first for openpyxl mechanics and formula recalculation, then this skill for [FIRM_NAME]'s methodology and structure. Pairs with sow-formats (matching commercial document) and deck-styles (matching executive summary deck)."
---

# Estimates

This skill is a **convention library**, the same pattern as `sow-formats`: it defines the workbook
methodology and structure [FIRM_NAME] uses to price engagements, so every estimate is internally
consistent and auditable by a client's finance/procurement team.

**This is a public template.** The structure, colour convention, and boilerplate text below are
genuinely generic. Your firm's real rate cards, margins, FX assumptions, and past reference
estimates belong in `private/skills/estimates/` — see [private/README.md](../../private/README.md).
Never let real commercial figures leak into the public copy of this skill.

## Methodology — Phased Delivery

Estimates follow a standard phased structure:

1. **Phase 0 — Discovery & Solution Blueprint** (typically 4–8 weeks, fixed price). Closes discovery
   gaps, validates assumptions, produces the solution design and integration architecture. Output:
   a firm fixed-price commitment for the build horizons that follow. Recommend this as a paid,
   separately-priced first phase for any programme of meaningful size — don't skip it to look
   cheaper up front; an unpriced discovery phase just moves risk onto the fixed-price build number.
2. **Horizon 1, 2, 3...** — build horizons (typically 16–24 weeks each). Each is a standalone
   increment with its own go-live, hypercare, and value delivery, named by business capability
   rather than a generic "Phase N".
3. **Optional future phase** — deferred advanced features, not priced in the base estimate.

This structure protects both sides: the firm avoids committing to a fixed price against incomplete
requirements, and the client avoids buying something that doesn't fit. Horizons deliver incremental,
measurable value rather than one big-bang milestone. Hypercare is always priced separately from the
build horizon itself.

## Standard Workbook Structure

Every estimate workbook follows this sheet order — see `references/workbook-structure.md` for the
full layout of each sheet:

1. **Cover** — programme summary, cost roll-up table, assumptions, notes
2. **Scope & Assumptions** — full scope breakdown by phase/horizon, in/out of scope, assumptions, exclusions
3. **Rates** — day rate card(s) by level and location — **real values live in the private overlay**
4. **Phase 0** — discovery resourcing and effort
5. **H1, H2, H3...** — one sheet per build horizon

## Colour Coding Convention

This is a genuine invariant, not a style choice — see `brand-core`'s Financial Model Colour
Convention section. Blue = hardcoded input, black = formula, green = cross-sheet link, distinct
fills for headers/totals. Apply this consistently across every sheet regardless of which rate card
or client it's built for.

## Rate Cards

**Always confirm which rate card applies before building an estimate** — ask if it's not obvious
from client location or project geography. Rate card mechanics (margin-on-cost, FX conversion,
client-rate vs. cost-rate columns) are generic and defined in `references/workbook-structure.md`.
The actual numbers — day costs, margins, FX rates — are commercially sensitive and live only in
`private/skills/estimates/references/`. Never hardcode real rate figures into this public skill.

## Standard Resourcing Shapes

Generic pod shapes (Discovery pod, workstream build pods, QE pod, governance/persistent core) are
documented in `references/workbook-structure.md` as a starting scaffold — adapt headcount and level
mix to the specific engagement's scope and complexity. Your firm's real, battle-tested pod shapes
(derived from actual delivered engagements) belong in the private overlay.

## Process Checklist

1. Confirm the basics: client/project, which rate card applies, high-level scope, timeline driver,
   onshore/offshore/blended delivery.
2. Read the main `xlsx` SKILL.md first for openpyxl mechanics and formula recalculation — see
   `references/build-mechanics.md` for the estimate-specific code pattern.
3. Build in this order: Rates sheet first (so horizon sheets can link to it) → Phase 0 → horizon
   sheets → Cover (links to horizons) → Scope & Assumptions (comprehensive narrative).
4. Always recalculate after saving and confirm zero formula errors before delivering — see
   `references/build-mechanics.md`.
5. Sanity-check the totals land in a plausible range for the scope before presenting them.
6. Always offer next steps: an offshore-blended comparison, hypercare line items, a T&E/contingency
   block, and a matching executive PowerPoint (`deck-styles` + `brand-core`).

## Bundled Files

| File | When to read |
|---|---|
| `references/workbook-structure.md` | Always — sheet layouts, horizon sheet structure, resourcing pod shapes |
| `references/build-mechanics.md` | Always — openpyxl code pattern, recalculation and verification steps |
| `references/boilerplate-assumptions.md` | Building the Scope & Assumptions sheet — reusable generic assumptions/exclusions text |

## Common Mistakes to Avoid

- **Don't hardcode rates in horizon sheets** — always link to the Rates sheet with a cross-sheet
  formula (green, per the colour convention).
- **Don't price Phase 0 as part of the fixed-price build** — it's a separate commitment that
  produces the fixed price for what follows.
- **Don't skip the Scope & Assumptions sheet** — a total on the Cover sheet is meaningless without
  the scope boundary that defends it.
- **Don't forget to recalculate and verify** — a formula error (`#REF!`, `#DIV/0!`) kills credibility
  instantly with a client's finance team.
- **Don't include T&E, hypercare, or licensing in the base number** unless explicitly asked — always
  call them out as exclusions instead.
- **Don't let real rate figures end up in the public skill copy** — if you're editing this skill and
  a real number appears, it belongs in the private overlay, not here.
