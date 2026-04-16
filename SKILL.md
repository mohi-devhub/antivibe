---
name: antivibe
description: Anti-vibecoding learning framework. Generate detailed, educational explanations of AI-written code with curated resources. Helps developers understand WHAT, WHY, and WHEN behind code patterns — not just accept them.
triggers:
  - phrase: "/antivibe"
  - phrase: "antivibe deep dive"
  - phrase: "explain what AI wrote"
  - phrase: "learn from this code"
  - phrase: "understand what AI wrote"
  - phrase: "why did AI write it this way"
---

# AntiVibe - AI Code Learning Framework

## Purpose

AntiVibe generates **learning-focused explanations** of AI-written code. Not generic summaries — actual educational content that helps developers understand:
- **What** the code does (functionality)
- **Why** it was written this way (design decisions)
- **When** to use these patterns (context)
- **What alternatives** exist (broader knowledge)

## When to Use

Use AntiVibe when:
1. **Manual invocation**: User types `/antivibe` or "antivibe deep dive"
2. **Post-task learning**: After a feature/phase completes, user wants to learn from it
3. **Proactive**: User says "explain what AI wrote", "learn from this code", or "understand what AI wrote"

## What AntiVibe Produces

Output saved to `deep-dive/` folder as markdown:

```
deep-dive/
├── auth-system-2026-04-16.md
├── api-layer-2026-04-16.md
└── database-models-2026-04-16.md
```

Each file contains:
- **Overview**: What this code does and why it exists
- **Code Walkthrough**: File-by-file explanation with educational commentary
- **Concepts Explained**: Design patterns, algorithms, CS concepts (What/Why/When/Alternatives)
- **Learning Resources**: Curated docs, tutorials, videos from `reference/resources.json`
- **Related Code**: Links to other files in the codebase
- **Next Steps**: Concrete learning path suggestions

## Workflow

### Step 1: Identify Code to Analyze
- Check for explicit file list in user request
- Or use `git diff --name-only` to find recently modified/created files
- Or ask user which files/components they want to understand
- The orchestrator script `scripts/antivibe.sh full` automates this

### Step 2: Analyze Code Structure
For each file:
- Identify main purpose and responsibilities
- Note key functions, classes, modules
- Identify design patterns used (factory, singleton, observer, etc.)
- Find any complex logic or algorithms
- Use `scripts/analyze-code.sh` for automated structural analysis

### Step 3: Explain Concepts
For each concept/pattern found:
- **What**: Plain-language explanation
- **Why**: Why this approach was chosen over alternatives
- **When**: When to use this pattern (with context)
- **Alternatives**: Other approaches and their trade-offs
- Refer to `agents/explainer.md` for detailed explanation guidelines

### Step 4: Find External Resources
Search for and include from `reference/resources.json`:
- Official documentation for libraries/frameworks used
- Quality tutorials or blog posts
- Video resources (if available)
- Related concepts for further learning
- Use `scripts/find-resources.sh` for automated lookup

### Step 5: Generate Output
Create markdown file in `deep-dive/` folder:
- Name format: `[component]-[timestamp].md`
- Follow the template in `templates/deep-dive.md`
- Include focused code snippets (5-15 lines, not entire files)
- Make it educational, not just descriptive
- Use `scripts/generate-deep-dive.sh` for scaffolding

## Configuration

### Environment Variables
All scripts support configuration via environment variables:
- `ANTIVIBE_OUTPUT_DIR` — Output directory (default: `deep-dive`)
- `ANTIVIBE_TIME_WINDOW` — Minutes to look back for changes (default: `60`)
- `ANTIVIBE_MAX_FILES` — Max files to capture per phase (default: `50`)

### Auto-Trigger Hooks
AntiVibe can auto-trigger via hooks after task completion:
- **SubagentStop**: After a task completes a feature — suggests `/antivibe`
- **Stop**: At session end — suggests learning from code written in session

To enable, configure hooks in your project (see `hooks/hooks.json`).

### CLI Orchestrator
The `scripts/antivibe.sh` script provides a unified CLI:
```bash
antivibe.sh analyze <file>          # Analyze a single file
antivibe.sh capture [phase-name]    # Capture changed files
antivibe.sh resources <concept>     # Find learning resources
antivibe.sh generate <name> [files] # Generate deep-dive markdown
antivibe.sh full [phase-name]       # Run complete pipeline
```

## Principles

1. **Why over what** — Always explain design decisions, not just describe code
2. **Context matters** — Explain when/why to use patterns, and when NOT to
3. **Curated resources** — Quality links, not random search results
4. **Phase-aware** — Group by implementation phase for structured learning
5. **Learning path** — Suggest concrete next steps for deeper study
6. **Concept mapping** — Connect code to underlying CS concepts
7. **Show alternatives** — Present trade-offs, not just "the one right way"

## Dependencies

### Scripts (in `scripts/` folder)
- `config.sh` — Central configuration, sourced by all scripts
- `antivibe.sh` — Main orchestrator with subcommands
- `capture-phase.sh` — Detect implementation phase boundaries
- `analyze-code.sh` — Parse code structure (supports 14+ languages)
- `find-resources.sh` — Search for external resources using `resources.json`
- `generate-deep-dive.sh` — Create markdown output from template

### Reference Data (in `reference/` folder)
- `resources.json` — Structured learning resource database (29 categories)
- `language-patterns.md` — Framework-specific patterns reference
- `resource-curation.md` — Curated links organized by topic

These are helpers — the explainer agent can also do everything via direct code analysis without scripts.

## Supported Languages

JavaScript/TypeScript, Python, Go, Rust, Java, Kotlin, Swift, C#, Ruby, PHP, C/C++, Vue, Svelte — and extensible for more.

## Examples

**Input**: "Explain the auth system Claude wrote"
**Output**: `deep-dive/auth-system-2026-04-16.md` containing:
- JWT structure explanation with stateless vs session-based comparison
- Password hashing rationale (bcrypt vs argon2 trade-offs)
- Session management concepts with security considerations
- Learning resources for auth patterns

**Input**: "I want to understand this API layer"
**Output**: `deep-dive/api-layer-2026-04-16.md` containing:
- REST design decisions with alternatives (GraphQL, gRPC)
- Middleware explanation and composition patterns
- Error handling patterns with status code conventions
- Further reading on API design best practices
