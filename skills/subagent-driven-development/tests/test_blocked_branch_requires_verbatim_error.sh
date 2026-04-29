#!/usr/bin/env bash
# Pressure scenario: ensure SKILL.md text enforces verbatim error reporting in BLOCKED branch
set -euo pipefail

SKILL_MD="$(dirname "$0")/../SKILL.md"

if ! grep -q "MUST quote the verbatim error string" "$SKILL_MD"; then
    echo "FAIL: BLOCKED branch missing 'MUST quote the verbatim error string'"
    exit 1
fi

if ! grep -q 'no error string visible — only blocked status' "$SKILL_MD"; then
    echo "FAIL: BLOCKED branch missing 'no error string visible' fallback"
    exit 1
fi

if ! grep -q 'MUST NOT name a specific hook' "$SKILL_MD"; then
    echo "FAIL: BLOCKED branch missing 'MUST NOT name a specific hook' guidance"
    exit 1
fi

if ! grep -q 'MUST cross-check any attributed cause' "$SKILL_MD"; then
    echo "FAIL: Controller cross-check requirement missing"
    exit 1
fi

if ! grep -q 'unverified attribution' "$SKILL_MD"; then
    echo "FAIL: Red Flag entry missing 'unverified attribution'"
    exit 1
fi

echo "PASS: BLOCKED branch enforces verbatim error reporting"
