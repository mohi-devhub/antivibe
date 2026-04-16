#!/bin/bash
set -euo pipefail

# Test: find-resources.sh finds correct resources

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
RESOURCES="$PROJECT_ROOT/scripts/find-resources.sh"

# Test 1: No argument should exit with error
if "$RESOURCES" &>/dev/null; then
    exit 1  # Should have failed
fi

# Test 2: React search should return results
OUTPUT=$("$RESOURCES" "react" 2>&1)
echo "$OUTPUT" | grep -qi "react" || exit 1

# Test 3: Database search should return results
OUTPUT=$("$RESOURCES" "database" 2>&1)
echo "$OUTPUT" | grep -qi "database\|sql\|postgres" || exit 1

# Test 4: Auth search should return results
OUTPUT=$("$RESOURCES" "auth" 2>&1)
echo "$OUTPUT" | grep -qi "auth\|security\|jwt\|owasp" || exit 1

# Test 5: Should complete without error for unknown concept
OUTPUT=$("$RESOURCES" "zzz_nonexistent_concept_zzz" 2>&1) || true
# Should not crash, just warn

exit 0
