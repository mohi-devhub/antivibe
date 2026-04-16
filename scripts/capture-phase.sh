#!/bin/bash
set -euo pipefail

# capture-phase.sh - Detect implementation phase boundaries and list changed files
# Usage: ./capture-phase.sh [phase-name] [--time-window MINUTES]
# Exit codes: 0 success, 1 usage error

source "$(dirname "$0")/config.sh"

PHASE_NAME="${1:-manual}"
TIME_WINDOW="$ANTIVIBE_TIME_WINDOW"
MAX_FILES="$ANTIVIBE_MAX_FILES"

# Parse optional flags
shift 2>/dev/null || true
while [[ $# -gt 0 ]]; do
    case "$1" in
        --time-window)
            TIME_WINDOW="${2:-$TIME_WINDOW}"
            shift 2
            ;;
        --max-files)
            MAX_FILES="${2:-$MAX_FILES}"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

TIMESTAMP=$(date +"$ANTIVIBE_DATE_FORMAT")

log_info "Capturing phase: $PHASE_NAME"
log_info "Time window: ${TIME_WINDOW} minutes"
echo ""

# Determine changed files - prefer git if available
FILES_FOUND=()
FILE_COUNT=0

if git rev-parse --is-inside-work-tree &>/dev/null; then
    log_info "Using git to detect changes..."
    echo ""

    # Get recently modified tracked files
    echo "--- Modified Files (git) ---"
    while IFS= read -r file; do
        if [ -n "$file" ] && [ -f "$file" ]; then
            FILES_FOUND+=("$file")
            echo "$file"
            ((FILE_COUNT++)) || true
        fi
    done < <(git diff --name-only HEAD 2>/dev/null | head -"$MAX_FILES")

    # Also get untracked files
    echo ""
    echo "--- Untracked Files ---"
    while IFS= read -r file; do
        if [ -n "$file" ] && [ -f "$file" ]; then
            FILES_FOUND+=("$file")
            echo "$file"
            ((FILE_COUNT++)) || true
        fi
    done < <(git ls-files --others --exclude-standard 2>/dev/null | head -"$MAX_FILES")

    # Get stats
    echo ""
    echo "--- Change Stats ---"
    STATS=$(git diff --stat HEAD 2>/dev/null | tail -1 || echo "no changes")
    echo "git_stats=$STATS"
else
    log_info "Not a git repo, using file timestamps..."
    echo ""

    # Fall back to find for recently modified files
    echo "--- Recently Modified Files (last ${TIME_WINDOW}m) ---"
    while IFS= read -r file; do
        if [ -n "$file" ]; then
            FILES_FOUND+=("$file")
            echo "$file"
            ((FILE_COUNT++)) || true
        fi
    done < <(eval "find . -type f \( $ANTIVIBE_FIND_EXTENSIONS \) -mmin -${TIME_WINDOW} 2>/dev/null" | grep -v node_modules | grep -v '.git/' | head -"$MAX_FILES")
fi

echo ""
echo "--- Phase Summary ---"
echo "phase=$PHASE_NAME"
echo "timestamp=$TIMESTAMP"
echo "file_count=$FILE_COUNT"
echo "detection_method=$(git rev-parse --is-inside-work-tree &>/dev/null && echo 'git' || echo 'filesystem')"
echo ""

if [ "$FILE_COUNT" -eq 0 ]; then
    log_warn "No changed files found in the last ${TIME_WINDOW} minutes."
    log_info "Try increasing the time window: --time-window 120"
else
    log_success "Captured $FILE_COUNT files for phase '$PHASE_NAME'"
fi

echo ""
echo "---PHASE_CAPTURED---"
