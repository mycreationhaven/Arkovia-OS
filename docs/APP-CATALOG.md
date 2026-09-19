# Arkovia App Catalog

The Arkovia App Catalog is a small graphical selector for optional software.
It groups recommendations by intended use without creating separate Arkovia OS
editions. Nothing in the catalog is preselected, installed, or stored in the
ISO. An internet connection and administrator authorization are required.

## Church & Ministry

| Application | Installation path |
| --- | --- |
| OpenLP | Debian package installed through APT |
| ChurchCRM | Official guided setup documentation |

ChurchCRM is a server-based web application that stores sensitive membership
and financial records. A safe installation requires explicit decisions about
hosting, database access, TLS, backups, and recovery. The catalog therefore
opens ChurchCRM's official guide rather than deploying an undocumented local
server automatically.

## Business

| Application | Installation path |
| --- | --- |
| LibreOffice | Debian package installed through APT |
| Thunderbird | Debian package installed through APT |
| 7-Zip | Debian package installed through APT |
| Google Chrome | Official Google Debian package after a third-party notice |

Arkovia's base desktop uses lightweight Xarchiver for ordinary archive tasks.
Debian 13's File Roller package requires 7-Zip, so File Roller is deliberately
not bundled; this keeps the full 7-Zip tool an honest optional selection.

Chrome is proprietary software outside Debian. The user must explicitly accept
a separate notice before Arkovia downloads it from Google's HTTPS distribution
site. Google's package configures its signed repository for future updates.

## Home & Family

Krita, VLC Media Player, Stellarium, PySolFC, SuperTuxKart, 0 A.D., and Kiwix
are installed from Debian's authenticated repositories only when individually
selected.

Kiwix itself is optional and small compared with its content libraries. Users
choose and download any offline `.zim` libraries separately after installing
Kiwix; those libraries are never part of the Arkovia OS ISO.

## Safety boundaries

- The privileged installer accepts only fixed catalog identifiers.
- Debian packages come from configured, authenticated APT repositories.
- The catalog does not run automatically during installation or first boot.
- Canceling the catalog makes no system changes.
- Future catalog additions must remain optional and pass the ISO non-bundling
  test before release.
