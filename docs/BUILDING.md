# Building Arkovia OS

## Status

This is a foundation build for developers. It has not yet completed the
hardware, upgrade, security, or recovery testing required for production use.

## Build host

Use a Debian-based amd64 system or virtual machine with:

- At least 4 GB RAM
- At least 30 GB free storage
- Root or sudo access
- A reliable internet connection
- `live-build` and standard Debian archive access

## Build

```bash
sudo apt update
sudo apt install live-build
./scripts/validate.sh
sudo ./scripts/build-iso.sh
```

The script configures live-build, creates an ISO beneath `build/`, and writes a
SHA-256 checksum beside it.

## GitHub Actions build

The `Build Arkovia OS ISO` workflow runs automatically when build-related files
change on `main`. It can also be started manually from the Actions page. A
successful run stores the ISO and SHA-256 checksum together as a downloadable
workflow artifact for 14 days.

The workflow artifact is a developer test image, not an Arkovia OS release.
Public releases require the Phase 1 boot tests and later release gates.

## Clean

```bash
make clean
```

Run a clean build after changing the Debian distribution, architecture,
archive areas, bootloader, or core package list.

## Virtual-machine smoke test

Before testing on physical hardware, verify that the image:

1. Boots in UEFI mode.
2. Boots in legacy BIOS mode where available.
3. Reaches the Xfce desktop.
4. Connects through wired and wireless networking.
5. Produces audio.
6. Opens the browser and file manager.
7. Starts the installer without completing a destructive install.
8. Shuts down and restarts normally.

## Physical-media warning

Writing an ISO to a USB drive destroys data on the selected drive. Verify the
device identity and size immediately before using any imaging command. This
project intentionally does not provide an automated USB-writing script during
the foundation phase.
