---
name: antivibe
description: Code learning and audit framework. Analyze any codebase — new, legacy, or AI-generated — and produce educational explanations or architectural audits. Use when the user wants to understand WHAT and WHY behind any code, not just accept it.
triggers:
  - phrase: "/antivibe"
  - phrase: "deep dive"
  - phrase: "anti-vibecode"
  - phrase: "why did AI write"
  - phrase: "learn from this code"
  - phrase: "understand what AI wrote"
  - phrase: "explain what AI wrote"
  - phrase: "walk me through"
  - phrase: "explain this file"
  - phrase: "explain this codebase"
  - phrase: "analyze this module"
  - phrase: "audit this"
  - phrase: "just the trade-offs"
  - phrase: "what should I worry about"
  - phrase: "code review"
---

# AntiVibe - Code Learning & Audit Framework

## Purpose

AntiVibe generates **learning-focused explanations or architectural audits** of any code — AI-generated, legacy, or otherwise. It helps developers understand:
- **What** the code does (functionality)
- **Why** it was written this way (design decisions)
- **When** to use these patterns (context)
- **What alternatives** exist (broader knowledge)

Works on any codebase — you don't need recent git history or AI-authored files.

## When to Use

Use AntiVibe when:
1. **Manual invocation**: User types `/antivibe` or "deep dive"
2. **Post-task learning**: After a feature/phase completes, user wants to learn from it
3. **Legacy codebases**: User wants to understand existing code they didn't write
4. **Proactive**: User says "explain what AI wrote", "walk me through", "audit this", or points at a file/directory

## What AntiVibe Produces

Output saved to `deep-dive/` folder as markdown:

```
deep-dive/
├── auth-system-2026-01-15.md
├── api-layer-2026-01-15.md
└── database-models-2026-01-15.md
```

