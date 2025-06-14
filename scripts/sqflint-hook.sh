#!/bin/bash
set -e
failed=0
for file in "$@"; do
  if ! sqflint -e w "$file"; then
    failed=1
  fi
done
exit $failed
