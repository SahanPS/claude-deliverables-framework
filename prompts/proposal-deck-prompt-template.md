# Reusable Prompt Template — Client Proposal Deck (interview-driven)

A save-and-reuse prompt for generating a branded client proposal deck with this framework. You
don't fill in a form — you paste the short prompt below, and Claude asks what it needs, batched
into as few round-trips as possible. If your opening message already answers some of the
questions, Claude should skip re-asking those and only chase the gaps.

**This is a generic template.** Populate `private/prompts/` with your firm's real version (real
signatory names, real content defaults, real case study references) the same way every other skill
in this framework has a public generic template + private real overlay.

## The prompt to paste

```
Build me a [FIRM_NAME] branded proposal deck. Ask me what you need before starting — group your
questions so I'm not going back and forth more than once or twice, and don't invent client
details, scope, pricing, or anything else I haven't told you. Follow the question script in
prompts/proposal-deck-prompt-template.md.
```

## The question script (what Claude asks, and how)

**Skip any question already answered in the opening message.** Ask the rest in two batches, not
one question at a time.

### Batch 1 — Engagement basics (plain questions, free text — not a good fit for multiple choice)

1. Client name and industry/sector?
2. Scope — what's being proposed (technology/product mix, service type)?
3. Audience for this deck (e.g. client leadership, procurement, technical buying committee)?
4. Any existing relationship with this client, or is this a new relationship?
5. What's the core problem/challenge this client is facing? (A few sentences is enough — this
   doesn't need to be a finished problem statement.)
6. Who signs the welcome note? (name, title)

### Batch 2 — Shape and commercials (genuine multiple-choice — use AskUserQuestion)

7. **Engagement type**: new business pitch / renewal / phase 2 proposal / formal RFP response
8. **Optional sections to include** (multi-select): team profiles / case studies / managed
   services / governance model — see notes below on what each defaults to if skipped
9. **Pricing basis**: fixed price / rate-card-based / range
10. **Deck style**: let Claude choose per the `deck-styles` variation rule and state which one and
    why (default — recommend this), or name a specific style if there's a reason to override

### What NOT to ask about

Colours, fonts, logo placement, and the base content structure (cover, welcome note, about the
firm, credentials, guiding principles, solution approach, delivery approach, client logos,
resourcing, closing) are already fixed by `brand-core` and the default section shape — don't ask
about these, just apply them.

### After the two batches

Build the deck. For anything still unknown that isn't covered by the questions above, mark it
`[TBC]` in the output rather than inventing it or asking a third round — surface anything `[TBC]`
in the summary when showing the result so it's easy to spot.

**Diagrams**: solution architecture (sources → platform → consumption, or whatever topology fits),
delivery roadmap or implementation approach summary, and a customer journey map only if the story
benefits from walking through an end-user scenario (ask about this only if genuinely ambiguous).

**Before showing the result**: run the mandatory Quality Checkpoint (render, visual QA for
shape/arrow overlap, text overflow, colour drift, spacing) and confirm it passed. State which deck
style was used and why.

## Notes on the optional sections (for batch 2's question 8)

- **Team profiles** — if included, ask whether to feature named individuals or use generic
  role-based placeholders; if omitted, the deck simply doesn't have this section.
- **Case studies** — if included, pick the 1–2 most relevant by industry or scope match.
- **Managed services** — include only if the engagement has an ongoing post-launch support
  component; skip for pure project-based engagements.
- **Governance model** — worth including as its own section for larger/more formal proposals; for
  smaller pitches it can fold into "Delivery approach" instead, which is the default if this option
  isn't selected.
