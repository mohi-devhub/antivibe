#!/bin/bash
set -euo pipefail

# analyze-code.sh - Parse code structure, identify patterns, and output metrics
# Usage: ./analyze-code.sh <file-path> [--json]
# Exit codes: 0 success, 1 usage error, 2 file error

source "$(dirname "$0")/config.sh"

FILE_PATH="${1:-}"
OUTPUT_FORMAT="${2:-text}"

if [ -z "$FILE_PATH" ]; then
    log_error "Usage: ./analyze-code.sh <file-path> [--json]"
    exit 1
fi

if [ ! -f "$FILE_PATH" ]; then
    log_error "File not found: $FILE_PATH"
    exit 2
fi

if [ ! -r "$FILE_PATH" ]; then
    log_error "File not readable: $FILE_PATH"
    exit 2
fi

# Get file metadata
EXTENSION="${FILE_PATH##*.}"
LINE_COUNT=$(wc -l < "$FILE_PATH" 2>/dev/null || echo "0")
FILE_SIZE=$(wc -c < "$FILE_PATH" 2>/dev/null || echo "0")
FILENAME=$(basename "$FILE_PATH")

# Count metrics helper - returns count of grep matches
count_matches() {
    local pattern="$1"
    local file="$2"
    grep -cE "$pattern" "$file" 2>/dev/null || echo "0"
}

# Extract matches helper - returns matching lines
extract_matches() {
    local pattern="$1"
    local file="$2"
    local max="${3:-20}"
    grep -E "$pattern" "$file" 2>/dev/null | head -"$max" || true
}

echo "=== Analyzing: $FILE_PATH ==="
echo ""
echo "--- File Info ---"
echo "file=$FILENAME"
echo "extension=$EXTENSION"
echo "lines=$LINE_COUNT"
echo "size_bytes=$FILE_SIZE"
echo ""

