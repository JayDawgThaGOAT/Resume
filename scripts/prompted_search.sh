#!/usr/bin/env bash
# Prompted wrapper around scripts/search_jobs.py.
# Asks for a search term, then runs the search with all other flags at defaults.
# Empty input cancels silently (exit 0, no search run).
#
# Invoked by the Zed task "JobSpy: Prompted search". Kept as a separate script
# so the task command stays simple and avoid nested shell quoting in tasks.json.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SEARCH_SCRIPT="$SCRIPT_DIR/search_jobs.py"

read -rp "Search term (Enter to cancel): " q

if [ -z "$q" ]; then
  echo "Cancelled."
  exit 0
fi

exec python3 "$SEARCH_SCRIPT" --search-term "$q"
