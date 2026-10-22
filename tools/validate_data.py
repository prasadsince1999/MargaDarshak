#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Validate Mārgadarshak open data: rule cards and evidence cards.

Standard library only, so contributors can run it anywhere:

    python tools/validate_data.py

Exit code 0 means every file passed. Each problem is printed with the
card id and field, so a reviewer can point a contributor at the exact line.
"""
from __future__ import annotations

import datetime as dt
import json
import sys
from pathlib import Path
from urllib.parse import urlparse

ROOT = Path(__file__).resolve().parent.parent
RULE_CARDS = ROOT / "data" / "rule-cards" / "rule-cards.json"
EVIDENCE = ROOT / "data" / "evidence" / "evidence-cards.json"

STAGES = {
    "class10", "class11", "class12", "diploma", "iti",
    "undergraduate", "graduate", "postgraduate", "dropper",
}
MOMENTS = set("ABCDEFG")
RULE_STATUSES = {"verified", "partly_verified", "link_only", "blocked"}
EVIDENCE_TYPES = {
    "primary_document", "carried_over_primary", "official_page", "access_blocked",
}
TOOLS = {
    "Compare Paths", "What If", "Eligibility", "Exam Stack",
    "Cost Loan & ROI Calculator", "Document Check", "Foundation Check",
    "Explore", "My Plan", "Parent Mode", "Student Voice",
}
PLATFORMS = {"Reddit", "Court Case", "News Media", "YouTube", "Forum", "Quora"}
RULE_REQUIRED = (
    "id", "title", "rule", "appliesTo", "usedBy", "governingBody", "document",
    "section", "cycle", "sourceUrl", "evidenceType", "status", "checkedOn",
    "confirmNote",
)
EVIDENCE_REQUIRED = (
    "id", "appFeature", "websiteLabel", "platform", "reviewStatus",
    "situation", "consequence", "sourceUrl",
)


class Report:
    def __init__(self) -> None:
        self.errors: list[str] = []

    def error(self, where: str, message: str) -> None:
        self.errors.append(f"{where}: {message}")


def _is_url(value: object) -> bool:
    if not isinstance(value, str):
        return False
    parsed = urlparse(value)
    return parsed.scheme in {"http", "https"} and bool(parsed.netloc)


def _is_date(value: object) -> bool:
    try:
        dt.date.fromisoformat(str(value))
    except ValueError:
        return False
    return True


def _load(path: Path, report: Report) -> dict | None:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        report.error(str(path.relative_to(ROOT)), f"cannot read JSON ({exc})")
        return None


def validate_rule_cards(report: Report) -> int:
    data = _load(RULE_CARDS, report)
    if data is None:
        return 0
    cards = data.get("cards", [])
    seen: set[str] = set()
    for card in cards:
        cid = card.get("id", "<missing id>")
        where = f"rule-cards/{cid}"
        for field in RULE_REQUIRED:
            if field not in card or card[field] in ("", None):
                report.error(where, f"missing '{field}'")
        if cid in seen:
            report.error(where, "duplicate id")
        seen.add(cid)
        if card.get("status") not in RULE_STATUSES:
            report.error(where, f"status must be one of {sorted(RULE_STATUSES)}")
        if card.get("evidenceType") not in EVIDENCE_TYPES:
            report.error(where, f"evidenceType must be one of {sorted(EVIDENCE_TYPES)}")
        if not _is_date(card.get("checkedOn")):
            report.error(where, "checkedOn must be an ISO date (YYYY-MM-DD)")
        if card.get("status") != "blocked" and not _is_url(card.get("sourceUrl")):
            report.error(where, "sourceUrl must be an http(s) URL")
        applies = card.get("appliesTo") or {}
        for stage in applies.get("stages", []):
            if stage not in STAGES:
                report.error(where, f"unknown stage '{stage}'")
        for moment in applies.get("moments", []):
            if moment not in MOMENTS:
                report.error(where, f"unknown moment '{moment}'")
        for tool in card.get("usedBy", []):
            if tool not in TOOLS:
                report.error(where, f"unknown tool '{tool}'")
    return len(cards)


def validate_evidence(report: Report) -> int:
    data = _load(EVIDENCE, report)
    if data is None:
        return 0
    cards = data.get("cards", [])
    seen: set[str] = set()
    for card in cards:
        cid = card.get("id", "<missing id>")
        where = f"evidence/{cid}"
        for field in EVIDENCE_REQUIRED:
            if not card.get(field):
                report.error(where, f"missing '{field}'")
        if cid in seen:
            report.error(where, "duplicate id")
        seen.add(cid)
        if card.get("appFeature") not in TOOLS:
            report.error(where, f"unknown appFeature '{card.get('appFeature')}'")
        if card.get("platform") not in PLATFORMS:
            report.error(where, f"unknown platform '{card.get('platform')}'")
        if not _is_url(card.get("sourceUrl")):
            report.error(where, "sourceUrl must be an http(s) URL")
    return len(cards)


def main() -> int:
    report = Report()
    rules = validate_rule_cards(report)
    evidence = validate_evidence(report)
    for line in report.errors:
        print(f"ERROR {line}")
    print(f"Checked {rules} rule cards and {evidence} evidence cards: "
          f"{len(report.errors)} problem(s).")
    return 1 if report.errors else 0


if __name__ == "__main__":
    sys.exit(main())
