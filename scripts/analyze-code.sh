#!/bin/bash
# analyze-code.sh - Parse code structure and identify patterns
# Usage: ./analyze-code.sh [file-path]

FILE_PATH="$1"

if [ -z "$FILE_PATH" ]; then
    echo "Usage: ./analyze-code.sh <file-path>"
    exit 1
fi

if [ ! -f "$FILE_PATH" ]; then
    echo "File not found: $FILE_PATH"
    exit 1
fi

echo "=== Analyzing: $FILE_PATH ==="
echo ""

# Get file extension
EXTENSION="${FILE_PATH##*.}"

echo "--- File Info ---"
echo "Extension: $EXTENSION"
echo "Lines: $(wc -l < "$FILE_PATH")"
echo ""

# Basic structure analysis based on language
case "$EXTENSION" in
    ts|js)
        echo "--- JavaScript/TypeScript Structure ---"
        echo "Functions:"
        grep -E "^(export )?(function|const|class|interface|type) " "$FILE_PATH" 2>/dev/null | head -20
        echo ""
        echo "Imports:"
        grep -E "^import " "$FILE_PATH" 2>/dev/null | head -10
        echo ""
        echo "Exports:"
        grep -E "^export " "$FILE_PATH" 2>/dev/null | head -10
        ;;
    py)
        echo "--- Python Structure ---"
        echo "Classes:"
        grep -E "^class " "$FILE_PATH" 2>/dev/null | head -20
        echo ""
        echo "Functions:"
        grep -E "^def " "$FILE_PATH" 2>/dev/null | head -20
        echo ""
        echo "Imports:"
        grep -E "^import |^from " "$FILE_PATH" 2>/dev/null | head -10
        ;;
    go)
        echo "--- Go Structure ---"
        echo "Functions:"
        grep -E "^func " "$FILE_PATH" 2>/dev/null | head -20
        echo ""
        echo "Structs:"
        grep -E "^type .* struct " "$FILE_PATH" 2>/dev/null | head -10
        echo ""
        echo "Interfaces:"
        grep -E "^type .* interface " "$FILE_PATH" 2>/dev/null | head -10
        ;;
    rs)
        echo "--- Rust Structure ---"
        echo "Functions:"
        grep -E "^fn " "$FILE_PATH" 2>/dev/null | head -20
        echo ""
        echo "Structs:"
        grep -E "^struct " "$FILE_PATH" 2>/dev/null | head -10
        echo ""
        echo "Traits:"
        grep -E "^trait " "$FILE_PATH" 2>/dev/null | head -10
        ;;
    java)
        echo "--- Java Structure ---"
        echo "Classes:"
        grep -E "^public (class|interface|enum) " "$FILE_PATH" 2>/dev/null | head -20
        echo ""
        echo "Methods:"
        grep -E " (public|private|protected) .*\(.*\) " "$FILE_PATH" 2>/dev/null | head -20
        ;;
    *)
        echo "--- Generic Analysis ---"
        echo "First 30 lines (overview):"
        head -30 "$FILE_PATH"
        ;;
esac

echo ""
echo "=== Analysis Complete ==="