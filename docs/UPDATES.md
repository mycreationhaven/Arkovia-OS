# Arkovia OS update policy

Arkovia OS uses Debian's signed package repositories and APT update system.
Its default policy is designed to keep routine maintenance understandable for
new users while retaining Debian's established security infrastructure.

## User experience

- Arkovia checks Debian's package lists once each day when a suitable network
  connection is available.
- The desktop update indicator notifies the user when updates are available.
- **Arkovia Update Center** in the application menu provides a graphical way
  to review and install updates.
- Trusted Debian Stable and Debian Security updates are installed unattended.
- Arkovia never enables automatic release upgrades to a new Debian major
  version. Major-version upgrades require a tested Arkovia migration path.

## Safety defaults

- Packages must come from configured, authenticated APT repositories.
- Automatic updates pause on battery power and metered network connections.
- Package operations are divided into interruptible steps.
- Interrupted package configuration is repaired automatically.
- Automatic reboots are disabled; users stay in control of restarts.
- User-modified configuration files retain Debian's normal protection.
- Logs are available under `/var/log/unattended-upgrades/` and through the
  system journal.

## Update sources

The Debian configuration supplied by `unattended-upgrades` tracks packages
whose release metadata identifies them as the installed Debian Stable release
or Debian Security. Arkovia's configuration augments those upstream defaults
without replacing Debian's origin checks.
