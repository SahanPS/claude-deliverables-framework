# Build Mechanics

openpyxl code pattern and verification steps for building an estimate workbook. Read the main
`xlsx` SKILL.md first for base mechanics — this file layers the estimate-specific structure on top.

## Style Constants

```python
from openpyxl import Workbook
from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
from openpyxl.utils import get_column_letter

THIN = Side(border_style="thin", color="BFBFBF")
BORDER = Border(left=THIN, right=THIN, top=THIN, bottom=THIN)

# Pull these from brand-core's palette — see skills/brand-core/SKILL.md
HDR_FILL = PatternFill("solid", start_color="1E293B")     # brand-core: primary
HDR_FONT = Font(name="Arial", bold=True, color="FFFFFF", size=10)
SUB_FILL = PatternFill("solid", start_color="DDEBFF")     # brand-core: accent-1 tint
SUB_FONT = Font(name="Arial", bold=True, size=10, color="1E293B")
TOTAL_FILL = PatternFill("solid", start_color="FFF3D6")   # brand-core: accent-2 tint
TOTAL_FONT = Font(name="Arial", bold=True, size=10)

# Financial model colour convention — see brand-core, this is a genuine invariant
INPUT_FONT = Font(name="Arial", size=10, color="0000FF")    # BLUE — hardcoded input
FORMULA_FONT = Font(name="Arial", size=10)                   # BLACK — computed
LINK_FONT = Font(name="Arial", size=10, color="006100")      # GREEN — cross-sheet link

CURRENCY = '"[SYM] "#,##0;[Red]"[SYM] "(#,##0);"-"'  # set [SYM] to the engagement's currency
NUMBER = '#,##0;[Red](#,##0);"-"'
```

## Rate Reference Map

Map level names to the exact Rates sheet cell so every horizon sheet links consistently:

```python
RATE_REF = {
    "Associate": "Rates!$D$6",
    "Senior Associate": "Rates!$D$7",
    "Manager": "Rates!$D$8",
    "Senior Manager": "Rates!$D$9",
    "Director": "Rates!$D$10",
}
```

Populate this with your firm's real level names and Rates sheet cells via the private overlay —
this is a placeholder level structure.

## Horizon Sheet Builder Pattern

```python
def build_horizon_sheet(wb, sheet_name, horizon_label, sprint_count, weeks_per_sprint, pods):
    """
    pods: list of dicts:
      {
        "name": "Build Pod - [Workstream]",
        "resources": [
          {"role": "...", "level": "Senior Manager", "location": "Onshore",
           "weekly_days": [5, 5, 5, ...]}  # length = sprint_count * weeks_per_sprint
        ]
      }
    """
    ws = wb.create_sheet(sheet_name)
    ws.sheet_view.showGridLines = False
    total_weeks = sprint_count * weeks_per_sprint

    # 1. Title rows (1-2, merged)
    # 2. Main headers (row 4): Resource, Level, Location, Day Rate, Hour Rate,
    #    Sell Total, Total Days, then sprint headers
    # 3. Week numbers (row 5)
    # 4. For each pod: header row (sub-fill) -> resource rows -> pod header row
    #    gets SUM subtotal formulas referencing its own resource rows
    # 5. Grand total row at the bottom, summing all pod header rows by reference
    # 6. Freeze panes at the first weekly-effort column
    # 7. Set column widths (see references/workbook-structure.md)

    return grand_total_row
```

## Recalculation & Verification

Always run the recalculation script after saving, and confirm zero formula errors before delivering:

```bash
python /path/to/xlsx-skill/scripts/recalc.py <output_file>
```

Must return success with zero errors. If any `#REF!`, `#DIV/0!`, `#NAME?`, or `#VALUE!` errors appear,
fix them before delivering — an estimate with a formula error kills credibility with a client's
finance/procurement team instantly.

**Verify the totals are sensible**: read the workbook back with `data_only=True` and print the grand
total for each horizon and the programme total. Sanity-check that the number lands in a plausible
range for the scope before presenting it — a wildly off total usually means a formula reference
error, not an unusual engagement.
