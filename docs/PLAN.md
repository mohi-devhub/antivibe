# AntiVibe - AI Code Learning Framework

## Overview

**Purpose**: Anti-vibecoding framework that helps developers/students understand what AI writes, not just accept it. Learning-focused explanations with curated external resources.

## Architecture

```
antivibe/
├── SKILL.md                         # Main skill
├── hooks/
│   └── hooks.json                   # Auto-trigger config
├── scripts/
│   ├── capture-phase.sh             # Detect phase completion
│   ├── analyze-code.sh             # Parse code structure
│   ├── find-resources.sh            # Find external resources
│   └── generate-deep-dive.sh        # Generate markdown output
├── agents/
│   └── explainer.md                 # Subagent for detailed analysis
├── templates/
│   └── deep-dive.md                 # Output template
├── reference/
│   ├── language-patterns.md         # Framework patterns
│   └── resource-curation.md        # Curated learning links
└── docs/
    └── setup.md                     # Installation guide
```

## Trigger Mechanisms

| Trigger | When | Use case |
|---------|------|----------|
| `/antivibe` | Manual | Immediate explanation |
| `SubagentStop` | Task completes | Phase-based learning |
| `Stop` | Session ends | End-of-session summary |

## Output Format

**Location**: `deep-dive/[phase-name]-[timestamp].md`

```markdown
# Deep Dive: [Feature Name]

## 🎯 What This Code Does
[Overview - not just what, but WHY it exists]

## 🔍 Code Walkthrough
### [File 1]
- **Purpose**: [What this file handles]
- **Key patterns**: [Design patterns used]
- **Line-by-line**: [Educational breakdown]

## 🧠 Concepts Explained
### [Concept Name]
> When to use: [Context]
> Why this approach: [Design reasoning]
> Alternatives: [What else exists]

## 📚 Learn More
### Official Docs
- [Link]: [What you'll learn]

### Tutorials & Articles
- [Link]: [Why helpful]

### Videos
- [Link]: [What it covers]

## 🔗 Related Code
- [File]: [How it connects]
```

## Key Differentiators

1. **"Why" over "what"** - Focus on design decisions
2. **Curated resources** - Quality learning links, not random Google results
3. **Phase-aware** - Groups by implementation phase
4. **Learning paths** - Suggests next steps
5. **Concept mapping** - Links to underlying CS concepts

## Distribution

- **Primary**: Skill-based (`npx skills add antivibe`)
- **Plugin**: For marketplace (`/plugin marketplace add`)