# Style: Technical Deep Dive

**Best for**: engineering workshops, detailed design reviews, developer-facing content — audiences
who want the schema, the config, or the edge case, not the pitch.

## Shape Language
Sharp-cornered rectangular containers throughout, styled closer to a code editor or terminal than a
marketing deck — thin borders, monospace accents, minimal ornamentation. Tables and code blocks are
first-class citizens, not things to be avoided.

## Layout Grammar
- Slides are allowed — expected — to be dense. Use a structured grid: title strip, then 2–3 content
  regions (e.g. a code/schema block on the left, an explanatory diagram or bullet list on the right).
- Tables are used liberally for anything tabular (API parameters, field mappings, config options) —
  don't convert a table into prose to "look less technical."
- Footnote/reference numbers are acceptable for citing specs, RFCs, or internal doc links.

## Density
The highest density style in the library, deliberately. A slide with 150+ words, a table, and a
diagram on it is normal here, not a mistake — the audience is reading, not just listening.

## Colour Emphasis
`primary` and `ink` dominate as text/border colours (this style reads more like documentation than
a brand moment). Accent colours are used functionally — e.g. `accent-1` for "modified" rows in a
diff-style table, `accent-3` for "passing/valid" states — not decoratively.

## Typography Scale
| Element | Size | Weight |
|---|---|---|
| Slide title | 20–22pt | Bold |
| Section label within slide | 13–14pt | Bold, often uppercase |
| Body / table content | 10–12pt | Regular, monospace for code/schema/field-name content |
| Footnote / spec reference | 8–9pt | Regular, muted |

## Example Slides

1. **Schema/data model slide** — title "Event Payload Schema"; left half a monospace-formatted
   JSON schema block with field types; right half a short bullet list explaining the 2–3 fields
   most likely to cause integration questions.
2. **API/config table slide** — title "Configuration Parameters"; a dense table (Parameter | Type |
   Default | Notes) spanning the full slide width, 10pt monospace for parameter names.
3. **Sequence diagram with annotations slide** — a detailed Mermaid sequence diagram covering most
   of the slide, with numbered footnotes below explaining 3–4 specific edge cases or failure modes
   at 9pt — denser and more technical than the equivalent Bold Diagram-First treatment.
