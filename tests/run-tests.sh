#!/bin/bash
set -euo pipefail

# run-tests.sh - Test runner for AntiVibe
# Usage: ./tests/run-tests.sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

PASS=0
FAIL=0
TOTAL=0
FAILURES=()

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

run_test() {
    local test_name="$1"
    local test_file="$2"
    ((TOTAL++)) || true

    printf "  %-50s " "$test_name"

    if bash "$test_file" &>/dev/null; then
        echo -e "${GREEN}PASS${NC}"
        ((PASS++)) || true
    else
        echo -e "${RED}FAIL${NC}"
        ((FAIL++)) || true
        FAILURES+=("$test_name")
    fi
}

echo ""
echo "============================================"
echo "  AntiVibe Test Suite"
echo "============================================"
echo ""

# Make scripts executable
chmod +x "$PROJECT_ROOT"/scripts/*.sh 2>/dev/null || true

echo "--- Script Analysis Tests ---"
run_test "analyze-code.sh: TypeScript analysis" "$SCRIPT_DIR/test-analyze.sh"
run_test "capture-phase.sh: Phase capture" "$SCRIPT_DIR/test-capture.sh"
run_test "find-resources.sh: Resource lookup" "$SCRIPT_DIR/test-resources.sh"
run_test "generate-deep-dive.sh: Output generation" "$SCRIPT_DIR/test-generate.sh"
echo ""

echo "--- Integration Tests ---"
run_test "Orchestrator: help command" "$SCRIPT_DIR/test-orchestrator.sh"
echo ""

echo "--- Validation Tests ---"
run_test "resources.json: Valid JSON" "$SCRIPT_DIR/test-json-valid.sh"
run_test "All scripts: Have shebang" "$SCRIPT_DIR/test-shebangs.sh"
echo ""

echo "============================================"
echo -e "  Results: ${GREEN}${PASS} passed${NC}, ${RED}${FAIL} failed${NC}, ${TOTAL} total"
echo "============================================"

if [ ${#FAILURES[@]} -gt 0 ]; then
    echo ""
    echo -e "${RED}Failed tests:${NC}"
    for f in "${FAILURES[@]}"; do
        echo "  - $f"
    done
    exit 1
fi

echo ""
echo -e "${GREEN}All tests passed!${NC}"
exit 0
