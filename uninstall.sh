#!/bin/bash
set -euo pipefail

# uninstall.sh - Remove AntiVibe Claude Code skill
# Usage: ./uninstall.sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SKILL_NAME="antivibe"
INSTALL_DIR="$HOME/.claude/skills/$SKILL_NAME"

if [ ! -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}AntiVibe is not installed at: $INSTALL_DIR${NC}"
    exit 0
fi

echo -e "${YELLOW}Removing AntiVibe from: $INSTALL_DIR${NC}"

rm -rf "$INSTALL_DIR"

if [ ! -d "$INSTALL_DIR" ]; then
    echo -e "${GREEN}AntiVibe uninstalled successfully.${NC}"
else
    echo -e "${RED}Uninstall failed. Please remove manually: $INSTALL_DIR${NC}"
    exit 1
fi