The exact sections depend on the output mode (see [Output Mode](#output-mode)):

| Section | `compact` (default) | `full` |
|---------|:---:|:---:|
| **Overview** — what the code does and why it exists | ✅ | ✅ |
| **Key Components / Concepts** — design patterns, algorithms, CS concepts used | ✅ | ✅ |
| **Code Walkthrough** — file-by-file, line-by-line notes | — | ✅ |
| **Learning Resources** — curated docs, tutorials, videos | — | ✅ |
| **Related Code** — links to other files in the codebase | — | ✅ |

## Configuration

### Known Concepts (Skip List)

Concepts listed here will not be explained in full — the explainer will only note that they were used and in what context. Edit this list to match your current knowledge.

```yaml
known_concepts:
  - async/await
  - React hooks
  - REST APIs
```

### Output Mode

Controls how much detail is generated per run. Default is `compact` to keep token costs low.

```yaml
output_mode: compact
```

| Mode | What's included |
|------|----------------|
| `compact` (default) | Overview, key components (function-level, one line each), concepts (what + why only). No resources. No line-by-line. Max 5 files. |
| `full` | Everything in compact, plus: line-by-line walkthrough, prerequisites, curated resources, Next Steps. |

Override inline in your request:
- `"/antivibe full"`, `"full deep dive"`, `"include resources"` → `full` mode
- Default: `compact`

### Default Skill Level

Sets the explanation depth when no level is specified in the request. Options: `junior`, `mid`, `senior`. Default: `mid`.

```yaml
default_level: mid
```

| Level | Behavior |
|-------|----------|
| `junior` | Define all terms. Use analogies. Explain language features. Show full code snippets with inline comments. |
| `mid` | Skip basics. Focus on design decisions and trade-offs. Brief code references only. |
| `senior` | Skip obvious patterns. Focus only on non-obvious choices, edge cases, and architectural trade-offs. |

Level can also be specified inline in the request:
- `"explain for a junior"`, `"I'm new to this"` → `junior`
- `"I know the basics"`, `"mid level"` → `mid`
- `"senior mode"`, `"skip the basics"`, `"just the trade-offs"` → `senior`

---

## Workflow

### Step 0: Apply User Configuration
Before analyzing, read the configuration above:
- Load the `known_concepts` skip list. Any concept in this list will be acknowledged in one sentence instead of fully explained.
- Detect the skill level: check the user's request first (inline phrases take priority), then fall back to `default_level`. Apply this level consistently throughout the entire output.
- If level = `senior`, route to `agents/auditor.md` instead of continuing this workflow.

### Step 1: Identify Code to Analyze

Use the first applicable mode:

1. **Explicit** — User named specific files, a directory, or a module in their request → use those directly. No git needed. Example: "explain `src/auth/`" or "walk me through `api/routes.py`".

2. **Recent** — No explicit target given, project is a git repo, and `git diff HEAD` has output → use those changed files (current behavior for post-AI-task learning).

3. **Scan** — No explicit target, no usable git diff (legacy project, no recent changes, or not a git repo) → ask the user: "Which file, directory, or module would you like to analyze?" Do not attempt to guess.

> The code does not need to be AI-generated. AntiVibe analyzes any code.

### Step 2: Analyze Code Structure
For each file:
- Identify main purpose and responsibilities
- Note key functions, classes, modules
- Identify design patterns used (factory, singleton, observer, etc.)
- Find any complex logic or algorithms

### Step 3: Explain Concepts
For each concept/pattern found:
- **What**: Plain-language explanation
- **Why**: Why this approach was chosen over alternatives
- **When**: When to use this pattern (with context)
- **Alternatives**: Other approaches and trade-offs
- **Prerequisites**: 2–4 foundational concepts the developer must understand first (e.g., "To understand JWT, you need: HTTP request/response, Base64 encoding, cryptographic signing")

### Step 4: Find External Resources
**Only run this step in `full` mode.** Skip entirely in `compact` mode.

Search for and include:
- Official documentation for libraries/frameworks used
- Quality tutorials or blog posts
- Video resources (if available)
- Related concepts for further learning

### Step 5: Generate Output
Create markdown file in `deep-dive/` folder:
- Name format: `[component]-[timestamp].md`
- Detect output mode from the request or `output_mode` config (default: `compact`)
- **Compact mode**: Use the compact template. No line-by-line, no resources, no Next Steps. Max 5 files — if more are in scope, summarize extras in one line each and offer to go deeper.
- **Full mode**: Use the full template from `templates/deep-dive.md`. Include all sections. No 5-file limit — analyze every file in scope; for very large inputs, split the output across multiple deep-dive files rather than truncating.
- Make it educational, not just descriptive

## Auto-Trigger Configuration

AntiVibe can be configured to auto-trigger via hooks:

- **SubagentStop**: After a Task completes a feature
- **Stop**: At session end

To enable auto-trigger, configure hooks in your project (see `hooks/hooks.json`).

## Principles

1. **Why over what** - Always explain design decisions
2. **Context matters** - Explain when/why to use patterns
3. **Curated resources** - Quality links, not random Google results
4. **Phase-aware** - Group by implementation phase
5. **Learning path** - Suggest next steps for deeper study
6. **Concept mapping** - Connect code to underlying CS concepts

## Dependencies

Optional scripts in `scripts/` folder:
- `capture-phase.sh` - Detect implementation phase boundaries
- `analyze-code.sh` - Parse code structure
- `find-resources.sh` - Search for external resources
- `generate-deep-dive.sh` - Create markdown output

These are helpers - you can also do everything via direct code analysis.

## Examples

**Input**: "Explain the auth system Claude wrote" *(recent AI code)*
→ Mode: Recent (git diff). Output: `deep-dive/auth-system-2026-01-15.md`

**Input**: "Walk me through `src/payments/`" *(explicit target — legacy codebase)*
→ Mode: Explicit. Analyzes files in that directory directly, no git needed.

**Input**: "Deep dive" *(no target, legacy project with no recent changes)*
→ Mode: Scan. Asks: "Which file or module would you like to analyze?"

**Input**: "Audit this, just the trade-offs" *(senior mode)*
→ Routes to `agents/auditor.md`. Produces architectural audit, not an explanation.