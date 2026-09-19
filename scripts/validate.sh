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
build/config/includes.chroot/usr/share/backgrounds/arkovia/arkovia-default.svg
build/config/includes.chroot/usr/share/backgrounds/arkovia/theme-ocean-wildlife.jpg
build/config/includes.chroot/usr/share/backgrounds/arkovia/theme-space.jpg
build/config/includes.chroot/usr/share/backgrounds/arkovia/theme-forest-wildlife.jpg
build/config/includes.chroot/usr/share/backgrounds/arkovia/theme-around-the-world.jpg
build/config/includes.chroot/usr/share/plymouth/themes/arkovia/arkovia.plymouth
build/config/includes.chroot/usr/share/plymouth/themes/arkovia/arkovia.script
build/config/includes.chroot/usr/share/plymouth/themes/arkovia/dot.png
build/config/includes.chroot/etc/plymouth/plymouthd.conf
build/config/includes.chroot/etc/os-release
build/config/includes.chroot/etc/lsb-release
build/config/includes.chroot/etc/default/grub.d/60-arkovia.cfg
build/config/includes.chroot/etc/calamares/branding/arkovia/branding.desc
build/config/hooks/live/0100-arkovia-branding.hook.chroot
build/config/hooks/live/0200-arkovia-boot-menu.hook.binary
build/config/includes.chroot/etc/lightdm/lightdm-gtk-greeter.conf.d/60-arkovia.conf
build/config/includes.chroot/etc/apt/apt.conf.d/20auto-upgrades
build/config/includes.chroot/etc/apt/apt.conf.d/52arkovia-updates
build/config/includes.chroot/usr/share/applications/arkovia-update-center.desktop
build/config/includes.chroot/usr/share/applications/arkovia-app-catalog.desktop
build/config/includes.chroot/usr/share/arkovia/app-catalog.tsv
build/config/includes.chroot/usr/local/bin/arkovia-app-catalog
build/config/includes.chroot/usr/local/sbin/arkovia-install-apps
scripts/inspect-iso.sh
docs/ARCHITECTURE.md
docs/BUILDING.md
docs/APP-CATALOG.md
docs/ROADMAP.md
docs/UPDATES.md
branding/WALLPAPERS.md
testing/hardware-matrix.md
"

for relative_path in $required_files; do
  if [ ! -f "$project_root/$relative_path" ]; then
    echo "Missing required file: $relative_path" >&2
    errors=$((errors + 1))
  fi
done

optional_packages="openlp libreoffice thunderbird 7zip krita vlc stellarium pysolfc supertuxkart 0ad kiwix google-chrome-stable"
for package in $optional_packages; do
  if grep -Eq "^[[:space:]]*$package([[:space:]]|$)" \
    "$project_root/build/config/package-lists/arkovia-core.list.chroot"; then
    echo "Optional package must not be bundled in the core ISO: $package" >&2
    errors=$((errors + 1))
  fi
done

if ! grep -q 'ARKOVIA OS' "$project_root/build/config/includes.chroot/usr/share/backgrounds/arkovia/arkovia-default.svg"; then
  echo "Arkovia wallpaper branding text is missing." >&2
  errors=$((errors + 1))
fi

if ! grep -q '^PRETTY_NAME="Arkovia OS' "$project_root/build/config/includes.chroot/etc/os-release"; then
  echo "Visible operating-system identity is not branded as Arkovia OS." >&2
  errors=$((errors + 1))
fi

if grep -Eqi '^((NAME|PRETTY_NAME|DISTRIB_DESCRIPTION)=.*Debian)' \
  "$project_root/build/config/includes.chroot/etc/os-release" \
  "$project_root/build/config/includes.chroot/etc/lsb-release"; then
  echo "Visible operating-system identity still contains Debian branding." >&2
  errors=$((errors + 1))
fi

for script in "$project_root"/scripts/*.sh "$project_root"/build/auto/* "$project_root"/build/config/hooks/live/*; do
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
