#!/usr/bin/env bash
# Checks that no Markdown, YAML or shell file contains an em dash.
# The style guide in CONTRIBUTING.md asks for commas, colons and periods.
set -u

cd "$(dirname "$0")/.."

if grep -rn $'\xe2\x80\x94' --include='*.md' --include='*.yml' --include='*.sh' . --exclude-dir=.git; then
  echo "em dash check failed"
  exit 1
fi
echo "em dash check passed"
