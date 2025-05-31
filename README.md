# Serenity OS - WIP

**Configuration for system, applications, themes, and more; shared between multiple machines and users.**
<br>
**A study in linux, system administration, packaging, user experience, desktop and system environments, themeing, and functional programming.**
<br>
<br>
![desktopScreenshot](https://codeberg.org/serenity-F/nixdots/raw/branch/swaywm/home/resources/screenshots/screenshotDesktop.png)
![desktopScreenshot2](https://codeberg.org/serenity-F/nixdots/raw/branch/swaywm/home/resources/screenshots/screenshotTerminal.png)
<br>

- **A to do list and longer term goals can be found [here](https://codeberg.org/serenity-F/nixdots/issues), and [here](https://codeberg.org/serenity-F/nixdots/milestones) respectively.**
<br>
- A [Wiki](https://codeberg.org/serenity-F/nixdots/wiki) and [install guide](https://codeberg.org/serenity-F/nixdots/wiki/Install-Guide) are works in progress.
<br>
- **[!]** contains lots of stolen code :3 **[!]**
<br>

## **Breakdown of structure:**
  - Loose evaluation path is `flake.nix` -> `core/hosts` -> `core/` -> `home/users/` -> `home/`
<br>
<br>
  - `flake.nix` is the top-level of config
<br>
<br>
  - `/core` all system-level options
    - `core/hosts` all host-specific configurations
<br>
<br>
  - `/home` all user-level options
    - `/home/users` users and related options
    - `/home/scripts` what it says on the tin
    - `/home/desktop` all desktop/wm and related options
    - `/home/programs` all user-level packages and programs
    - `/home/resouces` wallpapers, themes, icons, etc.
<br>
<br>

 ## **Attributions:**
 - #### **Artwork:**
    - [Vincent Van Gogh](https://en.wikipedia.org/wiki/Almond_Blossoms)
    - [Helvetica Blanc](https://helveticablanc.com/)

- #### **Inspiration:**
    - [Quantenzitrone](https://codeberg.org/quantenzitrone/nixos-config/src/branch/main)
    - [LibrePhoenix](https://github.com/librephoenix/nixos-config)
    - [anotherhadi](https://github.com/anotherhadi/nixy)
    - [Sashanoraa](https://git.sr.ht/~zethra/nixcfg)
    - [Syndicate](https://codeberg.org/hexedsilicon/nix-config)
    - [HeinzDev](https://github.com/HeinzDev/Hyprland-dotfiles)
    - [vimjoyer](https://github.com/vimjoyer)
    - [fufexan](https://github.com/\fufexan/dotfiles)
    - [Hive](https://codeberg.org/theotheroracle/neutron)
