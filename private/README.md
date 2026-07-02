# Private Overlay

This directory is gitignored. It never leaves your machine and is never pushed to the public remote.

## The pattern

`private/` mirrors the exact folder structure of `skills/` **and** `prompts/`. Where the public
tree ships generic, placeholder content (so the framework is safe to open-source), `private/` holds
your firm's real assets: real logos, real rate cards, real client-facing conventions, real style
examples drawn from actual past work, and real reusable prompt templates (with real signatory
names, real default content shapes) in `private/prompts/`.

```
skills/brand-core/assets/logo-placeholder.svg     <-- public, generic
private/skills/brand-core/assets/logo-placeholder.svg   <-- your real logo, same filename
```

`scripts/deploy.sh` deep-merges `private/` over `skills/` into `~/.claude/skills/`, with
`private/` winning on any filename conflict. The result is a fully-populated, firm-branded
skill set on your machine — while the public repo stays generic and safe to share.

## Setting this up for your own firm

1. Copy the folder structure from `skills/` into `private/skills/`.
2. Replace placeholder assets (logos, icons) with your real files, keeping the same filenames.
3. Replace placeholder reference docs (style variants, rate cards, SOW formats) with your real
   content — same filenames, real numbers and conventions.
4. Run `scripts/deploy.sh` to merge and install to `~/.claude/skills/`.
5. Run `scripts/validate.sh` before every push — it fails the build if anything under
   `private/` is ever staged for commit.

Nothing under this directory is tracked by git. If `git status` ever shows a file under
`private/` as stageable, stop and check your `.gitignore` before committing.
