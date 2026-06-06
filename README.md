# AntiVibe

<p align="center">
  <img src="https://img.shields.io/badge/Anti--Vibecoding-Learning-orange?style=for-the-badge" alt="Anti-Vibecoding">
  <img src="https://img.shields.io/badge/Claude_Code-Skill-blue?style=for-the-badge" alt="Claude Code">
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License">
</p>

<p align="center">
  <strong>Understand any code, not just accept it.</strong><br>
  A code learning &amp; audit framework for Claude Code that turns any codebase — new, legacy, or AI-generated — into educational deep dives or senior-level architectural audits.
</p>

---

## ✨ What is AntiVibe?

AntiVibe is a **code learning & audit framework** that transforms any code — AI-generated, legacy, or otherwise — into educational content or architectural audits. You don't need recent git history or AI-authored files; point it at any file, directory, or module. Unlike generic code summaries, AntiVibe helps you understand:

- **What** the code does (functionality)
- **Why** it was written this way (design decisions)
- **When** to use these patterns (context)
- **What alternatives** exist (broader knowledge)

> ⚡ **The Problem**: AI writes code, developers copy-paste it, nobody learns anything.
> 
> 🛡️ **The Solution**: AntiVibe explains the reasoning so you actually understand — and for code you already know, it audits the trade-offs instead.

---

## 🎯 Features

| Feature | Description |
|---------|-------------|
| **Deep Dives** | Generate comprehensive learning guides from any code |
| **Audit Mode** | Senior-level architectural audit — decisions, flags, edge cases, testability |
| **Skill Levels** | Tune depth to `junior`, `mid`, or `senior` |
| **Output Modes** | `compact` (default, low token cost) or `full` (resources + line-by-line) |
| **Known Concepts** | Skip list so familiar concepts get a one-line note, not a full explanation |
| **Prerequisites** | Maps each concept to the foundations you need to understand it first |
| **Legacy-Friendly** | Works on existing codebases — no git history or AI authorship required |
| **Concept Mapping** | Connect code to underlying CS principles |
| **Curated Resources** | Quality links to docs, tutorials, videos |
| **Auto-Trigger** | Optional hooks for automatic generation |
| **Multi-Language** | Works with any language/framework |

---

## 🚀 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/mohi-devhub/antivibe.git

# Install as a global Claude Code skill
cp -r antivibe ~/.claude/skills/antivibe
```

### Usage

```
/antivibe                        # Start a deep dive (compact, mid-level by default)
/antivibe full                   # Full deep dive with resources + line-by-line
"deep dive"                      # Analyze recently written code (git diff)
"walk me through src/auth/"      # Explain an explicit file or directory
"explain this codebase"          # Understand existing / legacy code
"learn from this code"           # Generate learning guide
```

Tune the depth and detail inline:

```
"explain for a junior"           # Define terms, analogies, full snippets
"I know the basics"              # Mid level — focus on design decisions
"audit this, just the trade-offs"  # Senior mode — routes to the auditor agent
```

---

## 📁 Output Example

Run a `full` deep dive (`/antivibe full`) and get a file like the one below. The default `compact` mode produces a shorter version — Overview, Key Components, and Concepts (what + why) — without the walkthrough or resources.

```markdown
# Deep Dive: Authentication System

## Overview
This auth system uses JWT tokens with refresh token rotation...

## Code Walkthrough
### auth/service.ts
- **Purpose**: Token generation and validation
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

Saved to: `deep-dive/auth-system-2026-04-10.md`

---

## 🔧 Configuration

### Behavior (in `SKILL.md`)

Tune how AntiVibe analyzes code by editing the config blocks in `SKILL.md`:

```yaml
output_mode: compact      # compact (default) or full
default_level: mid        # junior, mid, or senior
known_concepts:           # skipped in explanations (one-line note only)
  - async/await
  - React hooks
  - REST APIs
```

| Setting | Options | Effect |
|---------|---------|--------|
| `output_mode` | `compact` / `full` | `compact` keeps token cost low (no resources, no line-by-line); `full` adds curated resources, prerequisites, and a line-by-line walkthrough |
| `default_level` | `junior` / `mid` / `senior` | Sets explanation depth; `senior` routes to the auditor agent for an architectural audit |
| `known_concepts` | list | Concepts you already know — acknowledged in one line instead of fully explained |

All three can also be overridden inline in a request (e.g. `"/antivibe full"`, `"explain for a junior"`, `"just the trade-offs"`).

### Auto-Trigger Hooks

Enable automatic deep-dive generation after task completion:

```bash
# Copy hooks to your project
cp hooks/hooks.json your-project/.claude/hooks.json
```

| Hook | When | Use Case |
|------|------|----------|
| `SubagentStop` | Task completes | Phase-based learning |
| `Stop` | Session ends | End-of-session summary |

### Customize Output Directory

Edit `scripts/generate-deep-dive.sh`:
```bash
OUTPUT_DIR="your-folder"  # Default: "deep-dive"
```

---

## 📂 File Structure

```
antivibe/
├── SKILL.md                     # Main skill definition
├── README.md                    # This file
├── hooks/
│   └── hooks.json              # Auto-trigger configuration
├── scripts/
│   ├── capture-phase.sh        # Detect implementation phases
│   ├── analyze-code.sh         # Parse code structure
│   ├── find-resources.sh       # Find external resources
│   └── generate-deep-dive.sh   # Generate markdown output
├── agents/
│   ├── explainer.md            # Subagent for learning-focused explanations
│   └── auditor.md              # Subagent for senior-level architectural audits
├── templates/
│   └── deep-dive.md            # Output template
├── reference/
│   ├── language-patterns.md    # Framework-specific patterns
│   └── resource-curation.md    # Curated learning resources
└── docs/
    ├── PLAN.md                  # Planning document
    └── setup.md                 # Detailed setup guide
```

---

## 📚 Principles

1. **Why over what** - Always explain design decisions
2. **Context matters** - Explain when/why to use patterns
3. **Curated resources** - Quality links, not random results
4. **Phase-aware** - Group by implementation phase
5. **Learning path** - Suggest next steps for deeper study
6. **Concept mapping** - Connect code to underlying CS concepts

---

## 🛠️ Supported Languages & Frameworks

- **JavaScript/TypeScript**: React, Node.js, Express
- **Python**: Django, FastAPI, Flask
- **Go**: Standard library, Gin, Echo
- **Rust**: Standard library, Actix
- **Java**: Spring Boot
- **And more** - Extensible pattern system

---

## 🤝 Contributing

Contributions welcome! To extend AntiVibe:

1. Add patterns to `reference/language-patterns.md`
2. Add resources to `reference/resource-curation.md`
3. Customize the template in `templates/deep-dive.md`

---

## 📖 Documentation

- [Setup Guide](docs/setup.md) - Detailed installation
- [Skill Format](https://docs.anthropic.com/en/docs/claude-code/skills) - Claude Code skills

---

## ⚠️ License

MIT License - Use it, learn from it, share it.

---

<p align="center">
  <sub>Built with 🔥 for developers who actually want to understand code.</sub>
</p>
