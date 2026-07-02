---
name: deck-styles
description: "Named PowerPoint/deck style variant library for [FIRM_NAME]. Use this skill whenever creating a slide deck, presentation, pitch deck, client deck, or slides of any kind for [FIRM_NAME] — 'build a deck', 'make slides', 'presentation for [client]', 'pitch deck', 'exec deck', 'technical deep dive deck'. ALWAYS load brand-core first for the non-negotiable logo/palette/font layer, then use this skill to choose HOW the deck looks. This skill's entire purpose is to stop every deck looking identical — read the 'Variation Is Mandatory' section before generating anything."
---

# Deck Styles

`brand-core` defines what never changes (logo, palette, fonts). This skill defines how the *look*
of a deck varies — layout grammar, density, shape language, which accent colour gets emphasis — so
that ten decks in a row don't all read as the same template with different words swapped in.

## Variation Is Mandatory

This is the operating principle of this skill, not a nice-to-have:

1. **Always select a named style variant before generating a deck.** Pick based on audience and
   content type using the guide below. If the audience/content type is ambiguous, ask the user
   which style they want rather than silently defaulting to one.
2. **Never select the same style variant twice in a row within a conversation**, unless the user
   explicitly asks for the same look again (e.g. "match the deck you just made"). If the best-fit
   style was just used, pick the second-best fit and say so.
3. **Always state which style you chose and why**, in one sentence, before or after generating the
   deck — e.g. "Using Bold Diagram-First since this is a solution walkthrough for a technical
   buying committee." This isn't optional flavour text; it's what makes the variation legible to
   the user instead of accidental.
4. **Consistency is opt-in, not the default.** If the user wants every deck in a series to match
   (e.g. a multi-part programme update), they'll say so — treat that as an explicit override, not
   the normal case.

## Available Style Variants

| Style | Best for | One-line character |
|---|---|---|
| [Editorial](references/style-editorial.md) | Narrative-led proposals, thought leadership, executive storytelling | Generous white space, long-form headlines, magazine-style pull quotes |
| [Bold Diagram-First](references/style-bold-diagram-first.md) | Solution walkthroughs, technical buying committees, architecture reviews | Diagrams are the hero on every slide; text is caption-length |
| [Minimal Exec](references/style-minimal-exec.md) | C-suite steering updates, board decks, one-number-per-slide status reports | Extreme restraint — one idea per slide, minimal chrome |
| [Technical Deep Dive](references/style-technical-deep-dive.md) | Engineering workshops, detailed design reviews, developer-facing content | Dense, code/schema-friendly, monospace accents, high information density |

If your firm's private overlay includes additional named variants (e.g. a migrated "Classic" style
derived from historical decks), they'll appear in `private/skills/deck-styles/references/` and
should be added to this table's local copy.

## How to Choose

Ask these questions, in order, before picking a variant:

1. **Who is the primary audience?** C-suite/board → Minimal Exec. Technical buying committee or
   architects → Bold Diagram-First or Technical Deep Dive. Mixed business audience being sold a
   narrative → Editorial.
2. **What's the content shape?** Mostly one architecture or data flow diagram to walk through →
   Bold Diagram-First. Mostly a status/decision → Minimal Exec. Mostly a story with a beginning,
   middle, end → Editorial. Mostly specs, schemas, or code → Technical Deep Dive.
3. **Has this style been used already in this conversation?** If yes, and the user hasn't asked to
   match it, go to the next-best fit per questions 1–2.

If two styles fit equally well, ask the user rather than guessing — this is exactly the kind of
judgment call that's better surfaced than silently resolved.

## What Every Style Reference Defines

Each file in `references/` follows the same structure so they're easy to compare and easy to add to:

- **Shape language** — rounded vs. sharp corners, outline vs. filled shapes, how boxes/containers look
- **Layout grammar** — grid structure, margins, how title/body/visual regions are arranged
- **Density** — how much content per slide, how much white space
- **Colour emphasis** — which brand-core palette tokens get used how (e.g. "accent-1 dominant, others used sparingly")
- **Typography scale** — point sizes and weights for title/subtitle/body/caption within this style
- **2–3 example slides** — described concretely enough to build from (not code, just what's on them)

## Building a Deck in a Chosen Style

1. Read `brand-core/SKILL.md` for logo/palette/font tokens.
2. Read the chosen style's reference file in full.
3. Build slides following that style's layout grammar and density — don't blend two styles'
   conventions on the same deck.
4. If the deck needs a diagram, use the `solution-diagrams` skill for the diagram itself, but embed
   it following this style's density/layout conventions (e.g. Bold Diagram-First gives the diagram
   the full slide; Minimal Exec would simplify or split it across slides).
5. State the style choice and rationale to the user (see Variation Is Mandatory, point 3).

## Common Mistakes to Avoid

- **Don't silently default to the first style in the table every time.** That recreates the exact
  sameness problem this skill exists to solve.
- **Don't mix layout grammars within one deck** (e.g. Editorial's generous margins on some slides,
  Technical Deep Dive's dense grid on others) unless the user explicitly wants a hybrid.
- **Don't treat brand-core's palette as a style choice.** The palette is fixed; only *emphasis*
  varies between styles.
- **Don't invent a five-word style name from nowhere.** If none of the library's variants fit,
  say so and propose adding a new named variant rather than quietly improvising an unnamed one-off.
