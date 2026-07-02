# Style: Bold Diagram-First

**Best for**: solution walkthroughs, technical buying committees, architecture reviews — anything
where a diagram *is* the argument and prose would just slow the reader down.

## Shape Language
Sharp-to-moderately-rounded rectangular containers (corner radius ~0.05–0.1× box height) with visible
borders or fills in palette accent colours. Boxes are load-bearing design elements, not decoration —
every box on the slide should map to a real component, system, or phase.

## Layout Grammar
- The diagram occupies 65–80% of the slide's visual area on any slide that has one.
- Title sits in a fixed strip at the top (10–12% of slide height) — never floating, never resized
  to fit around the diagram.
- Any supporting text is caption-length (one line, ≤12 words) and sits either directly below the
  diagram or as small annotations pointing at specific diagram elements — never as a separate bullet
  list competing with the diagram for attention.
- Use the `solution-diagrams` skill's icon library and Mermaid conventions to build the diagram
  itself; this style governs how much of the slide it's allowed to take up and how sparse the
  surrounding text must be.

## Density
Low text density, high visual density. A slide in this style should have a diagram with real
detail (5+ components, clear flow direction) but almost no prose — if you find yourself writing a
paragraph, the content belongs in Editorial or Technical Deep Dive instead.

## Colour Emphasis
All accent colours are in active use simultaneously — this is the style where the full category
palette (accent-1 through accent-4) earns its keep, one colour per system/phase/category in the
diagram. `primary` is reserved for the title strip and container borders, not fills.

## Typography Scale
| Element | Size | Weight |
|---|---|---|
| Slide title | 22–24pt | Bold |
| Diagram component labels | 11–14pt | Regular or Bold for top-level containers |
| Caption under diagram | 10–11pt | Regular, muted colour |
| Annotation callouts | 9–10pt | Regular, matching the annotated element's accent colour |

## Example Slides

1. **Solution architecture** — title strip "Proposed Architecture" at top; below it, a full-width
   diagram with three columns (Sources → Platform → Consumption), each column's boxes filled in a
   different accent colour, connecting arrows in `muted`; one caption line beneath: *"Data lands
   in the platform within 15 minutes of source-system commit."*
2. **Sequence/flow diagram slide** — title "How a Request Flows Through the System"; a Mermaid
   sequence diagram spans 75% of the slide height; no bullet list anywhere on the slide, only 2–3
   small annotation callouts pointing at the specific steps the presenter wants to emphasise.
3. **Before/after comparison** — slide split into two diagram panels side by side ("Today" /
   "Proposed"), each a simplified architecture diagram, with a single caption line under each and
   no other text on the slide.
