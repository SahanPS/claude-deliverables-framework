---
name: sow-formats
description: "Statement of Work / commercial-document format library for [FIRM_NAME]. Use this skill whenever asked to create, draft, or update a Statement of Work, SOW, Schedule A, proposal document, or fixed-price/T&M engagement contract — 'build me an SOW', 'draft a statement of work for...', 'I need a Schedule A for...', 'proposal document for [client]', 'put together the commercial document'. Always read the main docx SKILL.md first for authoring mechanics, then this skill for [FIRM_NAME]'s structure and commercial conventions. Pairs naturally with brand-core (branding), solution-diagrams (embedded diagrams), and estimates (matching costing workbook)."
---

# SOW Formats

This skill is a **format library**, the same pattern as `deck-styles`: [FIRM_NAME] may use more than
one SOW/commercial-document format depending on client, engagement type, or region, and the goal is
to pick the right one deliberately rather than always reaching for the same template regardless of
fit.

**This is a public template.** The one format shipped here (`references/format-generic-schedule-a.md`)
is fully generic — genuine methodology and toolchain mechanics, no real client names, rates, or
contract language. Your firm's real format(s) — the ones actually used with real clients — belong in
`private/skills/sow-formats/references/`, alongside a private index of past reference engagements to
use as benchmarks. See [private/README.md](../../private/README.md).

## Available Formats

| Format | Best for |
|---|---|
| [Generic Schedule A](references/format-generic-schedule-a.md) | Fixed-price or T&M engagements needing a formal, contract-adjacent commercial document with scope, approach, deliverables, and commercials |

If your private overlay defines additional formats (e.g. a lighter-weight letter proposal, or a
region-specific variant), add them to this table's local copy and to the choice logic below.

## Choosing a Format

1. **Does the client expect a formal Schedule-A-style contractual document** (common for enterprise/
   regulated clients, master-agreement-based engagements)? → Generic Schedule A (or your firm's real
   equivalent).
2. **Has the client shared a reference SOW from a prior engagement or another vendor?** Extract their
   structural conventions and adapt to that — don't override an established client-side convention
   with the firm default. The reference document is a style guide, not a template to copy verbatim;
   the content should still be [FIRM_NAME]-quality.
3. **Is this a lightweight/early-stage proposal rather than a binding SOW?** Say so explicitly and
   confirm with the user whether a full Schedule-A-style document is even the right deliverable, or
   whether a shorter proposal format fits better.

## What This Skill Does NOT Cover

- **Internal costing** — use the `estimates` skill for the Excel workbook.
- **Pitch decks / editable diagram slides** — use `deck-styles` + `solution-diagrams`.
- **The diagrams embedded in an SOW** — use `solution-diagrams` for the diagram itself; this skill
  only covers where in the document structure diagrams go and how they're captioned/sized.

When the user asks for "the SOW and the estimate and the deck", produce all three, using the
respective skill for each, and lead with the SOW.

## Bundled Files

| File | When to read |
|---|---|
| `references/format-generic-schedule-a.md` | Always, when building or updating an SOW in this format — has the full section structure, toolchain mechanics, diagram embedding pattern, and commercials conventions |

## Common Mistakes to Avoid

- **Don't force every engagement into the same format** just because it's the only one you've used
  before — check whether the client, engagement type, or region calls for a different format from
  the private overlay first.
- **Don't skip the Out of Scope section.** Regardless of format, a fixed price without explicit
  exclusions is unenforceable — this is a structural invariant, not a style choice.
- **Don't quote a price without tying it to milestones and acceptance criteria.**
- **Don't skip the docx validation step** described in the chosen format's reference file — a
  document with a broken table or missing image undermines the whole deliverable.
- **Don't assume a client-provided reference SOW is a template to copy verbatim** — it's a structural
  reference; the prose and rigor should still be [FIRM_NAME]'s own.
