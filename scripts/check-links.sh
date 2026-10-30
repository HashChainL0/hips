#!/usr/bin/env bash
# Checks that relative links in Markdown files point at files that exist.
# External links (http, https, mailto) and in-page anchors are skipped.
# Links inside code fences are ignored.
set -u

cd "$(dirname "$0")/.."

fail=0
count=0

while IFS= read -r f; do
  dir=$(dirname "$f")
  targets=$(awk '/^```/ { fence = !fence; next } !fence { print }' "$f" \
    | grep -oE '\]\([^)[:space:]]+\)' \
    | sed -E 's/^\]\((.*)\)$/\1/' || true)
  for target in $targets; do
    case "$target" in
      http://*|https://*|mailto:*|\#*) continue ;;
    esac
    path=${target%%#*}
    [ -n "$path" ] || continue
    count=$((count + 1))
    if [ ! -e "$dir/$path" ]; then
      echo "$f: broken link to $target"
      fail=1
    fi
  done
done < <(find . -name '*.md' -not -path './.git/*' | sort)

if [ "$fail" -ne 0 ]; then
  echo "link check failed"
  exit 1
fi
echo "link check passed ($count relative links)"
