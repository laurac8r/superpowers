#!/usr/bin/env bash
# Pressure scenario: ensure SKILL.md text enforces verbatim error reporting in BLOCKED branch
# Whitespace-tolerant: collapses newlines + runs of whitespace before matching, so a
# markdown formatter wrapping long lines at column 80 doesn't break literal-phrase asserts.
set -euo pipefail

SKILL_MD="$(dirname "$0")/../SKILL.md"

# Flatten content: newline → space, then collapse runs of whitespace to a single space.
flat=$(tr '\n' ' ' <"$SKILL_MD" | tr -s '[:space:]' ' ')

assert_in() {
  local needle="$1"
  local label="$2"
  if ! printf '%s' "$flat" | grep -qF -- "$needle"; then
    echo "FAIL: $label"
    exit 1
  fi
}

assert_in "MUST quote the verbatim error string" "BLOCKED branch missing 'MUST quote the verbatim error string'"
assert_in 'no error string visible — only blocked status' "BLOCKED branch missing 'no error string visible' fallback"
assert_in 'MUST NOT name a specific hook' "BLOCKED branch missing 'MUST NOT name a specific hook' guidance"
assert_in 'MUST cross-check any attributed cause' "Controller cross-check requirement missing"
assert_in 'unverified attribution' "Red Flag entry missing 'unverified attribution'"

echo "PASS: BLOCKED branch enforces verbatim error reporting"
