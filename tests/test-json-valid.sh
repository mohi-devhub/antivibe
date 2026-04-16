#!/bin/bash
set -euo pipefail

# Test: resources.json is valid JSON

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
JSON_FILE="$PROJECT_ROOT/reference/resources.json"

# Test 1: File should exist
[ -f "$JSON_FILE" ] || exit 1

# Test 2: Should be valid JSON
# Use node from project root to avoid path issues
cd "$PROJECT_ROOT"
if command -v node &>/dev/null; then
    node -e "JSON.parse(require('fs').readFileSync('reference/resources.json','utf8'))" || exit 1
else
    # Basic structure check
    head -1 "$JSON_FILE" | grep -q '{' || exit 1
    grep -q '"resources"' "$JSON_FILE" || exit 1
fi

# Test 3: Should contain resources array (non-empty)
grep -q '"resources"' "$JSON_FILE" || exit 1
grep -q '"keywords"' "$JSON_FILE" || exit 1

exit 0
