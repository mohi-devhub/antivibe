#!/bin/bash
# config.sh - Central configuration for AntiVibe scripts
# Source this file from other scripts: source "$(dirname "$0")/config.sh"

# Output settings
ANTIVIBE_OUTPUT_DIR="${ANTIVIBE_OUTPUT_DIR:-deep-dive}"
ANTIVIBE_DATE_FORMAT="${ANTIVIBE_DATE_FORMAT:-%Y-%m-%d-%H%M%S}"

# Phase capture settings
ANTIVIBE_TIME_WINDOW="${ANTIVIBE_TIME_WINDOW:-60}"  # minutes to look back for modified files
ANTIVIBE_MAX_FILES="${ANTIVIBE_MAX_FILES:-50}"       # max files to capture per phase

# Supported file extensions for code analysis
ANTIVIBE_EXTENSIONS="ts js tsx jsx py go rs java kt swift cs rb php c cpp h hpp vue svelte"

# find-compatible extension filter
ANTIVIBE_FIND_EXTENSIONS='-name "*.ts" -o -name "*.js" -o -name "*.tsx" -o -name "*.jsx" -o -name "*.py" -o -name "*.go" -o -name "*.rs" -o -name "*.java" -o -name "*.kt" -o -name "*.swift" -o -name "*.cs" -o -name "*.rb" -o -name "*.php" -o -name "*.c" -o -name "*.cpp" -o -name "*.vue" -o -name "*.svelte"'

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging helpers
log_info() { echo -e "${BLUE}[antivibe]${NC} $*"; }
log_success() { echo -e "${GREEN}[antivibe]${NC} $*"; }
log_warn() { echo -e "${YELLOW}[antivibe]${NC} $*"; }
log_error() { echo -e "${RED}[antivibe]${NC} $*" >&2; }

# Get the root directory of the antivibe skill
ANTIVIBE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ANTIVIBE_SCRIPTS="$ANTIVIBE_ROOT/scripts"
ANTIVIBE_REFERENCE="$ANTIVIBE_ROOT/reference"
ANTIVIBE_TEMPLATES="$ANTIVIBE_ROOT/templates"
