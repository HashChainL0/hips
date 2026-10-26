#!/usr/bin/env bash
# Checks that every hips/*.md has the required front matter fields
# and that field values are valid.
set -u

cd "$(dirname "$0")/.."

required=(hip title author status category created)
statuses="Idea|Draft|Review|Last Call|Final|Withdrawn|Stagnant"
categories="Core|Networking|Interface|Connection|Meta|Informational"

fail=0
count=0

for f in hips/*.md; do
  [ -e "$f" ] || { echo "no HIP files found"; exit 1; }
  count=$((count + 1))

  if [ "$(sed -n '1p' "$f")" != "---" ]; then
    echo "$f: missing opening front matter delimiter"
    fail=1
    continue
  fi
  fm=$(awk 'NR==1{next} /^---$/{exit} {print}' "$f")
  if ! awk 'NR>1 && /^---$/{found=1} END{exit !found}' "$f"; then
    echo "$f: missing closing front matter delimiter"
    fail=1
    continue
  fi

  for key in "${required[@]}"; do
    val=$(printf '%s\n' "$fm" | sed -n "s/^${key}:[[:space:]]*//p" | head -n1)
    if [ -z "$val" ]; then
      echo "$f: missing or empty field '$key'"
      fail=1
    fi
  done

  status=$(printf '%s\n' "$fm" | sed -n 's/^status:[[:space:]]*//p' | head -n1)
  if [ -n "$status" ] && ! printf '%s' "$status" | grep -qE "^(${statuses})$"; then
    echo "$f: invalid status '$status'"
    fail=1
  fi

  category=$(printf '%s\n' "$fm" | sed -n 's/^category:[[:space:]]*//p' | head -n1)
  if [ -n "$category" ] && ! printf '%s' "$category" | grep -qE "^(${categories})$"; then
    echo "$f: invalid category '$category'"
    fail=1
  fi

  created=$(printf '%s\n' "$fm" | sed -n 's/^created:[[:space:]]*//p' | head -n1)
  if [ -n "$created" ] && ! printf '%s' "$created" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'; then
    echo "$f: created must be YYYY-MM-DD, got '$created'"
    fail=1
  fi

  num=$(printf '%s\n' "$fm" | sed -n 's/^hip:[[:space:]]*//p' | head -n1)
  expected=$(basename "$f" .md | sed -n 's/^hip-0*\([0-9][0-9]*\)$/\1/p')
  if [ -z "$expected" ]; then
    echo "$f: file name must look like hip-NNNN.md"
    fail=1
  elif [ -n "$num" ] && [ "$num" != "$expected" ]; then
    echo "$f: hip field '$num' does not match file name"
    fail=1
  fi

  requires=$(printf '%s\n' "$fm" | sed -n 's/^requires:[[:space:]]*//p' | head -n1)
  if [ -n "$requires" ]; then
    for dep in $(printf '%s' "$requires" | tr ',' ' '); do
      if ! printf '%s' "$dep" | grep -qE '^[0-9]+$'; then
        echo "$f: requires must be a comma separated list of HIP numbers, got '$dep'"
        fail=1
      elif [ "$dep" = "$num" ]; then
        echo "$f: a HIP cannot require itself"
        fail=1
      elif [ ! -e "$(printf 'hips/hip-%04d.md' "$((10#$dep))")" ]; then
        echo "$f: requires HIP $dep, which does not exist"
        fail=1
      fi
    done
  fi
done

if [ "$fail" -ne 0 ]; then
  echo "front matter check failed"
  exit 1
fi
echo "front matter check passed ($count files)"
