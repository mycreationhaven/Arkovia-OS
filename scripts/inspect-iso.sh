#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 path/to/arkovia.iso" >&2
  exit 2
fi

iso=$1
if [ ! -f "$iso" ]; then
  echo "ISO not found: $iso" >&2
  exit 1
fi

for command in xorriso unsquashfs sha256sum; do
  if ! command -v "$command" >/dev/null 2>&1; then
    echo "Required command is unavailable: $command" >&2
    exit 1
  fi
done

work_dir=$(mktemp -d)
trap 'rm -rf "$work_dir"' EXIT HUP INT TERM

echo "Checking ISO checksum..."
checksum_file="${iso%.iso}.iso.sha256"
if [ ! -f "$checksum_file" ]; then
  checksum_file="${iso}.sha256"
fi
if [ ! -f "$checksum_file" ]; then
  echo "Checksum file not found for $iso" >&2
  exit 1
fi
(cd "$(dirname "$checksum_file")" && sha256sum --check "$(basename "$checksum_file")")

echo "Checking BIOS and UEFI boot metadata..."
xorriso -indev "$iso" -report_el_torito plain >"$work_dir/el-torito.txt" 2>&1
grep -Eiq 'BIOS' "$work_dir/el-torito.txt" || {
  echo "No legacy BIOS El Torito boot entry was found." >&2
  cat "$work_dir/el-torito.txt" >&2
  exit 1
}
grep -Eiq 'UEFI' "$work_dir/el-torito.txt" || {
  echo "No UEFI El Torito boot entry was found." >&2
  cat "$work_dir/el-torito.txt" >&2
  exit 1
}

echo "Extracting the live filesystem..."
xorriso -osirrox on -indev "$iso" \
  -extract /live/filesystem.squashfs "$work_dir/filesystem.squashfs" \
  >"$work_dir/xorriso-extract.txt" 2>&1

echo "Checking Arkovia identity and branding..."
for path in \
  etc/arkovia-release \
  etc/os-release \
  etc/lsb-release \
  etc/default/grub.d/60-arkovia.cfg \
  etc/plymouth/plymouthd.conf \
  etc/calamares/settings.conf \
  etc/calamares/branding/arkovia/branding.desc \
  etc/apt/apt.conf.d/20auto-upgrades \
  etc/apt/apt.conf.d/52arkovia-updates \
  etc/lightdm/lightdm-gtk-greeter.conf.d/60-arkovia.conf \
  usr/local/bin/arkovia-app-catalog \
  usr/local/sbin/arkovia-install-apps \
  usr/share/arkovia/app-catalog.tsv \
  usr/share/plymouth/themes/arkovia/arkovia.plymouth \
  usr/share/plymouth/themes/arkovia/arkovia.script \
  usr/share/backgrounds/arkovia/theme-ocean-wildlife.jpg \
  usr/share/backgrounds/arkovia/theme-space.jpg \
  usr/share/backgrounds/arkovia/theme-forest-wildlife.jpg \
  usr/share/backgrounds/arkovia/theme-around-the-world.jpg \
  usr/share/applications/arkovia-app-catalog.desktop \
  usr/share/applications/arkovia-update-center.desktop \
  usr/share/backgrounds/arkovia/arkovia-default.svg; do
  if ! unsquashfs -cat "$work_dir/filesystem.squashfs" "$path" >/dev/null 2>&1; then
    echo "Missing live-filesystem file: /$path" >&2
    exit 1
  fi
done

unsquashfs -cat "$work_dir/filesystem.squashfs" etc/arkovia-release \
  | grep -q '^PRETTY_NAME="Arkovia OS' || {
    echo "The live filesystem does not identify itself as Arkovia OS." >&2
    exit 1
  }

unsquashfs -cat "$work_dir/filesystem.squashfs" etc/calamares/settings.conf \
  | grep -q '^branding: arkovia' || {
    echo "Calamares is not configured to use Arkovia branding." >&2
    exit 1
  }

unsquashfs -cat "$work_dir/filesystem.squashfs" etc/plymouth/plymouthd.conf \
  | grep -q '^Theme=arkovia' || {
    echo "The animated Arkovia boot theme is not active." >&2
    exit 1
  }

unsquashfs -cat "$work_dir/filesystem.squashfs" etc/os-release \
  | grep -q '^PRETTY_NAME="Arkovia OS' || {
    echo "The visible OS identity is not branded as Arkovia OS." >&2
    exit 1
  }

unsquashfs -cat "$work_dir/filesystem.squashfs" etc/issue \
  | grep -q '^Arkovia OS' || {
    echo "The console identity is not branded as Arkovia OS." >&2
    exit 1
  }

echo "Checking desktop, browser, and installer packages..."
unsquashfs -cat "$work_dir/filesystem.squashfs" var/lib/dpkg/status >"$work_dir/dpkg-status"
for package in xfce4 lightdm calamares firefox-esr unattended-upgrades package-update-indicator gnome-package-updater yad; do
  if ! awk -v package="$package" '
    $1 == "Package:" { current = $2 }
    current == package && $0 == "Status: install ok installed" { found = 1 }
    END { exit found ? 0 : 1 }
  ' "$work_dir/dpkg-status"; then
    echo "Required package is not installed in the live filesystem: $package" >&2
    exit 1
  fi
done

echo "Checking that optional profile applications are not bundled..."
for package in openlp libreoffice thunderbird 7zip krita vlc stellarium pysolfc supertuxkart 0ad kiwix google-chrome-stable; do
  if awk -v package="$package" '
    $1 == "Package:" { current = $2 }
    current == package && $0 == "Status: install ok installed" { found = 1 }
    END { exit found ? 0 : 1 }
  ' "$work_dir/dpkg-status"; then
    echo "Optional application was unexpectedly bundled in the ISO: $package" >&2
    exit 1
  fi
done

echo "Arkovia OS ISO inspection passed."
