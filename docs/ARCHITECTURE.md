# AntiVibe Architecture

## Overview

AntiVibe is a Claude Code skill that transforms AI-generated code into educational learning materials. It operates as a pipeline with four stages.

## Data Flow

```
User triggers /antivibe
        |
        v
+-------------------+
| 1. CAPTURE        |  capture-phase.sh
| Identify files    |  Uses git diff or find
| that changed      |  Outputs: file list + stats
+-------------------+
        |
        v
+-------------------+
| 2. ANALYZE        |  analyze-code.sh
| Parse structure   |  Language-specific regex
| Extract metrics   |  Outputs: functions, classes, imports, metrics
+-------------------+
        |
        v
+-------------------+
| 3. RESEARCH       |  find-resources.sh + resources.json
| Match concepts    |  Keyword matching on JSON data
| to resources      |  Outputs: curated links by category
+-------------------+
        |
        v
+-------------------+
| 4. GENERATE       |  generate-deep-dive.sh
| Create markdown   |  Uses template + analysis data
| deep-dive file    |  Outputs: deep-dive/[name]-[timestamp].md
+-------------------+
```

## Component Map

```
antivibe/
├── SKILL.md                    # Skill definition (triggers, workflow, config)
│
├── scripts/
│   ├── config.sh               # Central config (env vars, colors, paths)
│   ├── antivibe.sh             # Orchestrator (subcommands: analyze, capture, resources, generate, full)
│   ├── analyze-code.sh         # Code parser (14+ languages, regex extraction, metrics)
│   ├── capture-phase.sh        # Phase detector (git diff / find, structured output)
│   ├── find-resources.sh       # Resource lookup (reads resources.json, jq or grep)
│   └── generate-deep-dive.sh   # Output generator (template population, auto-analysis)
│
├── agents/
│   └── explainer.md            # Subagent instructions (analysis framework, good/bad examples)
│
├── templates/
│   └── deep-dive.md            # Output template (sections, checklist)
│
├── reference/
│   ├── resources.json          # Structured resource database (29 categories, URLs, difficulty)
│   ├── language-patterns.md    # Pattern reference (14+ languages, anti-patterns, design patterns)
│   └── resource-curation.md    # Curated links (organized by topic, difficulty tagged)
│
├── hooks/
│   └── hooks.json              # Auto-trigger config (SubagentStop, Stop events)
│
├── tests/
│   ├── run-tests.sh            # Test runner (7 test suites, pass/fail reporting)
│   ├── test-analyze.sh         # Analysis tests (multi-language, error handling)
│   ├── test-capture.sh         # Capture tests (phase data, output format)
│   ├── test-resources.sh       # Resource tests (concept lookup)
│   ├── test-generate.sh        # Generation tests (file creation, template)
│   ├── test-orchestrator.sh    # Integration tests (CLI subcommands)
│   ├── test-json-valid.sh      # Validation (JSON structure)
│   ├── test-shebangs.sh        # Validation (script format)
│   └── fixtures/               # Sample code files for testing
│
├── .github/workflows/
│   └── test.yml                # CI pipeline (ShellCheck + tests)
│
├── install.sh                  # Automated installation
├── uninstall.sh                # Clean removal
├── CONTRIBUTING.md             # Contributor guidelines
├── CHANGELOG.md                # Version history
└── docs/
    ├── setup.md                # Setup guide
    └── ARCHITECTURE.md         # This file
```

## Design Decisions

### Why Shell Scripts?
Claude Code skills run in the user's terminal. Shell scripts are universally available, require no dependencies, and integrate naturally with git and the filesystem. No build step needed.

### Why a JSON Resource Database?
The original hardcoded case statements couldn't scale. A JSON file is:
- Easy to edit (add resources without touching code)
- Machine-parseable (scripts read it directly)
- Contributor-friendly (lower barrier to add resources)

### Why an Orchestrator?
Individual scripts are useful but disconnected. The orchestrator (`antivibe.sh`) provides:
- A single entry point with subcommands
- The `full` pipeline that chains all stages
- Consistent error handling and logging
- Help text and discoverability

### Why Structured Output from Scripts?
Scripts output `key=value` pairs alongside human-readable text. This allows:
- Other scripts to parse and use the data
- The generate step to auto-populate templates
- Future integration with other tools

## Configuration

All configuration flows through `scripts/config.sh`:
- Environment variables override defaults
- Scripts source config.sh at startup
- No config files to maintain separately
- Sensible defaults that work out of the box
