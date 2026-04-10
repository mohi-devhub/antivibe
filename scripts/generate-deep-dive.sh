#!/bin/bash
# generate-deep-dive.sh - Generate markdown output from analysis
# Usage: ./generate-deep-dive.sh [phase-name] [files...]

PHASE_NAME="${1:-code-analysis}"
shift
FILES=("$@")

TIMESTAMP=$(date +%Y-%m-%d-%H%M%S)
OUTPUT_DIR="deep-dive"
OUTPUT_FILE="$OUTPUT_DIR/${PHASE_NAME}-${TIMESTAMP}.md"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Generate header
cat > "$OUTPUT_FILE" << 'EOF'
# Deep Dive

EOF

echo "# $PHASE_NAME" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "**Generated**: $(date '+%Y-%m-%d %H:%M:%S')" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Add overview section
cat >> "$OUTPUT_FILE" << 'EOF'
## Overview

<!-- Add your overview here: What does this code do and why does it exist? -->

### What This Code Does

_Describe the functionality in plain language_

### Why This Approach Was Taken

_Explain the design decisions and trade-offs_

---

## Code Walkthrough

EOF

# Process each file
for FILE in "${FILES[@]}"; do
    if [ -f "$FILE" ]; then
        echo "" >> "$OUTPUT_FILE"
        echo "### $(basename "$FILE")" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        echo "**Path**: \`$FILE\`" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        echo "**Purpose**: _What this file handles_" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        echo "**Key Components**:" >> "$OUTPUT_FILE"
        echo "- _Function/Class 1_: _Purpose_" >> "$OUTPUT_FILE"
        echo "- _Function/Class 2_: _Purpose_" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
    fi
done

# Add concepts section
cat >> "$OUTPUT_FILE" << 'EOF'

---

## Concepts Explained

### Design Patterns Used

| Pattern | Where Used | Why |
|---------|------------|-----|
| _Pattern name_ | _File/function_ | _Design rationale_ |

### Key Concepts

#### Concept Name

- **What**: _Plain language explanation_
- **Why**: _Why this approach over alternatives_
- **When to use**: _Context for usage_
- **Alternatives**: _Other approaches_

---

## Learning Resources

### Official Documentation

- [_Link_]: _What you'll learn here_

### Tutorials & Articles

- [_Link_]: _Why this is helpful_

### Videos

- [_Link_]: _What it covers_

---

## Related Code

<!-- Link to other relevant files in the codebase -->

- _Related file_: _How it connects_

---

## Next Steps

1. _Suggested learning path_
2. _Deeper exploration topics_
3. _Practice exercises_

EOF

echo "Generated: $OUTPUT_FILE"
echo ""
echo "Edit this file to add your specific analysis!"