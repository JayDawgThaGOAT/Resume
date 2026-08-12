#!/usr/bin/env bash
# Prompted wrapper around scripts/search_jobs.py.
# Asks for a search term, then runs the search with all other flags at defaults.
# Empty input cancels silently (exit 0, no search run).
#
# Prefer the Cursor/VS Code task "JobSpy: Custom search" (promptString inputs)
# when working in the IDE. This script remains for plain-terminal use.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SEARCH_SCRIPT="$SCRIPT_DIR/search_jobs.py"
PYTHON="$REPO_ROOT/.venv/bin/python"

if [ ! -x "$PYTHON" ]; then
  echo "Missing $PYTHON — run: python3 -m venv .venv && .venv/bin/pip install -r requirements.txt" >&2
  exit 1
fi

read -rp "Search term (Enter to cancel): " q

if [ -z "$q" ]; then
  echo "Cancelled."
  exit 0
fi

exec "$PYTHON" "$SEARCH_SCRIPT" --search-term "$q"
