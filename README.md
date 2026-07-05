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
  - `flake.nix` root of the config
<br>
<br>
  - `modules/` modules the flake is to build
<br>
    - `misc` assorted modules :shrug:
    - `pkgs` custom package derivations
    - `users` user declarations [REDUNDANT?]
<br>
    - `system/` shared system-level options
      - `nix` package manager config
      - `network` GLOBAL network configs
      - `programs` GLOBAL software configs
      - `hardware` GLOBAL hardware configs
      - `core/` [REDUNDANT?]
        - `users.nix` user declarations [REDUNDANT?]
        - `default.nix` core configurations
<br>
    - `home/` user-level options
      - `desktop` desktop/wm and related options
      - `terminal` terminal and cli options
      - `programs` other user-level options
<br>
    - `hosts/` host-specific configurations
      - `hades` only current functional host
<br>
