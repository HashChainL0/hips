#!/usr/bin/env bash
# Checks that every hips/*.md has the required sections, in order:
# Abstract, Motivation, Specification, Rationale, Security considerations,
# Open questions. A Copyright section may follow. Headings outside code
# fences are compared at level two only.
set -u

cd "$(dirname "$0")/.."

expected="Abstract|Motivation|Specification|Rationale|Security considerations|Open questions"
fail=0
count=0

for f in hips/*.md; do
  [ -e "$f" ] || { echo "no HIP files found"; exit 1; }
  count=$((count + 1))

  actual=$(awk '
    /^```/ { fence = !fence; next }
    fence { next }
    /^## / { sub(/^## /, ""); printf "%s%s", sep, $0; sep = "|" }
  ' "$f")

  # Allow an optional trailing Copyright section.
  trimmed=${actual%|Copyright}

  if [ "$trimmed" != "$expected" ]; then
    echo "$f: sections do not match the required list and order"
    echo "  required: $expected"
    echo "  found:    $actual"
    fail=1
  fi
done

if [ "$fail" -ne 0 ]; then
  echo "section check failed"
  exit 1
fi
echo "section check passed ($count files)"
