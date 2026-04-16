# AntiVibe Setup Guide

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed and working
- Bash shell (Linux, macOS, or Git Bash on Windows)
- Optional: `jq` for better JSON parsing in resource lookup

## Installation

### Automated Install (Recommended)

```bash
git clone https://github.com/mohi-devhub/antivibe.git
cd antivibe
bash install.sh
```

This copies the skill to `~/.claude/skills/antivibe` and makes scripts executable.

### Manual Install

```bash
git clone https://github.com/mohi-devhub/antivibe.git
mkdir -p ~/.claude/skills/antivibe
cp -r antivibe/* ~/.claude/skills/antivibe/
chmod +x ~/.claude/skills/antivibe/scripts/*.sh
```

### Verify Installation

```bash
# Check the orchestrator works
bash ~/.claude/skills/antivibe/scripts/antivibe.sh version
# Expected: AntiVibe v1.0.0

# Run the test suite
cd antivibe
bash tests/run-tests.sh
# Expected: All tests passed!
```

## Usage

### Manual Invocation

Use the `/antivibe` command or natural language:

| Command | Description |
|---------|-------------|
| `/antivibe` | Start a deep dive on recently written code |
| `"antivibe deep dive"` | Same as above |
| `"explain what AI wrote"` | Explain specific files or recent changes |
| `"learn from this code"` | Generate a learning guide |
| `"understand what AI wrote"` | Understand design decisions |

### CLI Orchestrator

For direct use from the terminal:

```bash
# Analyze a file
bash scripts/antivibe.sh analyze src/auth/service.ts

# Capture a development phase
bash scripts/antivibe.sh capture "auth-system"

# Find resources for a concept
bash scripts/antivibe.sh resources "react hooks"

# Generate a deep-dive for specific files
bash scripts/antivibe.sh generate "api-layer" src/api/routes.ts src/api/middleware.ts

# Run the full pipeline
bash scripts/antivibe.sh full "feature-auth"
```

### Auto-Trigger Hooks

Configure hooks so AntiVibe suggests learning after each task:

```bash
# Copy to your project's .claude directory
mkdir -p your-project/.claude
cp hooks/hooks.json your-project/.claude/hooks.json
```

This enables:
- **SubagentStop**: After a coding task completes, suggests `/antivibe`
- **Stop**: At session end, suggests generating deep-dives for the session

To disable a hook, remove the corresponding entry from `hooks.json`.

## Output

Generated files are saved to `deep-dive/` in your project root:

```
your-project/
├── deep-dive/
│   ├── auth-system-2026-04-16-143022.md
│   ├── api-layer-2026-04-16-151505.md
│   └── database-models-2026-04-16-160830.md
```

## Configuration

### Environment Variables

Override defaults by setting environment variables:

```bash
# Change output directory
export ANTIVIBE_OUTPUT_DIR="learning-notes"

# Look back further for changes
export ANTIVIBE_TIME_WINDOW=120

# Limit captured files
export ANTIVIBE_MAX_FILES=30
```

### Customize Output Location

```bash
# Temporary (current session only)
ANTIVIBE_OUTPUT_DIR="my-notes" bash scripts/antivibe.sh full "feature"

# Permanent (add to your shell profile)
echo 'export ANTIVIBE_OUTPUT_DIR="learning-notes"' >> ~/.bashrc
```

## Troubleshooting

### Skill not loading in Claude Code
- Verify `SKILL.md` exists at `~/.claude/skills/antivibe/SKILL.md`
- Check YAML frontmatter is valid (no tabs, proper indentation)
- Restart Claude Code after installation

### Hooks not triggering
- Verify `hooks.json` is valid JSON: `cat hooks.json | node -e "process.stdin.pipe(require('stream').Writable())"`
- Ensure hooks file is in your project's `.claude/` folder
- Check Claude Code version supports hooks

### Output not saving
- Check write permissions on the output directory
- Run `mkdir -p deep-dive` manually to verify
- Try setting `ANTIVIBE_OUTPUT_DIR` to an absolute path

### Scripts not executable
```bash
chmod +x ~/.claude/skills/antivibe/scripts/*.sh
```

### Resource lookup returns no results
- Install `jq` for best results: `brew install jq` (macOS) or `apt install jq` (Linux)
- Without `jq`, the script falls back to basic text matching
- Check `reference/resources.json` exists and is valid JSON

### Analysis doesn't detect my language
- Check that your file extension matches a supported case in `analyze-code.sh`
- Supported extensions: ts, tsx, js, jsx, py, go, rs, java, kt, swift, cs, rb, php, c, cpp, vue, svelte
- For unsupported extensions, you'll get a generic first-30-lines analysis

### Tests failing
```bash
# Make scripts executable first
chmod +x scripts/*.sh tests/*.sh

# Run with verbose output
bash -x tests/test-analyze.sh
```

## Uninstall

```bash
# Automated
bash uninstall.sh

# Manual
rm -rf ~/.claude/skills/antivibe
```

## Extending AntiVibe

### Add a new language to analyze-code.sh
Add a case block in `scripts/analyze-code.sh`:
```bash
ext)
    echo "--- Language Structure ---"
    extract_matches "your-pattern" "$FILE_PATH"
    echo "--- Metrics ---"
    echo "count=$(count_matches 'pattern' "$FILE_PATH")"
    ;;
```

### Add resources
Edit `reference/resources.json` — add a new object to the `resources` array:
```json
{
  "keywords": ["your-concept", "related-terms"],
  "category": "Category Name",
  "links": [
    {"url": "https://...", "title": "Resource Title", "type": "docs", "level": "beginner"}
  ]
}
```

### Add patterns
Edit `reference/language-patterns.md` — add a new table following the existing format.

## License

MIT