# Language-specific analysis
case "$EXTENSION" in
    ts|tsx|js|jsx|mjs|cjs)
        echo "--- JavaScript/TypeScript Structure ---"
        echo ""
        echo "Functions:"
        extract_matches "^[[:space:]]*(export[[:space:]]+)?(default[[:space:]]+)?(async[[:space:]]+)?(function|const|let|var)[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Classes:"
        extract_matches "^[[:space:]]*(export[[:space:]]+)?(default[[:space:]]+)?(abstract[[:space:]]+)?class[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Interfaces/Types:"
        extract_matches "^[[:space:]]*(export[[:space:]]+)?(interface|type)[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Imports:"
        extract_matches "^import[[:space:]]+" "$FILE_PATH" 15
        echo ""
        echo "Exports:"
        extract_matches "^export[[:space:]]+" "$FILE_PATH" 15
        echo ""
        echo "--- Metrics ---"
        echo "function_count=$(count_matches '(function[[:space:]]|=>[[:space:]]|=>$)' "$FILE_PATH")"
        echo "class_count=$(count_matches '^[[:space:]]*(export[[:space:]]+)?(abstract[[:space:]]+)?class[[:space:]]' "$FILE_PATH")"
        echo "import_count=$(count_matches '^import[[:space:]]' "$FILE_PATH")"
        ;;

    py)
        echo "--- Python Structure ---"
        echo ""
        echo "Classes:"
        extract_matches "^class[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Functions:"
        extract_matches "^(async[[:space:]]+)?def[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Methods (indented):"
        extract_matches "^[[:space:]]+(async[[:space:]]+)?def[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Imports:"
        extract_matches "^(import[[:space:]]|from[[:space:]])" "$FILE_PATH" 15
        echo ""
        echo "Decorators:"
        extract_matches "^[[:space:]]*@" "$FILE_PATH" 10
        echo ""
        echo "--- Metrics ---"
        echo "function_count=$(count_matches '^(async[[:space:]]+)?def[[:space:]]' "$FILE_PATH")"
        echo "method_count=$(count_matches '^[[:space:]]+(async[[:space:]]+)?def[[:space:]]' "$FILE_PATH")"
        echo "class_count=$(count_matches '^class[[:space:]]' "$FILE_PATH")"
        echo "import_count=$(count_matches '^(import[[:space:]]|from[[:space:]])' "$FILE_PATH")"
        echo "decorator_count=$(count_matches '^[[:space:]]*@' "$FILE_PATH")"
        ;;

    go)
        echo "--- Go Structure ---"
        echo ""
        echo "Functions:"
        extract_matches "^func[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Structs:"
        extract_matches "^type[[:space:]]+.*struct[[:space:]]*\{?" "$FILE_PATH"
        echo ""
        echo "Interfaces:"
        extract_matches "^type[[:space:]]+.*interface[[:space:]]*\{?" "$FILE_PATH"
        echo ""
        echo "Imports:"
        extract_matches "^[[:space:]]*\"" "$FILE_PATH" 15
        echo ""
        echo "--- Metrics ---"
        echo "function_count=$(count_matches '^func[[:space:]]' "$FILE_PATH")"
        echo "struct_count=$(count_matches '^type[[:space:]]+.*struct' "$FILE_PATH")"
        echo "interface_count=$(count_matches '^type[[:space:]]+.*interface' "$FILE_PATH")"
        ;;

    rs)
        echo "--- Rust Structure ---"
        echo ""
        echo "Functions:"
        extract_matches "^[[:space:]]*(pub[[:space:]]+)?(async[[:space:]]+)?fn[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Structs:"
        extract_matches "^[[:space:]]*(pub[[:space:]]+)?struct[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Enums:"
        extract_matches "^[[:space:]]*(pub[[:space:]]+)?enum[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Traits:"
        extract_matches "^[[:space:]]*(pub[[:space:]]+)?trait[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Impl blocks:"
        extract_matches "^impl[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Use statements:"
        extract_matches "^use[[:space:]]+" "$FILE_PATH" 15
        echo ""
        echo "--- Metrics ---"
        echo "function_count=$(count_matches '(pub[[:space:]]+)?(async[[:space:]]+)?fn[[:space:]]' "$FILE_PATH")"
        echo "struct_count=$(count_matches '(pub[[:space:]]+)?struct[[:space:]]' "$FILE_PATH")"
        echo "enum_count=$(count_matches '(pub[[:space:]]+)?enum[[:space:]]' "$FILE_PATH")"
        echo "trait_count=$(count_matches '(pub[[:space:]]+)?trait[[:space:]]' "$FILE_PATH")"
        echo "impl_count=$(count_matches '^impl[[:space:]]' "$FILE_PATH")"
        ;;

    java)
        echo "--- Java Structure ---"
        echo ""
        echo "Classes/Interfaces/Enums:"
        extract_matches "^[[:space:]]*(public|private|protected)?[[:space:]]*(abstract|final)?[[:space:]]*(class|interface|enum|record)[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Methods:"
        extract_matches "^[[:space:]]*(public|private|protected)[[:space:]]+(static[[:space:]]+)?(final[[:space:]]+)?[a-zA-Z<>\[\]]+[[:space:]]+[a-zA-Z]+" "$FILE_PATH"
        echo ""
        echo "Imports:"
        extract_matches "^import[[:space:]]+" "$FILE_PATH" 15
        echo ""
        echo "Annotations:"
        extract_matches "^[[:space:]]*@[A-Z]" "$FILE_PATH" 10
        echo ""
        echo "--- Metrics ---"
        echo "class_count=$(count_matches '(class|interface|enum|record)[[:space:]]' "$FILE_PATH")"
        echo "method_count=$(count_matches '(public|private|protected)[[:space:]]' "$FILE_PATH")"
        echo "import_count=$(count_matches '^import[[:space:]]' "$FILE_PATH")"
        echo "annotation_count=$(count_matches '^[[:space:]]*@[A-Z]' "$FILE_PATH")"
        ;;

    kt|kts)
        echo "--- Kotlin Structure ---"
        echo ""
        echo "Classes:"
        extract_matches "^[[:space:]]*(data[[:space:]]+|sealed[[:space:]]+|abstract[[:space:]]+|open[[:space:]]+)?class[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Functions:"
        extract_matches "^[[:space:]]*(private[[:space:]]+|internal[[:space:]]+|override[[:space:]]+)?(suspend[[:space:]]+)?fun[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Objects:"
        extract_matches "^[[:space:]]*(companion[[:space:]]+)?object[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Imports:"
        extract_matches "^import[[:space:]]+" "$FILE_PATH" 15
        echo ""
        echo "--- Metrics ---"
        echo "class_count=$(count_matches 'class[[:space:]]' "$FILE_PATH")"
        echo "function_count=$(count_matches '(suspend[[:space:]]+)?fun[[:space:]]' "$FILE_PATH")"
        echo "import_count=$(count_matches '^import[[:space:]]' "$FILE_PATH")"
        ;;

    swift)
        echo "--- Swift Structure ---"
        echo ""
        echo "Classes/Structs/Enums:"
        extract_matches "^[[:space:]]*(public[[:space:]]+|private[[:space:]]+|internal[[:space:]]+|open[[:space:]]+)?(final[[:space:]]+)?(class|struct|enum|protocol|actor)[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Functions:"
        extract_matches "^[[:space:]]*(public[[:space:]]+|private[[:space:]]+|override[[:space:]]+)?(static[[:space:]]+)?func[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Imports:"
        extract_matches "^import[[:space:]]+" "$FILE_PATH" 15
        echo ""
        echo "--- Metrics ---"
        echo "type_count=$(count_matches '(class|struct|enum|protocol|actor)[[:space:]]' "$FILE_PATH")"
        echo "function_count=$(count_matches 'func[[:space:]]' "$FILE_PATH")"
        echo "import_count=$(count_matches '^import[[:space:]]' "$FILE_PATH")"
        ;;

    cs)
        echo "--- C# Structure ---"
        echo ""
        echo "Classes/Interfaces/Enums:"
        extract_matches "^[[:space:]]*(public|private|protected|internal)?[[:space:]]*(abstract|sealed|static|partial)?[[:space:]]*(class|interface|enum|struct|record)[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Methods:"
        extract_matches "^[[:space:]]*(public|private|protected|internal)[[:space:]]+(static[[:space:]]+)?(async[[:space:]]+)?(virtual[[:space:]]+|override[[:space:]]+)?[a-zA-Z<>\[\]]+[[:space:]]+[A-Z]" "$FILE_PATH"
        echo ""
        echo "Using statements:"
        extract_matches "^using[[:space:]]+" "$FILE_PATH" 15
        echo ""
        echo "Attributes:"
        extract_matches "^[[:space:]]*\[" "$FILE_PATH" 10
        echo ""
        echo "--- Metrics ---"
        echo "class_count=$(count_matches '(class|interface|enum|struct|record)[[:space:]]' "$FILE_PATH")"
        echo "method_count=$(count_matches '(public|private|protected|internal)[[:space:]]' "$FILE_PATH")"
        echo "using_count=$(count_matches '^using[[:space:]]' "$FILE_PATH")"
        ;;

    rb)
        echo "--- Ruby Structure ---"
        echo ""
        echo "Classes:"
        extract_matches "^[[:space:]]*class[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Modules:"
        extract_matches "^[[:space:]]*module[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Methods:"
        extract_matches "^[[:space:]]*def[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Requires:"
        extract_matches "^require" "$FILE_PATH" 15
        echo ""
        echo "--- Metrics ---"
        echo "class_count=$(count_matches '^[[:space:]]*class[[:space:]]' "$FILE_PATH")"
        echo "module_count=$(count_matches '^[[:space:]]*module[[:space:]]' "$FILE_PATH")"
        echo "method_count=$(count_matches '^[[:space:]]*def[[:space:]]' "$FILE_PATH")"
        ;;

    php)
        echo "--- PHP Structure ---"
        echo ""
        echo "Classes/Interfaces/Traits:"
        extract_matches "^[[:space:]]*(abstract[[:space:]]+|final[[:space:]]+)?(class|interface|trait|enum)[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Functions/Methods:"
        extract_matches "^[[:space:]]*(public|private|protected)?[[:space:]]*(static[[:space:]]+)?function[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Use statements:"
        extract_matches "^use[[:space:]]+" "$FILE_PATH" 15
        echo ""
        echo "--- Metrics ---"
        echo "class_count=$(count_matches '(class|interface|trait|enum)[[:space:]]' "$FILE_PATH")"
        echo "function_count=$(count_matches 'function[[:space:]]' "$FILE_PATH")"
        ;;

    c|cpp|cc|cxx|h|hpp)
        echo "--- C/C++ Structure ---"
        echo ""
        echo "Functions/Methods:"
        extract_matches "^[a-zA-Z_][a-zA-Z0-9_:*& ]+[[:space:]]+[a-zA-Z_][a-zA-Z0-9_]*[[:space:]]*\(" "$FILE_PATH"
        echo ""
        echo "Classes/Structs:"
        extract_matches "^[[:space:]]*(class|struct|enum)[[:space:]]+" "$FILE_PATH"
        echo ""
        echo "Includes:"
        extract_matches "^#include" "$FILE_PATH" 15
        echo ""
        echo "--- Metrics ---"
        echo "include_count=$(count_matches '^#include' "$FILE_PATH")"
        echo "class_count=$(count_matches '(class|struct)[[:space:]]' "$FILE_PATH")"
        ;;

    vue|svelte)
        echo "--- Component Structure ---"
        echo ""
        echo "Template:"
        extract_matches "^<(template|script|style)" "$FILE_PATH"
        echo ""
        echo "Script contents:"
        extract_matches "^[[:space:]]*(export|import|const|let|function|def)" "$FILE_PATH" 15
        echo ""
        echo "--- Metrics ---"
        echo "import_count=$(count_matches '^[[:space:]]*import[[:space:]]' "$FILE_PATH")"
        ;;

    *)
        echo "--- Generic Analysis ---"
        echo "Unsupported extension: $EXTENSION"
        echo "First 30 lines:"
        head -30 "$FILE_PATH" 2>/dev/null || true
        ;;
esac

echo ""
echo "=== Analysis Complete ==="
