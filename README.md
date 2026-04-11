# AntiVibe

<p align="center">
  <img src="https://img.shields.io/badge/Anti--Vibecoding-Learning-orange?style=for-the-badge" alt="Anti-Vibecoding">
  <img src="https://img.shields.io/badge/Claude_Code-Skill-blue?style=for-the-badge" alt="Claude Code">
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License">
</p>

<p align="center">
  <strong>Learn what AI writes, not just accept it.</strong><br>
  An anti-vibecoding learning framework for Claude Code that generates detailed, educational explanations of AI-generated code.
</p>

---

## ✨ What is AntiVibe?

AntiVibe is a **learning-focused code explanation framework** that transforms AI-generated code into educational content. Unlike generic code summaries, AntiVibe helps you understand:

- **What** the code does (functionality)
- **Why** it was written this way (design decisions)
- **When** to use these patterns (context)
- **What alternatives** exist (broader knowledge)

> ⚡ **The Problem**: AI writes code, developers copy-paste it, nobody learns anything.
> 
> 🛡️ **The Solution**: AntiVibe explains the reasoning so you actually understand.

---

## 🎯 Features

| Feature | Description |
|---------|-------------|
| **Deep Dives** | Generate comprehensive learning guides from AI code |
| **Concept Mapping** | Connect code to underlying CS principles |
| **Curated Resources** | Quality links to docs, tutorials, videos |
| **Phase-Aware** | Group explanations by implementation phase |
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
/antivibe                        # Start a deep dive
"deep dive"                      # Analyze recently written code
"learn from this code"           # Generate learning guide
"explain what AI wrote"          # Explain specific files
"understand what AI wrote"       # Understand design decisions
```

---

## 📁 Output Example

Generate a deep dive and get a file like:

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

### Auto-Trigger Hooks

Enable automatic deep-dive generation after task completion:

```bash
# Copy hooks to your project
cp framework/hooks/hooks.json your-project/.claude/hooks.json
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
│   └── explainer.md            # Subagent for detailed analysis
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