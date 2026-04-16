# Changelog

All notable changes to AntiVibe are documented here.

## [1.0.0] - 2026-04-16

### Added
- **Central configuration system** (`scripts/config.sh`) — all settings in one place, environment variable overrides supported
- **Orchestration script** (`scripts/antivibe.sh`) — unified CLI with subcommands: `analyze`, `capture`, `resources`, `generate`, `full`
- **Data-driven resource lookup** (`reference/resources.json`) — 29 concept categories with structured JSON, replaces hardcoded case statements
- **Comprehensive test suite** — 7 automated tests covering all scripts, fixtures for 6 languages
- **CI/CD pipeline** (`.github/workflows/test.yml`) — ShellCheck linting + test runner on push/PR
- **Install/uninstall scripts** — automated setup and clean removal
- **Language support**: C#, Kotlin, Swift, Ruby, PHP, C/C++, Vue, Svelte (in addition to existing JS/TS, Python, Go, Rust, Java)
- **Resource categories**: state management, GraphQL, WebSockets, caching, CI/CD, Kubernetes, serverless, message queues, ORMs, Vue, Angular, Svelte, security
- **Language patterns**: Next.js, NestJS, Vue.js, Angular, Svelte, Ruby/Rails, PHP/Laravel, C#/.NET, Kotlin, Swift, plus anti-patterns section
- `CONTRIBUTING.md` — guidelines for contributors
- `docs/ARCHITECTURE.md` — data flow diagram and component documentation

### Changed
- **analyze-code.sh** — rewritten with `set -euo pipefail`, file readability checks, improved regex patterns (async functions, arrow functions, decorators, methods), complexity metrics output
- **capture-phase.sh** — now uses `git diff` when in a git repo (falls back to `find`), configurable time window, structured output with stats
- **find-resources.sh** — reads from `resources.json` instead of hardcoded case statements, supports jq and grep fallback
- **generate-deep-dive.sh** — auto-populates template sections from `analyze-code.sh` output, file overwrite detection, configurable output directory
- **agents/explainer.md** — added concrete good/bad examples, token budgeting, large file guidance, code snippet selection criteria
- **templates/deep-dive.md** — added completed example, content length guidelines, section checklist
- **SKILL.md** — more specific trigger phrases, documented orchestrator integration
- **hooks/hooks.json** — refined prompts, better guidance text
- **README.md** — added table of contents, prerequisites, build status badge, architecture overview
- **docs/setup.md** — added verification step, more troubleshooting, uninstall instructions

### Fixed
- Shell scripts now handle files with spaces in paths
- `analyze-code.sh` no longer crashes on unreadable files
- `capture-phase.sh` excludes `node_modules` and `.git` directories
- LICENSE copyright year corrected

## [0.1.0] - 2026-04-10

### Added
- Initial release by [@mohi-devhub](https://github.com/mohi-devhub)
- SKILL.md definition with trigger phrases
- Basic shell scripts for code analysis
- Explainer agent and deep-dive template
- Language patterns and resource curation references
