# AntiVibe

<p align="center">
  <img src="https://img.shields.io/badge/Anti--Vibecoding-Learning-orange?style=for-the-badge" alt="Anti-Vibecoding">
  <img src="https://img.shields.io/badge/Claude_Code-Skill-blue?style=for-the-badge" alt="Claude Code">
  <img src="https://img.shields.io/badge/v1.0.0-release-brightgreen?style=for-the-badge" alt="Version">
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License">
</p>

<p align="center">
  <strong>Learn what AI writes, not just accept it.</strong><br>
  A learning framework for Claude Code that turns AI-generated code into educational deep-dives.
</p>

---

## Table of Contents

- [The Problem](#the-problem)
- [Features](#features)
- [Quick Start](#quick-start)
- [Usage](#usage)
- [CLI Orchestrator](#cli-orchestrator)
- [Configuration](#configuration)
- [Supported Languages](#supported-languages)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

---

## The Problem

AI writes code. Developers copy-paste it. Nobody learns anything.

**AntiVibe fixes this.** It generates detailed explanations covering:
- **What** the code does (functionality)
- **Why** it was written this way (design decisions and trade-offs)
- **When** to use these patterns (context and alternatives)
- **What alternatives** exist (broader knowledge)

---

## Features

| Feature | Description |
|---------|-------------|
| **Deep Dives** | Comprehensive learning guides from AI-written code |
| **Concept Mapping** | Connect code to underlying CS principles |
| **Curated Resources** | Quality links to docs, tutorials, videos (29 categories) |
| **Phase-Aware** | Group explanations by implementation phase |
| **Auto-Trigger** | Optional hooks for automatic generation on task completion |
| **Multi-Language** | 14+ languages: JS/TS, Python, Go, Rust, Java, Kotlin, Swift, C#, Ruby, PHP, C/C++, Vue, Svelte |
| **CLI Orchestrator** | Unified `antivibe.sh` script with subcommands |
| **Data-Driven Resources** | JSON-based resource database, easy to extend |
| **Test Suite** | Automated tests for all components |
| **CI/CD** | GitHub Actions for linting and testing |

---

## Quick Start

### Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed
- Bash shell (Linux, macOS, or Git Bash on Windows)

### Installation

```bash
# Clone the repository
git clone https://github.com/mohi-devhub/antivibe.git
cd antivibe

# Option 1: Automated install
bash install.sh

# Option 2: Manual install
cp -r . ~/.claude/skills/antivibe
chmod +x ~/.claude/skills/antivibe/scripts/*.sh
```

### Verify Installation

```bash
# Check scripts work
bash scripts/antivibe.sh version
# Output: AntiVibe v1.0.0

# Run tests
bash tests/run-tests.sh
```

---

## Usage

### Commands

```
/antivibe                           # Start a deep dive on recent code
"antivibe deep dive"                # Same thing, natural language
"explain what AI wrote"             # Analyze specific files
"learn from this code"              # Generate learning guide
"understand what AI wrote"          # Understand design decisions
```

### Example Output

After running `/antivibe`, you get a file like `deep-dive/auth-system-2026-04-16.md`:

```markdown
# Deep Dive: Authentication System

## Overview
This auth system uses JWT tokens with refresh token rotation.
Access tokens are short-lived (15min) for security; refresh tokens
(7d) are stored in httpOnly cookies to prevent XSS theft.

## Concepts Explained

### JWT (JSON Web Tokens)
- **What**: Stateless authentication tokens encoded as base64 JSON
- **Why**: Server doesn't need to store sessions — scales horizontally
- **When**: APIs, SPAs, microservices where session storage is impractical
- **Alternative**: Session cookies — simpler, but requires server-side storage

## Learning Resources
- [JWT.io](https://jwt.io): Interactive JWT debugger and documentation
- [OWASP Auth Guide](https://cheatsheetseries.owasp.org/...): Security best practices
```

---

## CLI Orchestrator

The `antivibe.sh` script provides a unified command-line interface:

```bash
# Analyze a single file
bash scripts/antivibe.sh analyze src/auth/service.ts

# Capture recently changed files
bash scripts/antivibe.sh capture "auth-system"

# Find learning resources for a concept
bash scripts/antivibe.sh resources "react hooks"

# Generate a deep-dive from specific files
bash scripts/antivibe.sh generate "api-layer" src/api/*.ts

# Run the full pipeline (capture + analyze + generate)
bash scripts/antivibe.sh full "feature-auth"
```

---

## Configuration

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `ANTIVIBE_OUTPUT_DIR` | `deep-dive` | Where deep-dive files are saved |
| `ANTIVIBE_TIME_WINDOW` | `60` | Minutes to look back for changes |
| `ANTIVIBE_MAX_FILES` | `50` | Max files per phase capture |

### Auto-Trigger Hooks

Enable automatic deep-dive suggestions after task completion:

```bash
# Copy hooks to your project
cp hooks/hooks.json your-project/.claude/hooks.json
```

| Hook | Triggers When | What It Does |
|------|--------------|-------------|
| `SubagentStop` | Task completes | Suggests running `/antivibe` |
| `Stop` | Session ends | Suggests learning from session's code |

---

## Supported Languages

| Language | Analysis | Patterns | Resources |
|----------|----------|----------|-----------|
| JavaScript/TypeScript | Full | React, Node, Next.js, NestJS | Comprehensive |
| Python | Full | Django, FastAPI, Flask | Comprehensive |
| Go | Full | Standard library, patterns | Comprehensive |
| Rust | Full | Ownership, traits, async | Comprehensive |
| Java | Full | Spring Boot, records | Comprehensive |
| Kotlin | Full | Coroutines, data classes | Good |
| Swift | Full | SwiftUI, protocols | Good |
| C# | Full | .NET, LINQ, async | Good |
| Ruby | Full | Rails, concerns | Good |
| PHP | Full | Laravel, Eloquent | Good |
| C/C++ | Basic | Includes, structs | Basic |
| Vue/Svelte | Basic | Composition API, stores | Good |

---

## Project Structure

```
antivibe/
├── SKILL.md                     # Skill definition (triggers, workflow)
├── scripts/
│   ├── config.sh                # Central configuration
│   ├── antivibe.sh              # CLI orchestrator
│   ├── analyze-code.sh          # Code structure parser
│   ├── capture-phase.sh         # Phase detection (git-aware)
│   ├── find-resources.sh        # Resource lookup (data-driven)
│   └── generate-deep-dive.sh    # Markdown generator
├── agents/
│   └── explainer.md             # AI explainer instructions
├── templates/
│   └── deep-dive.md             # Output template with checklist
├── reference/
│   ├── resources.json           # 29-category resource database
│   ├── language-patterns.md     # Patterns for 14+ languages
│   └── resource-curation.md     # Curated links by topic
├── hooks/
│   └── hooks.json               # Auto-trigger configuration
├── tests/                       # Automated test suite
├── .github/workflows/           # CI/CD pipeline
├── install.sh / uninstall.sh    # Setup scripts
├── CONTRIBUTING.md              # How to contribute
├── CHANGELOG.md                 # Version history
└── docs/
    ├── setup.md                 # Detailed setup guide
    └── ARCHITECTURE.md          # System design & data flow
```

---

## Contributing

Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

Quick ways to contribute:
1. **Add language patterns** to `reference/language-patterns.md`
2. **Add learning resources** to `reference/resources.json`
3. **Add language support** in `scripts/analyze-code.sh`
4. **Report issues** or suggest features

---

## Documentation

- [Setup Guide](docs/setup.md) - Detailed installation and configuration
- [Architecture](docs/ARCHITECTURE.md) - System design and data flow
- [Contributing](CONTRIBUTING.md) - How to contribute
- [Changelog](CHANGELOG.md) - Version history

---

## License

MIT License - Use it, learn from it, share it.

---

<p align="center">
  <sub>Built for developers who actually want to understand code.</sub>
</p>
