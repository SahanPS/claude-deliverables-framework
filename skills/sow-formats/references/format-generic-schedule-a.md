# Format: Generic Schedule A

A formal, contract-adjacent Statement of Work structure for fixed-price or T&M engagements. This is
a genuinely generic example — replace with your firm's real format (and real reference engagements
to benchmark against) via `private/skills/sow-formats/references/`.

## What This Produces

A single Word document (.docx), typically 10–14 pages, built using JavaScript and the `docx` npm
package for clean control over branding, tables, callouts, and embedded images. See
`references/build-mechanics.md` for the toolchain.

## Required Sections, In Order

1. **Cover** — Schedule A label, client name, engagement name, "Statement of Work", effective date,
   parties.
2. **Preamble** — one paragraph orienting the reader on what this SOW covers, plus a short bulleted
   list of headline outcomes.
3. **Background & Objectives** — 2–4 paragraphs of business context, then a bulleted objectives list.
   Explain the use case, why it matters, what makes it non-trivial, what good looks like.
4. **Solution Approach** — high-level solution description. The first architecture diagram (Figure 1,
   via the `solution-diagrams` skill) is embedded here, followed by prose explaining the flow.
5. **Phased Delivery / Approach** — a phase summary table. Even single-phase engagements should
   clarify what is and isn't in scope versus future phases.
6. **Scope of Services** — two subsections: **In Scope** (bulleted deliverables/activities) and
   **Out of Scope** (explicit boundary — see rationale below).
7. **Engagement Approach** (week-by-week or sprint-by-sprint) — embed the timeline diagram here
   (Figure 2 or 3). Follow with a per-period section: narrative paragraph, activity bullets, and an
   activity table (ID / Activity / Owner / Customer requirement).
8. **Engagement Deliverables** — numbered deliverable table (ED.01 through ED.NN) with description
   and due date.
9. **Project Governance** — Customer Responsibilities and Required Resources, Governance and Cadence
   (stand-ups, steering, showcases, risk/issue log).
10. **Resourcing** — resource profile table, optionally a resource ramp by week/sprint.
11. **Commercials & Funding** — total price callout, rate card (optional, see below), invoicing
    schedule by milestone, expenses & validity note. See the Commercials section below for the full
    pattern.
12. **Acceptance and Sign-off** — signature blocks, client first.
13. **Appendices** — Key Assumptions (Appendix A), optionally output schema / RACI / reference
    architecture (B, C, D).

## Why This Structure Works

- **"Schedule A" framing** signals "this is a contractual schedule under a master agreement," not a
  free-standing pitch — clients recognise it and it moves faster through their procurement process.
- **Background before scope** gives the document a business narrative instead of reading as a
  feature list.
- **Diagrams before details** (see `solution-diagrams`) let the reader form a mental model before
  six pages of activity tables.
- **Per-period activity tables with a "Customer requirement" column** pre-empt the "what do you need
  from us" question that always comes up in delivery.
- **Out of Scope as a peer section to In Scope, not buried in an appendix.** This is the single most
  effective tool for protecting a fixed price — treat it as a structural invariant, not optional.

## Commercials & Funding — The Pattern

This section is where most client questions land and where the price either holds or doesn't.
Always in this order:

1. **Section opening** — one sentence stating the commercial construct:

   | Commercial type | Opening line |
   |---|---|
   | Fixed price | "This engagement is proposed as a **fixed-price** commercial arrangement to deliver the scope defined in this SOW." |
   | Time & Materials | "This engagement is proposed on a **time and materials** basis with [weekly/monthly] billing." |
   | Fixed price + variable | "This engagement combines a **fixed-price core scope** with a variable change-request pool." |
   | Capped T&M | "This engagement is delivered on a **time and materials basis up to a not-to-exceed cap**." |

2. **Total price callout** — a coloured callout box (see `brand-core` palette) with exactly three
   lines: (a) the headline price with currency and tax-exclusion phrase (see `brand-core` currency
   convention), (b) the basis — how the number was derived, (c) a change-request line protecting the
   price from scope drift.

3. **Rate Card Applied subsection — include or omit deliberately**:
   - **Include** when the client expects day-rate transparency (common for enterprise procurement),
     or when the firm is being benchmarked against competitors and transparency helps.
   - **Omit** when the client is a direct/repeat customer who already has the rate card separately,
     when explicitly requested, or when the rate card is commercially sensitive for this specific
     deal (e.g. a client-specific discount).
   - Real rate card figures belong in the private overlay — see the `estimates` skill.

4. **Invoicing Schedule** — a milestone table (Milestone / Acceptance criteria / Period / Amount),
   always 3–5 milestones (fewer has no real cadence, more becomes trivial). Acceptance criteria must
   be specific and verifiable ("X built and signed off"), never vague ("activities complete"). Always
   end with a bold total row.

5. **Expenses & validity** — short italic notes at the end: remote-vs-onsite expense assumption, and
   an explicit validity period for the SOW (e.g. "valid for 60 days from the Effective Date").

**Out of Scope vs. Exclusions — don't conflate them:**
- *Out of Scope* (in the Scope of Services section) is about **capability** — what's not being built.
- *Exclusions* (in Commercials, or as closing italic notes) is about **cost** — what's not included
  in the price (e.g. third-party licensing, travel & expenses, hypercare/managed service, future
  phases). Most SOWs need both, and they answer different client questions.

## Diagrams

Every SOW in this format needs at minimum: a Solution Architecture diagram (Figure 1) and an
Engagement Timeline diagram (Figure 2 or 3). A third domain-specific diagram (data model, integration
topology, agent flow) is common. Build all diagrams using the `solution-diagrams` skill — that skill
owns diagram type selection, icon usage, and Mermaid theming. This format only governs *where* in the
document diagrams go, their captioning (`Figure N — [Client] [Use Case] [Diagram Type]`), and sizing:

| Diagram type | Word embed size (width × height, px) |
|---|---|
| Architecture | 620 × 354 |
| Methodology / component detail | 620 × 310 |
| Timeline | 620 × 266 |

## Process Checklist

1. **Capture the engagement basics** before writing anything: client name/entity, engagement name,
   duration, resource shape, rate card visibility (show/hide), currency, phase context (standalone
   or part of a programme), key technology stack, any reference SOW the client has shared.
2. **Confirm the diagrams needed** — at minimum Architecture + Timeline; ask the user for a sentence
   on any domain-specific diagram if it's not obvious from context.
3. **Build in this order**: diagrams first (via `solution-diagrams`, so rendering can happen in
   parallel with writing) → build the document (see `references/build-mechanics.md`) → validate →
   render to PDF → visually QA → iterate.
4. **Always offer these next steps** at the end: matching estimate workbook (`estimates` skill),
   matching editable diagram deck (`deck-styles` + `solution-diagrams`), a one-page executive
   summary, or a Phase 2 / follow-on scope document.

## Common Mistakes to Avoid

- Don't write the whole document as one massive inline script — use helper functions (see
  `references/build-mechanics.md`).
- Don't forget the page break before Commercials & Funding — it's a distinct contractual section and
  deserves its own page.
- Don't omit Out of Scope.
- Don't quote a price without listing the milestones that unlock payment.
- Don't skip validation (see `references/build-mechanics.md`) — a document with a broken table or
  missing image undermines credibility immediately.
- Don't hardcode the engagement length into section headers ("4-Week Plan") — keep names timeless
  ("Engagement Approach") so the document reads cleanly if timelines shift.
