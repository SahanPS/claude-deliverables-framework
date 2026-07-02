# Workbook Structure

Full sheet layouts for the standard estimate workbook. Real rate cards and pod headcounts derived
from actual delivered engagements belong in the private overlay — this file defines the generic
structure and mechanics only.

## Cover Sheet

**Title Block** (rows 2–5): client name (bold, large), engagement name, "Prepared by [FIRM_NAME]",
version and date.

**Programme Summary Block**: label–value pairs for Client, Programme Scope, Phases, Total Duration,
Delivery Model (blended onshore/offshore), Currency.

**Cost Summary Table**: five columns — Horizon | Description | Duration | Total Days | Total Cost —
one row per phase/horizon plus a bold **PROGRAMME TOTAL** row. Total Days and Total Cost cells are
green cross-sheet links to each horizon sheet's grand total row (see the colour convention in
`brand-core`).

**Notes & Assumptions Block**: a short bulleted summary — e.g. "Rates sheet drives the whole model,"
"Effort cells (blue) are editable," "Phase 0 produces the fixed price for build horizons," plus
whichever standard exclusions apply (licensing, T&E, hypercare — see
`references/boilerplate-assumptions.md`).

## Rates Sheet

Columns per resource level: Level | Base Cost | Margin % (blue input) | Client Rate (formula) |
optional FX columns if pricing in a currency different from the cost base. Formula pattern:

```
Client Rate = Base Cost / (1 - Margin%)
Client Rate (converted) = Client Rate * FX Rate
```

If your firm prices in multiple currencies/geographies, use separate Rates sheets per geography
rather than mixing rate cards on one sheet — this avoids formula-linking errors in horizon sheets
that reference the wrong rate.

## Horizon Sheet Layout

Every horizon sheet (Phase 0, H1, H2, ...) follows this exact pattern:

**Rows 1–2 — Title Block**: row 1 is the horizon title (merged across all columns); row 2 is a
subtitle with sprint/week breakdown and a reference to the Rates sheet.

**Rows 4–5 — Column Headers**: row 4 has Resource | Level | Location | Day Rate | Hour Rate | Sell
Total | Total Days | then sprint headers (merged across their week columns); row 5 has the first 7
columns blank, then Week 1, Week 2, ... Week N.

**Row 6 onward — Pod Structure**: each pod is a header row + resource rows + an implicit subtotal on
the header row. Standard pod order:

1. **Governance & Persistent Core** — engagement lead, solution architect, delivery manager, change
   lead, all part-time allocation running across all weeks.
2. **Build Pod — [Workstream 1]**, **Build Pod — [Workstream 2]**, ... — one per major workstream.
3. **Quality Engineering & UAT** — QE lead + testers, typically ramping from mid-horizon.

**Column Calculations**:
- Day Rate: `=Rates!$D$X` (green cross-sheet link, X = the row matching the resource's level)
- Hour Rate: `=DayRate/8`
- Sell Total: `=DayRate*TotalDays`
- Total Days: `=SUM(weekly effort cells)`
- Weekly effort cells: blue hardcoded inputs (the editable number of days per week)

**Pod Subtotal Row**: `Sell Total = SUM(resource rows)`, `Total Days = SUM(resource rows)`, styled
with the sub-section fill.

**Grand Total Row**: sums all pod header rows by cell reference, styled with the total fill and bold.

**Freeze Panes**: always freeze at the first weekly-effort column so resource/level/location/rates
stay visible while scrolling through weekly effort.

## Standard Resourcing Pod Shapes (Generic Scaffold)

Adapt headcount and level mix to the engagement's actual scope and complexity — these are starting
points, not fixed requirements:

**Phase 0 — Discovery** (typical): engagement lead (part-time), solution architect (full-time),
delivery manager (ramping), one functional lead per major workstream, one integration/technical
architect (part-time), one business analyst per workstream, a change management lead (part-time),
a data migration lead if relevant (part-time).

**Build Horizon — per-workstream pod** (typical): a functional lead (full-time), a functional/technical
consultant (full-time), one or more technical consultants depending on complexity, a business
analyst (tapering after the first few sprints).

**Governance & Persistent Core** (every horizon): engagement lead (part-time), solution architect
(full-time), delivery manager (full-time), change management lead (part-time).

**Quality Engineering Pod**: QE lead (part-time early, full-time from mid-phase), one or more
testers ramping from roughly the halfway point of the horizon.

**Integration-heavy engagements**: if the client has third-party managed systems in play, always
include a dedicated MSP/vendor-coordination line — it's real effort that's easy to underestimate.

## Scope & Assumptions Sheet

A long-form narrative sheet, columns B/C only, wrap-text enabled, clear section headers:

1. **Programme Overview** — label–value table: Client, Platform, Business Outcome, Delivery Approach,
   Total Duration, Delivery Model, Deployment.
2. **One section per phase/horizon**, each with: Business Objectives, In Scope (per workstream),
   Out of Scope (in red text).
3. **Key Assumptions**, sub-sectioned: Commercial & Scope, Delivery & Methodology, Client
   Responsibilities, Technical & Architecture, Data & Migration, Risks & Dependencies.
4. **Consolidated Exclusions** — a single red-text bulleted list of everything explicitly not
   included (see `references/boilerplate-assumptions.md` for the reusable starting text).

## Column Widths & Formatting (reference values)

| Column | Width | Notes |
|---|---|---|
| Resource | ~42 | |
| Level | ~22 | |
| Location | ~12 | |
| Rate columns | ~16 each | |
| Sell Total | ~20 | |
| Total Days | ~13 | |
| Weekly effort columns | ~9 each | |

Standard font across the whole workbook: pick one sans-serif and use it everywhere (see `brand-core`
typography). Sizes: 10 body, 11 sub-headers, 13 section headers, 14–16 titles.
