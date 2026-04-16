#!/bin/bash
set -euo pipefail

# Test: analyze-code.sh correctly analyzes different file types

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ANALYZE="$PROJECT_ROOT/scripts/analyze-code.sh"
FIXTURES="$SCRIPT_DIR/fixtures"

# Test 1: TypeScript file analysis should find classes, functions, imports
OUTPUT=$("$ANALYZE" "$FIXTURES/sample.ts" 2>&1)
echo "$OUTPUT" | grep -q "UserController" || exit 1
echo "$OUTPUT" | grep -q "validateEmail" || exit 1
echo "$OUTPUT" | grep -q "import" || exit 1

# Test 2: Python file analysis should find classes and functions
OUTPUT=$("$ANALYZE" "$FIXTURES/sample.py" 2>&1)
echo "$OUTPUT" | grep -q "class User" || exit 1
echo "$OUTPUT" | grep -q "def find_by_id" || exit 1

# Test 3: Go file analysis should find structs and functions
OUTPUT=$("$ANALYZE" "$FIXTURES/sample.go" 2>&1)
echo "$OUTPUT" | grep -q "func " || exit 1
echo "$OUTPUT" | grep -q "struct" || exit 1

# Test 4: Rust file analysis should find structs and traits
OUTPUT=$("$ANALYZE" "$FIXTURES/sample.rs" 2>&1)
echo "$OUTPUT" | grep -q "struct" || exit 1
echo "$OUTPUT" | grep -q "trait" || exit 1

# Test 5: Java file analysis
OUTPUT=$("$ANALYZE" "$FIXTURES/sample.java" 2>&1)
echo "$OUTPUT" | grep -q "class" || exit 1

# Test 6: Ruby file analysis
OUTPUT=$("$ANALYZE" "$FIXTURES/sample.rb" 2>&1)
echo "$OUTPUT" | grep -q "class" || exit 1
echo "$OUTPUT" | grep -q "module" || exit 1

# Test 7: Missing file should exit with error
if "$ANALYZE" "/nonexistent/file.ts" &>/dev/null; then
    exit 1  # Should have failed
fi

# Test 8: No arguments should exit with error
if "$ANALYZE" &>/dev/null; then
    exit 1  # Should have failed
fi

# Test 9: Output should contain metrics
OUTPUT=$("$ANALYZE" "$FIXTURES/sample.ts" 2>&1)
echo "$OUTPUT" | grep -q "function_count=" || exit 1
echo "$OUTPUT" | grep -q "lines=" || exit 1

exit 0
