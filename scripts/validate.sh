#!/bin/sh
set -eu

project_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
errors=0

required_files="
README.md
LICENSE
CONTRIBUTING.md
build/auto/config
build/auto/build
build/auto/clean
build/config/package-lists/arkovia-core.list.chroot
docs/ARCHITECTURE.md
docs/BUILDING.md
docs/ROADMAP.md
testing/hardware-matrix.md
"

for relative_path in $required_files; do
  if [ ! -f "$project_root/$relative_path" ]; then
    echo "Missing required file: $relative_path" >&2
    errors=$((errors + 1))
  fi
done

for script in "$project_root"/scripts/*.sh "$project_root"/build/auto/*; do
  [ -f "$script" ] || continue
  if ! sh -n "$script"; then
    errors=$((errors + 1))
  fi
done

if [ "$errors" -ne 0 ]; then
  echo "Validation failed with $errors error(s)." >&2
  exit 1
fi

echo "Arkovia OS repository validation passed."

