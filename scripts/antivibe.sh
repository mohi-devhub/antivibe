#!/bin/bash
set -euo pipefail

# antivibe.sh - Main orchestrator for the AntiVibe learning framework
# Usage: ./antivibe.sh <command> [options]
# Commands: analyze, capture, resources, generate, full, help

source "$(dirname "$0")/config.sh"

VERSION="1.0.0"

show_help() {
    cat << EOF
AntiVibe v${VERSION} - Anti-vibecoding Learning Framework

Usage: antivibe.sh <command> [options]

Commands:
  analyze <file>          Analyze a code file's structure and patterns
  capture [phase-name]    Capture recently changed files as a phase
  resources <concept>     Find learning resources for a concept
  generate <name> [files] Generate a deep-dive markdown file
  full [phase-name]       Run complete pipeline: capture -> analyze -> generate
  help                    Show this help message
  version                 Show version

Options:
  --time-window <min>     Minutes to look back for changes (default: 60)
  --output-dir <dir>      Output directory for deep-dives (default: deep-dive)

Examples:
  antivibe.sh analyze src/auth/service.ts
  antivibe.sh capture "auth-system"
  antivibe.sh resources "react hooks"
  antivibe.sh generate "api-layer" src/api/*.ts
  antivibe.sh full "feature-auth"

EOF
}

cmd_analyze() {
    local file="${1:-}"
    if [ -z "$file" ]; then
        log_error "Usage: antivibe.sh analyze <file>"
        exit 1
    fi
    "$ANTIVIBE_SCRIPTS/analyze-code.sh" "$file"
}

cmd_capture() {
    local phase="${1:-manual}"
    shift 2>/dev/null || true
    "$ANTIVIBE_SCRIPTS/capture-phase.sh" "$phase" "$@"
}

cmd_resources() {
    local concept="${1:-}"
    local lang="${2:-}"
    if [ -z "$concept" ]; then
        log_error "Usage: antivibe.sh resources <concept> [language]"
        exit 1
    fi
    "$ANTIVIBE_SCRIPTS/find-resources.sh" "$concept" "$lang"
}

cmd_generate() {
    local phase="${1:-code-analysis}"
    shift 2>/dev/null || true
    "$ANTIVIBE_SCRIPTS/generate-deep-dive.sh" "$phase" "$@"
}

cmd_full() {
    local phase="${1:-$(date +%Y-%m-%d)-session}"
    shift 2>/dev/null || true

    echo "============================================"
    echo "  AntiVibe Full Pipeline"
    echo "  Phase: $phase"
    echo "============================================"
    echo ""

    # Step 1: Capture changed files
    log_info "Step 1/3: Capturing changed files..."
    echo ""
    CAPTURE_OUTPUT=$("$ANTIVIBE_SCRIPTS/capture-phase.sh" "$phase" "$@" 2>&1)
    echo "$CAPTURE_OUTPUT"

    # Extract file list from capture output
    FILES=()
    while IFS= read -r line; do
        # Skip lines that are metadata or log output
        if [[ "$line" == ./* ]] && [ -f "$line" ]; then
            FILES+=("$line")
        fi
    done <<< "$CAPTURE_OUTPUT"

    echo ""
    echo "--------------------------------------------"
    echo ""

    # Step 2: Analyze each file
    if [ ${#FILES[@]} -gt 0 ]; then
        log_info "Step 2/3: Analyzing ${#FILES[@]} files..."
        echo ""
        for file in "${FILES[@]}"; do
            "$ANTIVIBE_SCRIPTS/analyze-code.sh" "$file" 2>/dev/null || true
            echo ""
        done
    else
        log_warn "Step 2/3: No files to analyze."
    fi

    echo ""
    echo "--------------------------------------------"
    echo ""

    # Step 3: Generate deep-dive
    log_info "Step 3/3: Generating deep-dive..."
    echo ""
    "$ANTIVIBE_SCRIPTS/generate-deep-dive.sh" "$phase" "${FILES[@]}"

    echo ""
    echo "============================================"
    log_success "Pipeline complete!"
    echo "============================================"
}

# Main command dispatch
COMMAND="${1:-help}"
shift 2>/dev/null || true

case "$COMMAND" in
    analyze)    cmd_analyze "$@" ;;
    capture)    cmd_capture "$@" ;;
    resources)  cmd_resources "$@" ;;
    generate)   cmd_generate "$@" ;;
    full)       cmd_full "$@" ;;
    version)    echo "AntiVibe v${VERSION}" ;;
    help|--help|-h)  show_help ;;
    *)
        log_error "Unknown command: $COMMAND"
        echo ""
        show_help
        exit 1
        ;;
esac
