# Boilerplate Assumptions & Exclusions

Reusable generic starting text for the Scope & Assumptions sheet. Adapt the specifics to each
engagement — never paste verbatim without reviewing against the actual scope.

## Commercial & Scope
- Estimate is indicative only, based on [source document and date]. A firm fixed-price commitment
  will be made at the end of Phase 0 / discovery.
- Third-party platform licensing (e.g. the client's ERP/CRM vendor, cloud provider) is NOT included
  in the services cost and is purchased directly by the client.
- Travel and expenses (T&E) for onsite work are NOT included unless stated otherwise. Recommended
  provision: 8–10% of services cost.
- Hypercare (typically 4–6 weeks post go-live) is not included in the base estimate and can be added
  as a separate line item per horizon if required.
- Post go-live managed services, application support, and ongoing enhancements are a separate
  engagement.
- Any scope changes emerging from discovery will be managed through a formal change control process
  and may adjust the estimate.

## Delivery & Methodology
- Agile delivery with [N]-week sprints across build horizons; discovery runs as a fixed-duration
  phase.
- Each horizon concludes with UAT, go-live, and a separately-priced hypercare period.
- [Onshore/offshore/blended] delivery model, with rotation on-site for key workshops, design
  reviews, milestone gates, and go-live support as applicable.
- Standard working week of 5 days is assumed.

## Client Responsibilities
- Client will provide a Programme Sponsor, Programme Manager, and named Product Owners per
  workstream.
- Client IT will provide a dedicated IT Lead and Data Lead.
- Business SMEs available for workshops at an agreed cadence with agreed decision turnaround SLAs.
- [Where applicable] Client will formally engage any third-party managed service providers as
  participating parties — MSP availability is on the critical path.
- Client will provide sandbox/non-production environments for any integrated systems.
- Users available for training at agreed times prior to go-live.

## Technical & Architecture
- Data residency requirements [specify region] will be met via appropriate cloud region selection.
- Integration endpoints available via existing APIs or middleware; middleware development is in
  scope only where explicitly listed.
- System-of-record decisions documented per integration.
- [Near-real-time / batch / real-time] integration assumed — state the actual latency requirement
  explicitly, since a stricter requirement usually means additional architecture work.

## Data & Migration
- Data migration scope covers [N] years of historical data from [source systems].
- Client will provide source data in an agreed format and support cleansing/validation.
- Historical data beyond the scope cutoff is archived, not migrated.
- Master data cleansed and validated by client SMEs before load.

## Consolidated Exclusions (always include explicitly, in red text)
- Third-party/platform licensing
- Third-party ISV licences
- Travel & expenses (8–10% recommended provision if not otherwise quantified)
- Hypercare
- Post go-live managed services
- Any out-of-scope modules or capabilities, named explicitly
- Re-implementation of integrated systems outside the agreed boundary
- Network/security hardening beyond defaults
- Penetration testing
- Anything not explicitly listed under In Scope

The consolidated exclusions list is a structural invariant, not optional — a scope boundary that's
implied rather than written down is not a boundary a client will respect during delivery.
