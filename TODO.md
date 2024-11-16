# Primary short term to do list:

## URGENT

- [ ] fix steam

- [ ] set up nixvim

- [ ] sort data (sisyphean)

- [ ] restructure flake
    - primarily to fix hardware-configs, 
    secondarily to improve granularity over host-configs
    - [ ] /home tidy up
        - [X] programs
        - [X] services
        - [X] scripts
            - [X] figure them all out
            - [X] delete the unneeded stuff
        - [ ] themes & resources
            - [ ] figure out themes imports
            - [ ] credit wallpapers
        - [ ] home/desktop
            - [X] dedup hypr/sway files
            - [X] get sway workable
            - [ ] fully switch over

- [X] fix low-latency audio crackles over speakers
    - [X] works? (tentative)
    - `crackling @  96/48kHz [2ms]`
    - `testing   @ 144/48kHz [3ms]`
    - `works     @ 144/48kHz [3ms]`

- [ ] set up Syncthing (devices sync)

- [ ] tidy up repo presentation

- [ ] fully comment all code (half done)
- [ ] fully format all code (unknown)

- [ ] fix wifi on hades
    - [ ] get a wireless card [hw upgrade]
    - seems to be a hardware issue when using a USB dongle.
    current workaround is using a spare mobile connected
    to wifi with USB tethering enabled, a dongle.
    solution is to get a wifi card, must connect with PCIe,
    include bluetooth, and have flawless linux support 

- [ ] Make an install ISO

## IN PROGRESS

- #### security
    - [ ] sops
    - [ ] polkit
    - [ ] keyring
    - [ ] keepass setup
        - [ ] log in to everything

- #### gaming
    - [X] osu
    - [ ] steam
        - [ ] proton

- #### system
    - [X] Per host configs
        - [ ] Cloud server
        - [ ] ISO
        - [X] Hades
        - [X] Persephone
        - [ ] Orcus
            - [X] Set up ZFS pool
            - [ ] Set up Jellyfin
            - [ ] Set up Nicotine+
            - [ ] Set up local network share
        - [ ] Further specialise host configs
    - [ ] Desktop application suite
    - [ ] Themes
        - [ ] Per user configs
        - [ ] Fonts
        - [ ] Icons
        - [ ] GTK theme
        - [ ] QT Themes
        - [X] Wallpapers
        - [ ] nix-colors/stylix

- #### coding
    - [ ] nixvim
    - [ ] Devshells
        - [ ] C#
        - [ ] Rust
        - [ ] Python
        - [ ] Haskell

- #### audio and music
    - ##### config
        - [X] helvum
        - [X] pavucontrol
        - [X] easy-effects
        - [X] low latency config
    - ##### playback
        - [X] spotify
        - [ ] local player
        - [ ] local scrobbling
    - ##### creation
        - [ ] ardour
        - [X] bespoke
        - [X] audacity
        - [ ] midi control
        - [ ] vcv-rack/cardinal
        - [ ] neural-amp-modeler

- #### android integration
    - ##### note taking sync
        - [ ] gitsync(?)
        - [ ] obsidian
        - [ ] syncthing
            - [ ] directory creation
    - ##### general integration
        - [ ] kde-connect
        - [ ] bluetooth [hw upgrade]
        - [ ] sway desktop integration [bt/kde]
        - [ ] dedicated usb-c interface [hw upgrade]

