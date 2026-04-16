#!/bin/bash
set -euo pipefail

# install.sh - Install AntiVibe as a Claude Code skill
# Usage: ./install.sh [--global]

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_NAME="antivibe"

# Determine installation target
if [[ "${1:-}" == "--global" ]]; then
    INSTALL_DIR="$HOME/.claude/skills/$SKILL_NAME"
    echo -e "${BLUE}Installing AntiVibe globally...${NC}"
else
    INSTALL_DIR="$HOME/.claude/skills/$SKILL_NAME"
    echo -e "${BLUE}Installing AntiVibe to: $INSTALL_DIR${NC}"
fi

# Create target directory
mkdir -p "$INSTALL_DIR"

# Copy all skill files
cp -r "$SCRIPT_DIR/SKILL.md" "$INSTALL_DIR/"
cp -r "$SCRIPT_DIR/scripts" "$INSTALL_DIR/"
cp -r "$SCRIPT_DIR/agents" "$INSTALL_DIR/"
cp -r "$SCRIPT_DIR/templates" "$INSTALL_DIR/"
cp -r "$SCRIPT_DIR/reference" "$INSTALL_DIR/"
cp -r "$SCRIPT_DIR/hooks" "$INSTALL_DIR/"

# Make scripts executable
chmod +x "$INSTALL_DIR"/scripts/*.sh 2>/dev/null || true

# Verify installation
echo ""
if [ -f "$INSTALL_DIR/SKILL.md" ]; then
    echo -e "${GREEN}AntiVibe installed successfully!${NC}"
    echo ""
    echo "  Location: $INSTALL_DIR"
    echo "  Command:  /antivibe"
    echo ""
    echo -e "${YELLOW}Optional: Copy hooks to your project:${NC}"
    echo "  cp $INSTALL_DIR/hooks/hooks.json your-project/.claude/hooks.json"
    echo ""
else
    echo -e "${RED}Installation failed. Please check permissions.${NC}"
    exit 1
fi
