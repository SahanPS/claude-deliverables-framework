# claude-deliverables-framework

A versioned, publishable [Claude Skills](https://docs.claude.com/en/docs/agents-and-tools/skills) framework
for producing branded business deliverables — PowerPoint decks, solution architecture diagrams, Statements
of Work, estimate workbooks — without every output looking identical.

## The problem

AI-generated deliverables converge fast. Give Claude the same brand guidelines every time and it will
produce the same slide layout, the same diagram shape, the same document structure — every time. That's
fine for a single firm's first deck. It's a liability by the tenth: clients notice the sameness, and a
"branded" skill quietly becomes a "one template" skill.

## The solution

Split what's actually **non-negotiable** (brand identity: logo, palette, fonts, legal/commercial document
formats) from what's a **style choice** (layout habits, shape language, density, diagram look). Ship the
style choices as a *library of named variants*, not a single hardcoded pattern, and instruct Claude to vary
its choice — stating which variant it picked and why — rather than defaulting to the same look every time.

Layered structure:

```
skills/
├── brand-core/           Non-negotiable brand invariants (logo, palette, fonts, legal formats)
├── deck-styles/          Named PowerPoint style variants — pick one, don't repeat consecutively
├── solution-diagrams/    Icon library + Mermaid conventions for architecture/flow diagrams
├── sow-formats/          Statement of Work format variants (Schedule A pattern + others)
└── estimates/            Estimate workbook conventions (rate card mechanics, sheet structure)
```

## The overlay pattern

This repo is meant to be forked. The public `skills/` tree ships generic, placeholder brand content —
safe to open-source, useless to a competitor. Your firm's real assets (real logos, real rate cards, real
client conventions, real style examples) live in a `private/` directory that mirrors the same folder
structure and is **gitignored** — it never leaves your machine.

```
skills/brand-core/assets/logo-dark.svg           <- public, generic placeholder, in this repo
private/skills/brand-core/assets/logo-dark.svg   <- your real logo, gitignored, same filename
```

The merge is file-level, not all-or-nothing: a private file with the same name as a public one wins
outright (e.g. a real `mark.svg` motif replaces the generic placeholder shape); a private file with a
*new* name is added alongside the public ones (e.g. a real named style variant like `style-classic.md`
sits next to the generic `style-editorial.md` placeholder in the deployed skill, and both are usable).

`scripts/deploy.sh` deep-merges `private/` over `skills/` into `~/.claude/skills/`, with `private/`
content winning on any conflict. The result on your machine is a fully firm-branded skill set; the
repo you push stays generic. See [private/README.md](private/README.md) for the full pattern.

## Quick start

```bash
git clone <this-repo>
cd claude-deliverables-framework

# Optional: set up your private overlay (see private/README.md)
mkdir -p private/skills

# Merge public + private into your live Claude skills directory
./scripts/deploy.sh

# Validate frontmatter, asset references, and confirm nothing private is staged
./scripts/validate.sh

# Package each merged skill as a .zip for claude.ai upload
./scripts/package.sh
```

## Forking this for your own firm

1. Fork the repo.
2. Read each `skills/*/SKILL.md` — the placeholder content shows the *shape* every invariant,
   style variant, and reference file should take.
3. Populate `private/skills/` with your real brand assets and conventions, mirroring the public
   folder structure exactly (same filenames).
4. Add or rename style variants in `skills/deck-styles/references/` and `skills/sow-formats/references/`
   to match how *your* firm actually varies its output — don't force your style into the placeholder
   names.
5. Run `scripts/deploy.sh` and start generating.

## Repo layout

| Path | Purpose |
|---|---|
| `skills/` | Public, generic skill definitions — safe to open-source |
| `private/` | **Gitignored.** Your real firm assets and conventions |
| `scripts/deploy.sh` | Merges `skills/` + `private/` → `~/.claude/skills/` |
| `scripts/package.sh` | Zips each merged skill for claude.ai upload |
| `scripts/validate.sh` | Lints SKILL.md frontmatter, checks asset refs, blocks private content from being committed |
| `examples/` | Sanitised example outputs (rendered slide PNGs, etc.) |
| `dist/` | `package.sh` output — zipped skills for claude.ai upload. Gitignored, regenerated on demand |

## Why this actually stops the sameness problem

The most important file in this repo is [`skills/deck-styles/SKILL.md`](skills/deck-styles/SKILL.md).
It doesn't just list style options — it instructs Claude to (a) pick a named variant deliberately
based on audience and content, or ask; (b) never pick the same variant twice in a row in one
conversation unless explicitly asked to match; (c) say out loud which one it picked and why. That
last rule is what makes the variation legible instead of accidental — you can tell at a glance
whether the framework is actually doing its job.

## License

MIT — see [LICENSE](LICENSE).
