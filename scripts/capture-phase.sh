#!/bin/bash
# capture-phase.sh - Detect implementation phase boundaries
# Usage: ./capture-phase.sh [phase-name]

PHASE_NAME="${1:-manual}"
TIMESTAMP=$(date +%Y-%m-%d-%H%M%S)

echo "Capturing phase: $PHASE_NAME at $TIMESTAMP"

# Find newly created or modified files since last capture
# This helps identify what code was written in this phase

# Get list of recently modified files (last 1 hour)
find . -type f \( -name "*.ts" -o -name "*.js" -o -name "*.py" -o -name "*.go" -o -name "*.rs" -o -name "*.java" \) -mmin -60 2>/dev/null | head -50

echo "---PHASE_CAPTURED---"
echo "phase=$PHASE_NAME"
echo "timestamp=$TIMESTAMP"