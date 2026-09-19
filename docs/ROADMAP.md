# Arkovia OS development roadmap

## Phase 0 — Foundation

- Product charter and audience definition
- Repository and contribution structure
- Initial licensing policy
- Reproducible Debian/Xfce image configuration
- Hardware test inventory

## Phase 1 — First boot

- [x] Build the first internal ISO through GitHub Actions
- [x] Add the first desktop and login-screen branding
- [x] Configure the hybrid live USB build path
- [x] Add automated ISO checks for UEFI and supported legacy-BIOS boot metadata
- Validate real UEFI and supported legacy-BIOS boots in virtual machines
- Create repeatable virtual-machine smoke tests

## Phase 2 — Friendly setup

- [x] Add graphical update notifications and an Arkovia Update Center
- [x] Enable safe automatic Debian Stable and Security updates
- [x] Add an online, opt-in App Catalog for Home, Business, and Church profiles
- Brand and simplify the graphical installer
- Create the Arkovia Welcome Center
- Implement reversible setup profiles
- Add desktop layout and accessibility choices
- Implement Old-PC Performance Mode

## Phase 3 — Dependability

- Establish signed Arkovia package delivery
- Add backup and recovery workflows
- Test upgrades and interrupted updates
- Create issue-reporting and diagnostic tools
- Measure idle memory, boot time, and common workloads

## Phase 4 — Real-world pilot

- Pilot selected home, business, church, education, and older-PC systems
- Track hardware compatibility and user confusion
- Correct high-priority reliability and accessibility problems
- Publish the beta support boundaries

## Phase 5 — Arkovia OS 1.0

- Publish verified ISO images and checksums
- Provide installation, recovery, and administration guides
- Establish release and security-support policies
- Document a stable upgrade path

## Phase 6 — Growth

- Optional managed-device capabilities
- Localization and translation
- Expanded hardware certification
- Community governance and contribution growth
