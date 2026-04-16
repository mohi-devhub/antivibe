#!/bin/bash
set -euo pipefail

# Test: All shell scripts have proper shebang lines

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

FAILED=0

for script in "$PROJECT_ROOT"/scripts/*.sh; do
    FIRST_LINE=$(head -1 "$script")
    if [[ "$FIRST_LINE" != "#!/bin/bash" ]]; then
        echo "Missing shebang: $script"
        ((FAILED++)) || true
    fi
done

[ "$FAILED" -eq 0 ] || exit 1

exit 0
