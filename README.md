# Serenity OS - WIP
**Configuration for system, applications, themes, and more; shared between multiple machines and users.**<br>
**A study in linux, system administration, packaging, user experience, desktop and system environments, themeing, and functional programming.**<br>
<br>
![desktopScreenshot](https://codeberg.org/serenity-F/nixdots/raw/branch/hyprsway/home/resources/screenshots/screenshotDesktop.png)
![desktopScreenshot2](https://codeberg.org/serenity-F/nixdots/raw/branch/hyprsway/home/resources/screenshots/screenshotTerminal.png)
<br>
- **A to do list and longer term goals can be found [here](https://codeberg.org/serenity-F/nixdots/issues), and [here](https://codeberg.org/serenity-F/nixdots/milestones) respectively.**<br>
- A [Wiki](https://codeberg.org/serenity-F/nixdots/wiki) and [install guide](https://codeberg.org/serenity-F/nixdots/wiki/Install-Guide) are works in progress.<br>
- **[!]** contains lots of stolen code :3 **[!]**
<br>
<br>
- Breakdown of structure<br>
<br>
  - Loose evaluation path is `flake.nix` -> `core/hosts` -> `core/` -> `home/users/` -> `home/` (view the [`tree`](https://codeberg.org/serenity-F/nixdots/src/branch/swaywm/TREE.md)).
<br>
<br>
  - `flake.nix` is the top-level of config
<br>
<br>
  - `/core` all system-level options contained here
    - `core/hosts` all host-specific configs here
    - `core/modules` most shared and optional configurations here
<br>
<br>
  - `/home` is where all user-level packages and options are declared
    - `/home/users` is where all users and relevant options are specified
    - `/home/scripts` this is exactly what it says on the tin
    - `/home/desktop` is where all desktop environment related options are specified
    - `/home/programs` is where all user-level packages and programs are declared
    - `/home/resouces` is where wallpapers, themes, icons, etc. are kept<br>
<br>
<br>
## Attributions:
 - ### **Artwork**
  - [Vincent Van Gogh](https://en.wikipedia.org/wiki/Almond_Blossoms)
  - [Helvetica Blanc](https://helveticablanc.com/)

 - ### **Code & Inspiration**
  - [Quantenzitrone](https://codeberg.org/quantenzitrone/nixos-config/src/branch/main)
  - [LibrePhoenix](https://github.com/librephoenix/nixos-config)
  - [anotherhadi](https://github.com/anotherhadi/nixy)
  - [Sashanoraa](https://git.sr.ht/~zethra/nixcfg)
  - [Syndicate](https://codeberg.org/hexedsilicon/nix-config)
  - [HeinzDev](https://github.com/HeinzDev/Hyprland-dotfiles)
  - [vimjoyer](https://github.com/vimjoyer)
  - [fufexan](https://github.com/\fufexan/dotfiles)
  - [Hive](https://codeberg.org/theotheroracle/neutron)
