# Arkovia OS architecture

## System layers

1. **Debian foundation** — kernel, drivers, package management, security
   updates, and core userspace.
2. **Arkovia system layer** — defaults, branding, profiles, performance
   settings, update policy, and recovery integration.
3. **Arkovia experience layer** — Xfce desktop configuration, Welcome Center,
   software discovery, and plain-language administration.
4. **Optional profiles** — reversible package and policy selections for Home,
   Business, Church, Education, Minimal, and Custom use.

## Initial platform choices

| Component | Direction |
| --- | --- |
| Base | Debian 13 (Trixie), tracking Debian Stable |
| Architecture | amd64 first |
| Desktop | Xfce |
| Display manager | LightDM |
| Installer | Calamares foundation, pending branded configuration |
| Networking | NetworkManager |
| Audio | PipeWire and WirePlumber |
| Image tooling | Debian live-build |
| Application delivery | Debian packages first; optional Flatpak later |

## Design constraints

- The 2 GB target is for a measured light workload, not unlimited multitasking.
- Core operation must not require an Arkovia cloud account.
- Profiles must remain optional and reversible.
- Security updates take priority over visual customization.
- Arkovia-owned packages must not silently replace upstream security controls.
- 32-bit support requires a separate feasibility decision and is not promised.

## Repository strategy

Arkovia OS begins as a monorepo so build recipes, documentation, profiles, and
tests can evolve together. Components may move to separate repositories after
they gain independent release cycles.

