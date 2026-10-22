# Rule cards

[`rule-cards.json`](rule-cards.json) holds 36 rules from Indian admission, exam and recruitment documents. Each was read in the official document, with the section and the date it was checked.

| Status | Count | Meaning |
|---|---|---|
| verified | 33 | Read in the primary document; section given |
| partly_verified | 1 | Official page read; some detail only via summaries (NIOS–DGT) |
| link_only | 1 | Links to a live official list (UGC fake universities) |
| blocked | 1 | The official site's certificate was invalid, so the document was not read and no rule is stated (RRB ALP 2026) |

**Covered (cycle 2026):** JoSAA business rules, MCC NEET UG counselling, OJEE (including diploma lateral entry), SSC JE, the Apprenticeship (Amendment) Rules 2025 stipends, JEE Main, JEE Advanced, NEET UG, CUET UG/PG, CLAT, GATE, UGC NET and CAT.

**How cards are kept honest:**
- Every card has a `cycle`. A new year gets a new card; old ones are not silently overwritten.
- Admission windows are rechecked during the window and before any app recommendation, and other notices weekly.
- A card shows the rule in plain words plus where it is written. Readers should still confirm in the current official notice. Every card says so in `confirmNote`.

Field meanings are in [CONTRIBUTING.md](../../CONTRIBUTING.md#field-reference-rule-cards). Validate with `python tools/validate_data.py`.
