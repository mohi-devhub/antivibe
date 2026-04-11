# AntiVibe Setup Guide

## What is AntiVibe?

AntiVibe is an **anti-vibecoding learning framework** for Claude Code. It generates detailed, learning-focused explanations of AI-written code, helping you understand what AI writes - not just accept it.

## Installation

### Installation

```bash
# Clone this repository
git clone https://github.com/mohi-devhub/antivibe.git

# Copy to Claude Code global skills directory
cp -r antivibe ~/.claude/skills/antivibe
```

## Usage

### Manual Invocation

Use the `/antivibe` command or describe what you want to learn:

- `/antivibe` - Start a deep dive
- "deep dive" - Analyze recently written code
- "learn from this code" - Generate learning guide
- "explain what AI wrote" - Explain specific files
- "understand what AI wrote" - Understand design decisions

### Automatic Triggers

Configure hooks to auto-trigger after task completion:

1. Copy hooks configuration to your project:
```bash
cp hooks/hooks.json your-project/.claude/hooks.json
```

2. Or manually integrate into existing hooks:
```json
{
  "hooks": {
    "SubagentStop": [...],
    "Stop": [...]
  }
}
```

## Output

Generated deep-dives are saved to the `deep-dive/` folder:

```
your-project/
├── deep-dive/
│   ├── auth-system-2026-01-15.md
│   ├── api-layer-2026-01-15.md
│   └── database-models-2026-01-15.md
```

Each file contains:
- Overview of what the code does
- Code walkthrough with explanations
- Concepts explained (design patterns, algorithms)
- Curated learning resources
- Related code in your project
- Next steps for deeper learning

## Configuration

### Enable/Disable Auto-Triggers

Edit `hooks/hooks.json` to customize:

```json
{
  "hooks": {
    "SubagentStop": [
      {
        "matcher": ".*",
        "hooks": [...] // Remove to disable
      }
    ],
    "Stop": [
      {
        "matcher": ".*",
        "hooks": [...] // Remove to disable
      }
    ]
  }
}
```

### Customize Output Location

Edit `scripts/generate-deep-dive.sh` to change output directory:
```bash
OUTPUT_DIR="your-custom-folder"  # Default: "deep-dive"
```

## File Structure

```
antivibe/
├── SKILL.md                    # Main skill definition
├── hooks/
│   └── hooks.json             # Auto-trigger configuration
├── scripts/
│   ├── capture-phase.sh       # Detect implementation phases
│   ├── analyze-code.sh        # Parse code structure
│   ├── find-resources.sh      # Find external resources
│   └── generate-deep-dive.sh  # Generate markdown output
├── agents/
│   └── explainer.md           # Subagent for detailed analysis
├── templates/
│   └── deep-dive.md           # Output template
├── reference/
│   ├── language-patterns.md  # Framework-specific patterns
│   └── resource-curation.md  # Curated learning resources
└── docs/
    └── setup.md               # This file
```

## How It Works

1. **Trigger**: You invoke `/antivibe` or it triggers automatically
2. **Identify**: Find code written in the session (via git diff or explicit file list)
3. **Analyze**: Use the explainer agent to deeply analyze the code
4. **Research**: Find relevant external resources
5. **Generate**: Create markdown output in `deep-dive/` folder
6. **Learn**: Read the detailed explanation and follow linked resources

## Principles

AntiVibe focuses on:
- **Why over what** - Explain design decisions
- **Curated resources** - Quality links, not random results
- **Phase-aware** - Group by implementation phase
- **Learning paths** - Suggest next steps
- **Concept mapping** - Connect to underlying CS principles

## Examples

### Example 1: Analyze Auth System

**Input**: "Explain the authentication system"
**Output**:
```markdown
# Deep Dive: Authentication System

## Overview
This auth system uses JWT tokens with refresh token rotation...

## Code Walkthrough
### auth/service.ts
- **Purpose**: Handles token generation and validation
- **Key Components**: 
  - `generateTokens()`: Creates access/refresh tokens
  - `verifyToken()`: Validates JWT signatures

## Concepts Explained
### JWT (JSON Web Tokens)
- **What**: Stateless authentication tokens...
- **Why**: Server doesn't need to store sessions...
- **When**: APIs, SPAs, microservices...

## Learning Resources
- [JWT.io](https://jwt.io): Official documentation
- [Auth0 Guide](https://auth0.com/blog): Best practices
```

## Troubleshooting

### Skill not loading

- Ensure `SKILL.md` is in the correct location
- Check that YAML frontmatter is valid
- Verify `name` field uses lowercase and hyphens only

### Hooks not triggering

- Verify `hooks.json` is valid JSON
- Ensure hooks are in project `.claude/` folder
- Check Claude Code version supports hooks

### Output not saving

- Verify `deep-dive/` folder exists
- Check write permissions
- Ensure you're in a git repository

## Contributing

To extend AntiVibe:

1. Add new patterns to `reference/language-patterns.md`
2. Add resources to `reference/resource-curation.md`
3. Customize the template in `templates/deep-dive.md`

## License

MIT