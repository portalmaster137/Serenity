# Serenity OS

- CURRENTLY UNDERGOING A MASSIVE REBUILD
- SUPPORT FOR MULTIPLE HOSTS AND USERS
- DENDRITIC STRUCTURE
- MAYBE FULLY COMMENTED
- MAYBE A GUIDE AND WIKI
<br>

## **Breakdown of structure:**
<br>

  - `README.md` this file
  - `resources/` various extraneous files
    - `maintenance` QoL tools and repo presentation
    - `system` wallpapers, themes, icons, avatars, etc.
<br>
<br>
  - `flake.nix` root of the config
<br>
  - `modules/` modules the flake is to build
<br>
<br>
    - `misc` assorted modules :shrug:
<br>
    - `pkgs` custom package derivations
<br>
<br>
    - `users` user declarations [REDUNDANT?]
<br>
<br>
    - `hosts` host-specific configurations
<br>
<br>
    - `home/` user-level options
      - `desktop` desktop/wm and related options
      - `terminal` terminal and cli options
      - `programs` other user-level options
<br>
<br>
    - `system/` shared system-level options
      - `nix` package manager config
      - `network` GLOBAL network configs
      - `programs` GLOBAL software configs
      - `hardware` GLOBAL hardware configs
<br>
<br>
      - `core/` [REDUNDANT?]
        - `users.nix` user declarations [REDUNDANT?]
        - `default.nix` core configurations
<br>
<br>
