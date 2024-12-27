# Serenity OS
**Configuration for system, applications, themes, and more; shared between multiple machines and users.**<br>
**A study in linux, system administration, packaging, user experience, desktop and system environments, themeing, and functional programming.**<br>
<br>
![desktopScreenshot](https://codeberg.org/serenity-F/nixdots/raw/branch/hyprsway/home/resources/screenshots/screenshotDesktop.png)
![desktopScreenshot2](https://codeberg.org/serenity-F/nixdots/raw/branch/hyprsway/home/resources/screenshots/screenshotTerminal.png)
<br>
- **Very much WIP and mostly stolen code at this point. A to do list and longer term goals can be found [here](https://codeberg.org/serenity-F/nixdots/issues), and [here](https://codeberg.org/serenity-F/nixdots/milestones) respectively.**<br>
- A [Wiki](https://codeberg.org/serenity-F/nixdots/wiki) and [install guide](https://codeberg.org/serenity-F/nixdots/wiki/Install-Guide) are works in progrss<br>
<br>
<br>
- Breakdown of structure<br>
<br>
  - Loose evaluation path is `flake.nix` -> `hosts/` -> `core/` -> `home/users/` -> `home/` (view the [`tree`](https://codeberg.org/serenity-F/nixdots/src/branch/swaywm/TREE.md)).<br>
<br>
  - `flake.nix` is the top-level of config, and also where universal variables are defined
  - `/hosts` is where all host-specific configs are kept
  - `/core` is where system-level packages and options are declared
  - `/home` is where all user-level packages and options are declared
    - `/home/users` is where all users and relevant options are specified
    - `/home/scripts` is exactly what it says on the tin
    - `/home/desktop` is where all desktop environment related options are specified
    - `/home/programs` is where all user-level options and packages are declared
    - `/home/resouces` is where themes, icons, etc. are kept<br>
<br>
<br>
## Attributions:
 - ### **Artwork**
  - [Vincent Van Gogh](https://en.wikipedia.org/wiki/Almond_Blossoms)
  - [Helvetica Blanc](https://helveticablanc.com/)
  - [dpcdpc11](https://dpcdpc11.gumroad.com/l/BLQpp)

 - ### **Code & Inspiration**
  - [Quantenzitrone](https://codeberg.org/quantenzitrone/nixos-config/src/branch/main)
  - [LibrePhoenix](https://github.com/librephoenix/nixos-config)
  - [anotherhadi](https://github.com/anotherhadi/nixy)
  - [Sashanoraa](https://git.sr.ht/~zethra/nixcfg)
  - [Syndicate](https://codeberg.org/hexedsilicon/nix-config)
  - [HeinzDev](https://github.com/HeinzDev/Hyprland-dotfiles)
  - [vimjoyer](https://github.com/vimjoyer)
  - [fufexan](https://github.com/\fufexan/dotfiles)
  - Wonder
  - [Hive](https://codeberg.org/theotheroracle/neutron)
