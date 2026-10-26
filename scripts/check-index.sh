#!/usr/bin/env bash
# Checks that the index table in README.md lists every HIP in hips/ once,
# with the same title, category and status as the HIP's front matter,
# and that it lists no HIP that does not exist.
set -u

cd "$(dirname "$0")/.."

fail=0
listed=0

field() {
  awk 'NR==1{next} /^---$/{exit} {print}' "$1" | sed -n "s/^$2:[[:space:]]*//p" | head -n1
}

for f in hips/*.md; do
  [ -e "$f" ] || { echo "no HIP files found"; exit 1; }
  num=$(field "$f" hip)
  title=$(field "$f" title)
  category=$(field "$f" category)
  status=$(field "$f" status)
  expected="| [${num}](${f}) | ${title} | ${category} | ${status} |"

  rows=$(grep -cF -- "](${f}) |" README.md)
  if [ "$rows" -eq 0 ]; then
    echo "$f: not listed in the README index"
    fail=1
  elif [ "$rows" -gt 1 ]; then
    echo "$f: listed more than once in the README index"
    fail=1
  elif ! grep -qxF -- "$expected" README.md; then
    echo "$f: README index row does not match the front matter, expected:"
    echo "  $expected"
    fail=1
  fi
done

for path in $(grep -oE '\]\(hips/hip-[0-9]+\.md\) \|' README.md | sed -E 's/^\]\((.*)\) \|$/\1/'); do
  listed=$((listed + 1))
  if [ ! -e "$path" ]; then
    echo "README index lists $path, which does not exist"
    fail=1
  fi
done

if [ "$fail" -ne 0 ]; then
  echo "index check failed"
  exit 1
fi
echo "index check passed ($listed entries)"
