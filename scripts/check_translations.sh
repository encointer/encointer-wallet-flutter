#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

file="$1"

if grep -q '{}' "$file"; then
  echo "No missing translations found."
else
  echo "Found missing translations:"
  cat "$file"
  exit 1
fi
