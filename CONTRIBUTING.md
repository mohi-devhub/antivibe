# Contributing to AntiVibe

Thanks for your interest in improving AntiVibe! This guide covers everything you need to contribute effectively.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/antivibe.git
   cd antivibe
   ```
3. **Create a branch** for your work:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## What You Can Contribute

### Add Language Patterns
Edit `reference/language-patterns.md` to add patterns for new languages or frameworks. Follow the existing table format:

```markdown
| Pattern | Explanation | When to Use |
|---------|-------------|-------------|
| Pattern name | What it does | When to apply it |
```

### Add Learning Resources
Edit `reference/resource-curation.md` to add quality learning links. Priority order:
1. Official documentation
2. Well-maintained tutorials
3. Quality video content

Also add structured entries to `reference/resources.json` for script consumption.

### Improve Scripts
All scripts are in `scripts/`. When modifying:
- Source `config.sh` at the top of every script
- Use `set -euo pipefail` for safety
- Add proper error handling with `log_error`
- Test with `bash tests/run-tests.sh`

### Expand Language Support in analyze-code.sh
Add a new case block following the existing pattern:
```bash
ext)
    echo "--- Language Structure ---"
    echo "Functions:"
    extract_matches "pattern" "$FILE_PATH"
    echo "--- Metrics ---"
    echo "function_count=$(count_matches 'pattern' "$FILE_PATH")"
    ;;
```

## Code Style

- **Shell scripts**: Use `bash`, not `sh`. Always include `set -euo pipefail`.
- **Variable names**: UPPER_SNAKE_CASE for config, lower_snake for locals.
- **Functions**: Use `log_info`, `log_error`, `log_warn`, `log_success` from config.sh.
- **Documentation**: Markdown, no trailing whitespace, single blank line between sections.

## Testing

Run the test suite before submitting:

```bash
chmod +x scripts/*.sh tests/*.sh
bash tests/run-tests.sh
```

Add tests for new features in `tests/`. Follow the naming convention `test-<feature>.sh`.

## Pull Request Process

1. Ensure all tests pass
2. Update relevant documentation
3. Write a clear PR description explaining **what** and **why**
4. Keep PRs focused — one feature or fix per PR

## Commit Messages

Use conventional format:
```
feat: add Kotlin language support to analyze-code.sh
fix: handle files without extension in analyze-code.sh
docs: add troubleshooting section to setup guide
test: add Ruby fixture and analysis tests
```

## Questions?

Open an issue if you're unsure about something. We're happy to help!
