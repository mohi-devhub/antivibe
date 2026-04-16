#!/bin/bash
set -euo pipefail

# Test: capture-phase.sh captures phase data correctly

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CAPTURE="$PROJECT_ROOT/scripts/capture-phase.sh"

# Test 1: Default phase name should be "manual"
OUTPUT=$("$CAPTURE" 2>&1)
echo "$OUTPUT" | grep -q "phase=manual" || exit 1

# Test 2: Custom phase name should be captured
OUTPUT=$("$CAPTURE" "test-phase" 2>&1)
echo "$OUTPUT" | grep -q "phase=test-phase" || exit 1

# Test 3: Output should contain timestamp
OUTPUT=$("$CAPTURE" "test" 2>&1)
echo "$OUTPUT" | grep -q "timestamp=" || exit 1

# Test 4: Output should contain file_count
OUTPUT=$("$CAPTURE" "test" 2>&1)
echo "$OUTPUT" | grep -q "file_count=" || exit 1

# Test 5: Output should end with PHASE_CAPTURED marker
OUTPUT=$("$CAPTURE" "test" 2>&1)
echo "$OUTPUT" | grep -q "PHASE_CAPTURED" || exit 1

# Test 6: Should report detection method
OUTPUT=$("$CAPTURE" "test" 2>&1)
echo "$OUTPUT" | grep -q "detection_method=" || exit 1

exit 0
