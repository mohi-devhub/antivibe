#!/bin/bash
# find-resources.sh - Search for external learning resources
# Usage: ./find-resources.sh [concept] [language/framework]

CONCEPT="$1"
LANG="$2"

if [ -z "$CONCEPT" ]; then
    echo "Usage: ./find-resources.sh <concept> [language]"
    echo "Example: ./find-resources.sh 'react hooks' react"
    exit 1
fi

echo "=== Finding resources for: $CONCEPT ==="
echo ""

# Map concepts to curated resource URLs
# In production, this could use web search or a local database

case "$CONCEPT" in
    *"react"*|"hooks"|"useState"|"useEffect")
        echo "--- React Resources ---"
        echo "Official Docs:"
        echo "- https://react.dev/reference/react - React API reference"
        echo "- https://react.dev/learn - React learning guide"
        echo "- https://react.dev/reference - Hooks API"
        ;;
    *"typescript"*|"types"|"generics")
        echo "--- TypeScript Resources ---"
        echo "Official Docs:"
        echo "- https://www.typescriptlang.org/docs/ - TypeScript docs"
        echo "- https://www.typescriptlang.org/play - Interactive playground"
        ;;
    *"express"*|"api"|"rest")
        echo "--- API/Express Resources ---"
        echo "Official Docs:"
        echo "- https://expressjs.com/en/guide/ - Express guide"
        echo "- https://expressjs.com/en/api/ - Express API reference"
        echo "Best Practices:"
        echo "- https://restfulapi.net/ - REST API design"
        ;;
    *"database"*|"sql"|*"postgres"|*"mysql")
        echo "--- Database Resources ---"
        echo "Official Docs:"
        echo "- https://www.postgresql.org/docs/ - PostgreSQL docs"
        echo "- https://dev.mysql.com/doc/refman/ - MySQL docs"
        echo "Learning:"
        echo "- https://sqlbolt.com/ - SQL interactive lessons"
        ;;
    *"auth"*|"jwt"|*"oauth"*|"password")
        echo "--- Authentication Resources ---"
        echo "Security Best Practices:"
        echo "- https://owasp.org/www-project-web-security-testing-guide/ - OWASP"
        echo "- https://jwt.io/ - JWT explained"
        echo "- https://auth0.com/docs - Auth0 docs"
        ;;
    *"docker"*|"container")
        echo "--- Docker Resources ---"
        echo "Official Docs:"
        echo "- https://docs.docker.com/get-started/ - Docker getting started"
        echo "- https://docs.docker.com/compose/ - Docker Compose"
        ;;
    *"test"*|"jest"|*"pytest"|*"unittest")
        echo "--- Testing Resources ---"
        echo "- https://jestjs.io/docs/getting-started - Jest docs"
        echo "- https://docs.pytest.org/ - Pytest docs"
        echo "- https://testing-library.com/ - Testing Library"
        ;;
    *"async"*|"await"|*"promise"|*"callback")
        echo "--- Async Programming Resources ---"
        echo "- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Async_operations"
        echo "- https://docs.python.org/3/library/asyncio.html - Python async"
        ;;
    *"git"*|"version control")
        echo "--- Git Resources ---"
        echo "- https://git-scm.com/doc - Pro Git book"
        echo "- https://learngitbranching.js.org/ - Interactive learning"
        ;;
    *"design pattern"*|"factory"|*"singleton"|*"observer")
        echo "--- Design Patterns Resources ---"
        echo "- https://refactoring.guru/design-patterns - Refactoring Guru"
        echo "- https://patterns.dev/ - Web patterns"
        ;;
    *)
        echo "--- General Resources ---"
        echo "Search suggestions:"
        echo "- Official documentation for $LANG"
        echo "- MDN Web Docs (for web technologies)"
        echo "- Stack Overflow (for specific problems)"
        echo "- YouTube tutorials by trusted creators"
        ;;
esac

echo ""
echo "=== Resource Search Complete ==="
echo "Note: These are starting points. Validate links before including in output."