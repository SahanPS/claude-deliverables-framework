# Build Mechanics — Generic Schedule A

Toolchain and reusable code for building the Generic Schedule A format. Read the main `docx`
skill first for base authoring mechanics (the `docx` npm package, validation workflow) — this file
layers the format-specific structure on top.

## File Layout

Work in a single folder per engagement:

```
<client>_sow/
├── build.js                       # The docx build script (Node.js + docx npm package)
├── diagram1_architecture.svg/.png # From the solution-diagrams skill
├── diagram2_[domain].svg/.png     # Optional domain-specific diagram
├── diagram3_timeline.svg/.png
└── <Client>_SOW_Draft.docx        # Final output
```

Adjust the working-directory path to whatever your environment uses (e.g. a sandboxed `/home/*`
path in a hosted Claude environment, or a local project folder in Claude Code) — the structure is
what matters, not the exact filesystem prefix.

## Reusable Helper Functions

Define these once at the top of `build.js`, then compose the whole document from them. Pull colour
values from `brand-core`'s palette tokens rather than hardcoding hex — this example uses the
`brand-core` example palette directly:

```javascript
const fs = require('fs');
const {
  Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell, ImageRun,
  Header, Footer, AlignmentType, LevelFormat, PageBreak, HeadingLevel,
  BorderStyle, WidthType, ShadingType, VerticalAlign, PageNumber, TabStopType,
  TabStopPosition
} = require('docx');

// ---- Pull from brand-core's palette — see skills/brand-core/SKILL.md ----
const COLOR = {
  primary: "1E293B", secondary: "FFFFFF",
  accent1: "2563EB", accent2: "F59E0B", accent3: "10B981", accent4: "94A3B8",
  ink: "0F172A", muted: "64748B",
  // Soft tints for tables/callouts — derive from the accents above
  accent1Tint: "DDEBFF", accent2Tint: "FFF3D6", accent3Tint: "D7F5EA", primaryTint: "E2E8F0"
};

const border = { style: BorderStyle.SINGLE, size: 6, color: "BFBFBF" };
const borders = { top: border, bottom: border, left: border, right: border };
const cellMargins = { top: 100, bottom: 100, left: 140, right: 140 };

function p(text, opts = {}) {
  return new Paragraph({
    spacing: { before: opts.before ?? 60, after: opts.after ?? 60, line: 300 },
    alignment: opts.alignment ?? AlignmentType.LEFT,
    children: [new TextRun({
      text, bold: opts.bold ?? false, italics: opts.italics ?? false,
      size: opts.size ?? 22, color: opts.color ?? COLOR.ink, font: "Calibri"
    })]
  });
}

function bullet(text, level = 0) {
  return new Paragraph({
    numbering: { reference: "bullets", level },
    spacing: { before: 30, after: 30, line: 280 },
    children: [new TextRun({ text, size: 22, font: "Calibri" })]
  });
}

function h1(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_1,
    spacing: { before: 320, after: 160 },
    children: [new TextRun({ text, bold: true, size: 32, color: COLOR.accent1, font: "Calibri" })]
  });
}

function h2(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_2,
    spacing: { before: 260, after: 120 },
    children: [new TextRun({ text, bold: true, size: 26, color: COLOR.primary, font: "Calibri" })]
  });
}

function cell(text, opts = {}) {
  const runs = Array.isArray(text)
    ? text.map(t => new TextRun({ text: t.text, bold: t.bold, size: t.size ?? 20, color: t.color ?? COLOR.ink, font: "Calibri" }))
    : [new TextRun({ text: String(text), bold: opts.bold ?? false, size: opts.size ?? 20, color: opts.color ?? COLOR.ink, font: "Calibri" })];
  return new TableCell({
    width: { size: opts.width ?? 2000, type: WidthType.DXA },
    shading: opts.fill ? { fill: opts.fill, type: ShadingType.CLEAR } : undefined,
    borders, margins: cellMargins, verticalAlign: VerticalAlign.CENTER,
    children: [new Paragraph({ alignment: opts.alignment ?? AlignmentType.LEFT, spacing: { before: 0, after: 0 }, children: runs })]
  });
}

function headerCell(text, width) {
  return cell(text, { bold: true, color: "FFFFFF", fill: COLOR.primary, width, alignment: AlignmentType.LEFT });
}

function imageBlock(filename, widthPx, heightPx) {
  const data = fs.readFileSync(filename);
  return new Paragraph({
    alignment: AlignmentType.CENTER,
    spacing: { before: 160, after: 160 },
    children: [new ImageRun({ data, type: "png", transformation: { width: widthPx, height: heightPx } })]
  });
}

function caption(text) {
  return new Paragraph({
    alignment: AlignmentType.CENTER,
    spacing: { before: 0, after: 240 },
    children: [new TextRun({ text, italics: true, size: 18, color: COLOR.muted, font: "Calibri" })]
  });
}

function callout(title, body, fill = COLOR.accent1Tint, borderColor = COLOR.accent1) {
  const calloutBorder = { style: BorderStyle.SINGLE, size: 12, color: borderColor };
  return new Table({
    width: { size: 9360, type: WidthType.DXA }, columnWidths: [9360],
    rows: [new TableRow({ children: [new TableCell({
      width: { size: 9360, type: WidthType.DXA },
      shading: { fill, type: ShadingType.CLEAR },
      borders: { top: calloutBorder, bottom: calloutBorder, left: calloutBorder, right: calloutBorder },
      margins: { top: 200, bottom: 200, left: 280, right: 280 },
      children: [
        new Paragraph({ spacing: { before: 0, after: 80 }, children: [new TextRun({ text: title, bold: true, size: 22, color: borderColor, font: "Calibri" })] }),
        ...body.map(line => new Paragraph({ spacing: { before: 30, after: 30, line: 280 }, children: [new TextRun({ text: line, size: 21, font: "Calibri" })] }))
      ]
    })]})]
  });
}
```

