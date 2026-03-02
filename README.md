# Serenity OS - WIP

**Configuration for system, applications, themes, and more; shared between multiple machines and users.**
<br>
**A study in linux, packaging, user experience, desktop and system environments, themeing, system administration, and functional programming.**
<br>
<br>
![desktop](https://codeberg.org/serenity-F/nixdots/raw/branch/rebuild-2/home/resources/desktop.png)
![btop](https://codeberg.org/serenity-F/nixdots/raw/branch/rebuild-2/home/resources/btop.png)
<br>

- **A to do list and longer term goals can be found [here](https://codeberg.org/serenity-F/nixdots/issues), and [here](https://codeberg.org/serenity-F/nixdots/milestones) respectively.**
<br>
- A [Wiki](https://codeberg.org/serenity-F/nixdots/wiki) and [install guide](https://codeberg.org/serenity-F/nixdots/wiki/Install-Guide) are works in progress.
<br>

## **Breakdown of structure:**
  - Loose evaluation path is `flake.nix` -> `core/hosts/<hostName>` -> `core/` -> `home/`
<br>
<br>
  - `flake.nix` is the root of the config
<br>
<br>
  - `core/` all system-level options
    - `core/hosts` all host-specific configurations
<br>
<br>
  - `home/` all user-level options
    - `/home/desktop` all desktop/wm and related options
    - `/home/terminal` all terminal and cli options
    - `/home/resources` wallpapers, themes, icons, etc.
    - `/home/multimedia` all media consumption options
<br>
<br>

 ## **Attributions:**
 - #### **Artwork:**
    - [Vincent Van Gogh](https://en.wikipedia.org/wiki/Almond_Blossoms)
    - [Helvetica Blanc](https://helveticablanc.com/)
