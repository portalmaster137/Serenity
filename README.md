<div align="center">

# SerenityOS

_Declarative NixOS configuration with Flakes & Home Manager_

[![NixOS](https://img.shields.io/badge/NixOS-Unstable-blue?style=for-the-badge&logo=NixOS&logoColor=white&label=NixOS&labelColor=303446&color=91D7E3)](https://nixos.org)
[![License](https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&colorA=313244&colorB=F5A97F&logo=unlicense&logoColor=F5A97F&)](https://codeberg.org/Serenity-F/SerenityOS/src/branch/main/LICENSE)

</div>

<br>

![screenshot](https://codeberg.org/serenity-F/SerenityOS/raw/branch/main/assets/repository/desktop-screenshot.png)

## ✨ Key Features

- 🎨 **Unified Theming** with Stylix
- 🪟 **Niri** with ReGreet session management
- 🏠 **Home Manager** for declarative user environments
- 📦 **Modular Architecture** for easy customization

## 💻 System Information

### Software Stack

| Component          | Implementation                       |
| ------------------ | ------------------------------------ |
| **OS**             | NixOS Unstable                       |
| **Display Server** | Wayland                              |
| **Window Manager** | Niri + ReGreet                       |
| **Desktop**        | Noctalia                             |
| **Terminal**       | Kitty                                |
| **Shell**          | Fish                                 |
| **Editor**         | Helix                                |
| **Browser**        | Firefox                              |
| **File Manager**   | Yazi                                 |
| **Theme**          | Stylix                               |
| **Filesystem**     | Ext4 + ZFS                           |

## 🛠️ System Management

### Common Commands

| Command                                     | Description                                        |
| ------------------------------------------  | -------------------------------------------------- |
| `git add --all && git commit -m "<message>"`| Save system changes to git tree                    |
| `nix flake update`                          | Update all flake inputs manually                   |
| `nix flake check`                           | Validate flake configuration                       |
| `sudo nixos-rebuild switch --flake .#<host>`| Apply system changes                               |
| `sudo nixos-rebuild test --flake .#<host>`  | Test configuration without switching               |
| `sudo nixos-rebuild boot --flake .#<host>`  | Build and set for next boot                        |

## 🤝 Contributing

While this is a personal configuration, suggestions and improvements are welcome!

- Open an issue for bugs or questions
- Submit PRs for improvements
- Share your own configs inspired by this setup

## 📜 License

MIT License - feel free to use and modify as you wish.

## 📚 Learning Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Nix Pills](https://nixos.org/guides/nix-pills/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Niri flake](https://github.com/epireyn/niri-flake)
- [Stylix Documentation](https://stylix.danth.me/)

<div align="center">

_Built with ❤️ and lots of ☕_

**[⭐ Star this repo](https://codeberg.org/Serenity-F/SerenityOS) if you found it helpful!**

</div>
