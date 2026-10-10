<div align="center">

# SerenityOS

_Declarative NixOS configuration with Flakes & Home Manager_ <br>
 (no it's not the ladybug)

[![NixOS](https://img.shields.io/badge/NixOS-Unstable-blue?style=for-the-badge&logo=NixOS&logoColor=white&label=NixOS&labelColor=303446&color=91D7E3)](https://nixos.org)
[![License](https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&colorA=313244&colorB=F5A97F&logo=unlicense&logoColor=F5A97F&)](https://codeberg.org/Serenity-F/SerenityOS/src/branch/main/LICENSE)

</div>

<br>

![screenshot](https://codeberg.org/serenity-F/SerenityOS/raw/branch/main/assets/repository/desktop-screenshot.png)

## 💻 System Information

### Software In Use

| Component          | Implementation                       |
| ------------------ | ------------------------------------ |
| **OS**             | NixOS Unstable                       |
| **Display Server** | Wayland                              |
| **Session Manager**| Regreet                              |
| **Window Manager** | Niri                                 |
| **Desktop**        | Noctalia                             |
| **Terminal**       | Kitty                                |
| **Shell**          | Fish                                 |
| **Editor**         | Helix                                |
| **Browser**        | Firefox                              |
| **File Manager**   | Yazi                                 |
| **Themeing**       | Stylix                               |
| **Filesystem**     | Ext4, Btrfs, or ZFS (host-dependent) |

### Local machine profile: `fractal`

The `fractal` host targets Porta's MSI MS-7C95 desktop (AMD Ryzen 5 5500, NVIDIA GeForce RTX 5060 Ti, Intel Wireless-AC 3168 Wi-Fi/Bluetooth, and x86_64 UEFI). It enables the Niri/Noctalia desktop, terminal tools, gaming, and multimedia modules. The configured displays are HDMI-A-1 at 1920×1080/180 Hz and DP-2 at 1920×1080/60 Hz.

The host configuration does not select or partition a disk. Before installing NixOS, decide which drive and filesystem to use, generate its filesystem configuration, and add the resulting UUIDs to the `fractal-hardware` module. This machine currently runs Arch Linux, so the profile has not been installed or switched on the running system.

The account is configured as `porta` and uses the local Git identity. No login password is stored in the Nix configuration; after mounting the installed system at `/mnt`, set one before the first normal login with `nixos-enter --root /mnt -c 'passwd porta'`.

### Common Commands

| Command                                     | Description                                        |
| ------------------------------------------  | -------------------------------------------------- |
| `hx <path/to/file>`                         | Edit file                                          |
| `nix flake update`                          | Update system                                      |
| `git add --all && git commit -m "<message>"`| Save system changes or updates to git tree         |
| `sudo nixos-rebuild test --flake .#<host>`  | Test changes or updates without switching          |
| `sudo nixos-rebuild switch --flake .#<host>`| Apply system changes or updates                    |

## 📋 To-Do List

 - [Enable multi-user functionality](https://codeberg.org/serenity-F/SerenityOS/milestone/145563)
 - [Provide a wiki for this config](https://codeberg.org/serenity-F/SerenityOS/milestone/145569)
 - [Provide an installer ISO or script](https://codeberg.org/serenity-F/SerenityOS/milestone/145563)

## 📝 Dev Notes

For the purposes of authenticity and earnestness

 - I will not rebase or squash any commits
 - I will not remove any outdated branches

## 📜 License

- MIT License: Feel free to use and modify as you wish.

## 📚 Learning Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Nix Pills](https://nixos.org/guides/nix-pills/)
- [Home Manager](https://nix-community.github.io/home-manager/)
- [Niri Flake](https://github.com/epireyn/niri-flake)
- [Stylix](https://stylix.danth.me/)
- [Nixflix](https://kiriwalawren.github.io/nixflix/)

## 🙋 Attributions

 ### Artwork

 - [Helvetica Blanc](https://helveticablanc.com/)
 - [Vincent Van Gogh](https://en.wikipedia.org/wiki/Almond_Blossoms/)

 ### Code

 - [V3rm1n](https://codeberg.org/v3rm1n/dotfiles/)
 - [Sashanoraa](https://codeberg.org/sashanoraa/nixcfg/)
- [Quantenzitrone](https://codeberg.org/quantenzitrone/nixos-config/)

<div align="center">

<br>

_Built with 🩵_

</div>
