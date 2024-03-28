{ pkgs, lib, osConfig, ... }:
{
  programs.home-manager.enable = true;

  # Copy some files to where they go

  home.file.scripts = {
    source = ./scripts;
    target = ".local/bin/scripts";
  };

 # Installing muir packages uvu
  home.packages = with pkgs; [
 # - Multimedia
    gimp
    krita
    spotify
    jellyfin-media-player
 #  - Web & Chat
    lagrange
    schildichat-desktop
 #  - Coding
    gitui
    vscodium
  ];


  # Configure muir programs
  programs.gpg.enable = true;
  # programs.firefox = import programs/firefox.nix pkgs;
  programs.git = import programs/git.nix pkgs;
  programs.topgrade = {
    enable = false;
    settings = {
      misc = {
        assume_yes = true;
        pre_sudo = true;
        disable = [ "system" "gnome_shell_extensions" "nix" ];
      };
      commands = {
        "Upgrade System" = "nixos-upgrade -y";
      };
      post_commands = {
        "Run Garbage Collection on Nix Store" = "nix-collect-garbage";
      };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config.load_dotenv = false;
  };

  # Configure Gnome shell juuuust right WIP
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
    };
    "org/gnome/desktop/interface" = {
      prefer-dark = true;
    };
    "org/gnome/shell/keybindings" = {
      toggle-message-tray = [ "<Super>m" ];
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "terminate:ctrl_alt_bksp" "compose:ralt" ];
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      sort-directories-first = true;
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/sasha/.local/share/backgrounds/wallpaper.jpg";
      picture-uri-dark = "file:///home/sasha/.local/share/backgrounds/wallpaper.jpg";
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///home/sasha/.local/share/backgrounds/wallpaper.jpg";
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
    # Pano settings
    "org/gnome/shell/extensions/pano" = {
      open-links-in-browser = false;
      paste-on-select = false;
    };
    "org/gnome/shell/extensions/pano/text-item" = {
      header-bg-color = "rgb(97,53,131)";
      body-bg-color = "rgb(36,31,49)";
      body-color = "rgb(255,255,255)";
    };
  };
  
  # don't uh, change this or something might break lol idk
  home.stateVersion = "23.11";
}