Compose the document body from these helpers section by section, following the structure in
`references/format-generic-schedule-a.md`. Keep `build.js` organised as helper functions + a
sequence of `contentChildren.push(...)` calls per section — never one undifferentiated block.

## Header, Footer & Page Setup

Standard US Letter, with a branded header bar and confidentiality footer (see `brand-core`'s
cross-document conventions):

```javascript
const doc = new Document({
  creator: "[FIRM_NAME]",
  title: "[Client] — [Engagement] SOW",
  styles: { default: { document: { run: { font: "Calibri", size: 22 } } } },
  sections: [{
    properties: {
      page: {
        size: { width: 12240, height: 15840 },
        margin: { top: 1080, right: 1440, bottom: 1080, left: 1440, header: 720, footer: 720 }
      }
    },
    headers: {
      default: new Header({ children: [ new Paragraph({
        tabStops: [{ type: TabStopType.RIGHT, position: TabStopPosition.MAX }],
        border: { bottom: { color: COLOR.accent1, space: 4, style: BorderStyle.SINGLE, size: 12 } },
        children: [
          new TextRun({ text: "[FIRM_NAME]", bold: true, color: COLOR.accent1, size: 20, font: "Calibri" }),
          new TextRun({ text: "  |  [Client] — [Engagement] SOW", color: COLOR.muted, size: 20, font: "Calibri" }),
          new TextRun({ text: "\t", font: "Calibri" }),
          new TextRun({ text: "Schedule A", color: COLOR.muted, size: 20, font: "Calibri" })
        ]
      })]})
    },
    footers: {
      default: new Footer({ children: [ new Paragraph({
        tabStops: [{ type: TabStopType.RIGHT, position: TabStopPosition.MAX }],
        border: { top: { color: COLOR.accent1, space: 4, style: BorderStyle.SINGLE, size: 8 } },
        children: [
          new TextRun({ text: "Confidential — for the use of [Client] and [FIRM_NAME]", italics: true, color: COLOR.muted, size: 18, font: "Calibri" }),
          new TextRun({ text: "\t", font: "Calibri" }),
          new TextRun({ children: ["Page ", PageNumber.CURRENT, " of ", PageNumber.TOTAL_PAGES], color: COLOR.muted, size: 18, font: "Calibri" })
        ]
      })]})
    },
    children: contentChildren
  }]
});

Packer.toBuffer(doc).then(buffer => fs.writeFileSync(outputPath, buffer));
```

## Validation & QA Pipeline

Always validate and visually QA before considering a build complete:

```bash
# 1. Validate the docx structure
python3 <path-to-docx-skill>/scripts/office/validate.py <Client>_SOW_Draft.docx

# 2. Render to PDF and spot-check pages visually
python3 <path-to-docx-skill>/scripts/office/soffice.py --headless --convert-to pdf <Client>_SOW_Draft.docx
pdftoppm -jpeg -r 100 <Client>_SOW_Draft.pdf qa
```

Spot-check at minimum: the cover, an architecture diagram page, an activity table page, and the
commercials page. A document with a broken table or missing image is embarrassing and gets caught
immediately by the client — never skip this step.

## SVG → PNG Diagram Conversion Gotcha

Diagrams come from the `solution-diagrams` skill as SVG, converted to PNG for embedding
(`rsvg-convert -w 1600 -o diagram.png diagram.svg`). Any literal `&` inside SVG `<text>` content will
break the conversion (`xmlParseEntityRef: no name`) — always use `&amp;` instead. If conversion
fails, search the SVG for ` & ` and fix it before re-running.
