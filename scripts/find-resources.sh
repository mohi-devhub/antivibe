#!/bin/bash
set -euo pipefail

# find-resources.sh - Find learning resources by concept using resources.json
# Usage: ./find-resources.sh <concept> [language/framework]
# Exit codes: 0 success, 1 usage error, 2 resource file missing

source "$(dirname "$0")/config.sh"

CONCEPT="${1:-}"
LANG="${2:-}"

if [ -z "$CONCEPT" ]; then
    log_error "Usage: ./find-resources.sh <concept> [language]"
    log_info "Example: ./find-resources.sh 'react hooks' react"
    log_info "Example: ./find-resources.sh 'authentication'"
    log_info "Example: ./find-resources.sh 'design patterns'"
    exit 1
fi

RESOURCES_FILE="$ANTIVIBE_REFERENCE/resources.json"

if [ ! -f "$RESOURCES_FILE" ]; then
    log_error "Resources file not found: $RESOURCES_FILE"
    log_info "Expected at: reference/resources.json"
    exit 2
fi

# Normalize concept to lowercase for matching
CONCEPT_LOWER=$(echo "$CONCEPT" | tr '[:upper:]' '[:lower:]')

log_info "Finding resources for: $CONCEPT"
[ -n "$LANG" ] && log_info "Language filter: $LANG"
echo ""

# Check if jq is available for proper JSON parsing
if command -v jq &>/dev/null; then
    # Use jq for proper JSON parsing
    MATCHES=$(jq -r --arg concept "$CONCEPT_LOWER" '
        .resources[] |
        select(.keywords[] | test($concept; "i")) |
        "CATEGORY:" + .category + "\n" +
        (.links[] | "  " + .type + " | " + .level + " | " + .title + "\n  " + .url)
    ' "$RESOURCES_FILE" 2>/dev/null || true)

    if [ -n "$MATCHES" ]; then
        CURRENT_CAT=""
        while IFS= read -r line; do
            if [[ "$line" == CATEGORY:* ]]; then
                CAT="${line#CATEGORY:}"
                if [ "$CAT" != "$CURRENT_CAT" ]; then
                    echo "--- $CAT Resources ---"
                    CURRENT_CAT="$CAT"
                fi
            else
                echo "$line"
            fi
        done <<< "$MATCHES"
    else
        log_warn "No exact matches found for: $CONCEPT"
        echo ""
        echo "--- Available Categories ---"
        jq -r '.resources[].category' "$RESOURCES_FILE" 2>/dev/null | sort -u
        echo ""
        log_info "Try a broader search term or check available categories above."
    fi
else
    # Fallback: basic grep-based matching on the JSON file
    log_warn "jq not installed - using basic text matching (install jq for better results)"
    echo ""

    # Simple grep for concept in the JSON file
    if grep -qi "$CONCEPT_LOWER" "$RESOURCES_FILE"; then
        echo "--- Matching Resources ---"
        # Extract URLs near the matched concept
        grep -B 2 -A 2 -i "$CONCEPT_LOWER" "$RESOURCES_FILE" | grep -E '"url"|"title"' | while IFS= read -r line; do
            # Clean up JSON formatting for display
            echo "$line" | sed 's/[",]//g' | sed 's/^[[:space:]]*/  /'
        done
    else
        log_warn "No matches found for: $CONCEPT"
        log_info "Try: react, typescript, database, auth, docker, testing, git, design patterns"
    fi
fi

echo ""
log_success "Resource search complete."
log_info "Validate links before including in output."
