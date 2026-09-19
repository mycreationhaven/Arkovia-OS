# Arkovia OS

**Simple enough for everyone. Powerful enough for anywhere.**

Arkovia OS is a friendly, lightweight, and customizable Linux operating system
for homes, families, businesses, churches, schools, and communities. It is
designed to extend the useful life of older 64-bit computers without making new
Linux users learn complicated system administration.

> [!IMPORTANT]
> Arkovia OS is currently in the **Developer Preview foundation stage**. No
> production-ready ISO has been released yet.

## Product direction

- One universal Arkovia OS with optional setup profiles
- Debian Stable foundation and a customized Xfce desktop
- Graphical live USB and installer experience
- No mandatory cloud account
- Useful offline operation for essential features
- Old-PC Performance Mode and measured low-spec hardware targets
- Accessible, plain-language setup, updates, backup, and recovery

## Setup profiles

| Profile | Intended use |
| --- | --- |
| Home & Family | Everyday computing, shared accounts, media, and optional family controls |
| Business | Office work, printing, scanning, meetings, and kiosk operation |
| Church & Ministry | Presentations, streaming, media, office work, and optional faith resources |
| Education | Learning applications, coding tools, and managed student accounts |
| Minimal / Older PC | Reduced effects, fewer services, and lightweight defaults |
| Custom | Individually selected layouts, applications, and optional components |

Profiles customize one operating system. They are not separately branded
editions, and they will be designed so users can change them later.

## Hardware targets

| Level | Initial target |
| --- | --- |
| Minimum | 64-bit dual-core CPU, 2 GB RAM, and 20 GB storage |
| Recommended | 64-bit CPU, 4 GB RAM, and 40 GB storage |
| Comfortable | Four-core CPU, 8 GB RAM, and an SSD |

The minimum target is for a documented light workload. Actual support claims
will be based on tests performed on real hardware.

## Repository map

```text
branding/   Desktop visual identity and asset specifications
build/      Debian live-build configuration
config/     Arkovia system defaults
docs/       Architecture, roadmap, and build documentation
packages/   Arkovia-owned package source placeholders
profiles/   Package selections for setup profiles
scripts/    Developer build and validation commands
testing/    Hardware matrix and quality-assurance records
welcome/    Arkovia Welcome Center application area
```

## Build the foundation image

The build currently targets Debian 13 (Trixie) amd64 with Xfce. Run it on a
Debian-based build machine or container with `live-build` installed:

```bash
sudo apt update
sudo apt install live-build
sudo ./scripts/build-iso.sh
```

Build output is written beneath `build/`. See [docs/BUILDING.md](docs/BUILDING.md)
for prerequisites, cleanup, validation, and test instructions.

## Development status

The project is in **Phase 0 — Foundation**:

- [x] Product vision and core audience defined
- [x] Initial repository structure established
- [x] Reproducible live-build foundation added
- [x] Initial Arkovia wallpaper and login-screen branding added
- [ ] First ISO built and tested in a virtual machine
- [ ] Installer and Welcome Center prototypes completed
- [ ] Old-PC performance measurements collected

See [docs/ROADMAP.md](docs/ROADMAP.md) for the full development sequence.

## Contributing

The project is not yet accepting arbitrary production code, but structured
testing, documentation, accessibility, hardware, and design contributions are
welcome. Read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

## Licensing status

No open-source license has yet been selected for Arkovia-owned original work.
See [LICENSE](LICENSE) before copying or redistributing repository content.
Third-party components retain their own licenses.
