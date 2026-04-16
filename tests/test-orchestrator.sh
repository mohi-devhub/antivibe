#!/bin/bash
set -euo pipefail

# Test: antivibe.sh orchestrator commands

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ANTIVIBE="$PROJECT_ROOT/scripts/antivibe.sh"

# Test 1: Help command should work
OUTPUT=$("$ANTIVIBE" help 2>&1)
echo "$OUTPUT" | grep -q "Usage" || exit 1
echo "$OUTPUT" | grep -q "Commands" || exit 1

# Test 2: Version command should work
OUTPUT=$("$ANTIVIBE" version 2>&1)
echo "$OUTPUT" | grep -q "AntiVibe" || exit 1

# Test 3: Unknown command should fail
if "$ANTIVIBE" nonexistent_command &>/dev/null; then
    exit 1  # Should have failed
fi

# Test 4: Analyze subcommand should work with fixture
OUTPUT=$("$ANTIVIBE" analyze "$SCRIPT_DIR/fixtures/sample.ts" 2>&1)
echo "$OUTPUT" | grep -q "Analysis Complete" || exit 1

# Test 5: Resources subcommand should work
OUTPUT=$("$ANTIVIBE" resources "react" 2>&1)
echo "$OUTPUT" | grep -qi "react" || exit 1

exit 0
