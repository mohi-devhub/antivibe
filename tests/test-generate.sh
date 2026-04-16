#!/bin/bash
set -euo pipefail

# Test: generate-deep-dive.sh creates output files

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
GENERATE="$PROJECT_ROOT/scripts/generate-deep-dive.sh"
FIXTURES="$SCRIPT_DIR/fixtures"

# Use a temp directory for output
export ANTIVIBE_OUTPUT_DIR=$(mktemp -d)
trap "rm -rf $ANTIVIBE_OUTPUT_DIR" EXIT

# Test 1: Should create output file
"$GENERATE" "test-phase" "$FIXTURES/sample.ts" &>/dev/null
FILE_COUNT=$(ls "$ANTIVIBE_OUTPUT_DIR"/*.md 2>/dev/null | wc -l)
[ "$FILE_COUNT" -ge 1 ] || exit 1

# Test 2: Output file should contain phase name
OUTPUT_FILE=$(ls "$ANTIVIBE_OUTPUT_DIR"/*.md | head -1)
grep -q "test-phase" "$OUTPUT_FILE" || exit 1

# Test 3: Output file should contain file path
grep -q "sample.ts" "$OUTPUT_FILE" || exit 1

# Test 4: Output file should contain template sections
grep -q "## Overview" "$OUTPUT_FILE" || exit 1
grep -q "## Code Walkthrough" "$OUTPUT_FILE" || exit 1
grep -q "## Concepts Explained" "$OUTPUT_FILE" || exit 1
grep -q "## Learning Resources" "$OUTPUT_FILE" || exit 1

# Test 5: Should handle multiple files
"$GENERATE" "multi-test" "$FIXTURES/sample.ts" "$FIXTURES/sample.py" &>/dev/null
MULTI_FILE=$(ls "$ANTIVIBE_OUTPUT_DIR"/multi-test*.md | head -1)
grep -q "sample.ts" "$MULTI_FILE" || exit 1
grep -q "sample.py" "$MULTI_FILE" || exit 1

exit 0
