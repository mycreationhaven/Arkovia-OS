#!/bin/sh
set -eu

project_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
build_dir="$project_root/build"

if [ "$(id -u)" -ne 0 ]; then
  echo "This build must run as root. Use: sudo ./scripts/build-iso.sh" >&2
  exit 1
fi

if ! command -v lb >/dev/null 2>&1; then
  echo "live-build is required. Install it with: apt install live-build" >&2
  exit 1
fi

cd "$build_dir"
./auto/config
./auto/build

iso=$(find "$build_dir" -maxdepth 1 -type f -name '*.hybrid.iso' -print | head -n 1)
if [ -z "$iso" ]; then
  echo "Build completed without producing an expected hybrid ISO." >&2
  exit 1
fi

sha256sum "$iso" > "$iso.sha256"
echo "Created $iso"
echo "Created $iso.sha256"

