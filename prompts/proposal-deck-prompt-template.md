# Reusable Prompt Template — Client Proposal Deck

A save-and-reuse prompt for generating a branded client proposal deck with this framework. Fill in
the bracketed fields, delete anything that doesn't apply, and paste into a fresh conversation. It's
designed to work with the framework's skills (`brand-core`, `deck-styles`, `solution-diagrams`) — it
doesn't need to re-specify colours, fonts, or logo rules, since those are already enforced by
`brand-core`.

**This is a generic template.** Populate `private/prompts/` with your firm's real version (real
signatory names, real default content shape, real case study references) the same way every other
skill in this framework has a public generic template + private real overlay.

```
Build a [FIRM_NAME] branded proposal deck.

ENGAGEMENT DETAILS
- Client: [CLIENT NAME], [industry/sector]
- Scope: [what's being proposed — product/technology mix, service type]
- Audience: [e.g. client leadership team / procurement / technical buying committee]
- Engagement type: [new business pitch / renewal / phase 2 proposal / formal RFP response]
- Existing relationship with this client: [none / describe prior work]
- Welcome note signatory: [name, title]

CONTENT TO INCLUDE (default shape — add, drop, or reorder sections as this specific story needs)
1. Cover
2. Thank you / welcome note from [signatory] — relationship-first tone, references history with this client if any
3. About [FIRM_NAME] — positioning, credentials, what makes the firm credible for this work
4. Credentials & qualifications — certifications, partner designations, notable recognitions
5. Our guiding principles / how we work
6. The problem — [client]'s specific business challenge (state it plainly, once)
7. Solution approach — proposed solution mapped to the problem, with a solution architecture diagram
8. Delivery approach — implementation methodology / roadmap
9. [Optional] Relevant case studies — 1–2 most similar past engagements by industry or scope
10. Client logos / social proof
11. [Optional] Key team profiles — named individuals if decided, otherwise generic role-based team shape
12. Resourcing — proposed team shape and roles for this engagement
13. Pricing / commercials — [fixed price / rate-card-based / range]
14. Next steps / closing

DIAGRAMS NEEDED
- Solution architecture (sources → platform → consumption, or whatever topology fits)
- Delivery roadmap or implementation approach summary
- [Optional] Customer journey map, if the story benefits from walking through an end-user scenario

DATA YOU'RE PROVIDING VS. PLACEHOLDER
- Real content to use as-is: [paste/attach — problem statement specifics, logo files, team bios, pricing figures]
- Anything not finalised: mark clearly as [TBC] rather than inventing specifics

STYLE
- Pick a deck-styles variant deliberately per the framework's variation rule and state which one and why.
- Don't deviate from the brand-core palette/fonts/logo regardless of style choice.

IF ANY FIELD ABOVE IS BLANK OR UNCLEAR
Ask before proceeding — don't guess or invent client details, pricing, scope, or anything else to
fill a gap. This is different from a field explicitly marked [TBC] — that's a deliberate placeholder
and it's fine to carry it into the deck as-is. An unanswered field means "ask"; an explicit [TBC]
means "leave it marked pending in the output."

Before showing the result: run the mandatory Quality Checkpoint (render, visual QA for shape/arrow
overlap, text overflow, colour drift, spacing) and confirm it passed.
```

## Notes on the optional sections

- **Team profiles** — decide once whether you want a standing roster of who gets featured, or
  whether this defaults to generic role-based placeholders unless named per-prompt.
- **Case studies** — worth maintaining a short mapping of which past case studies fit which
  industries/scopes, so the right ones get picked without specifying every time.
- **Managed services / post-launch support** — add a section for this if the engagement includes an
  ongoing support component; omit for pure project-based engagements.
- **Governance model** — worth adding as its own section for larger or more formal proposals; often
  folds into "Delivery approach" for smaller pitches.
