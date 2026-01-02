# SerenityOS
#
#  A study in linux, packaging, user experience,
#  system and desktop environments, themeing,
#  system administration, and functional programming.
#
#  Basically, we are playing linux distro simulator. /pos
#
#  But seriously, we want to know things, best way to learn
#  is to jump in and experience. So that's what we shall do.
#
#  :D
#
#
#  Oh also, code-commenting is done like so:
#
#  - To mark a new SECTION of code, use two hashes (#)
#    and a space on the line BEFORE but with the same
#    indentation as the relevant code.
#
#  - A hash BEFORE the code is the standard for 
#    temporarily disabling a segment.
#
#  - A hash one space AFTER but on the same line
#    as the code lets you add any thoughts.
#
#
#  Example:
#
#  ## Section Heading - <relevant link>
#  nixos.module = { # needed for x thing
#    option = true;
#    #otherOption = [ "$string" ]; # disabled for z reason
#    differentOption = '' # needed to make y thing work
#      text_config1 = auto
#      text_config2 = yes
#    '';
#  };
#
#  - - - - - - - - - - - - - - - - - - - - - - - -
#
{
  description = "SerenityOS";
  ## Latest features:p
  ## - Exposed large portions of `home/` import path
  ## - Abandoned multi-user support for now
  ## - Work on commenting and reformating flake is ongoing

  inputs = {

    ## Nixpkgs version - https://github.com/NixOS/nixpkgs
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };

    ## NixOS hardware - https://github.com/NixOS/nixos-hardware
    hardware = { url = "github:nixos/nixos-hardware"; };

    ## Flake utils - https://github.com/numtide/flake-utils
    flake-utils = { url = "github:numtide/flake-utils"; };

    ## Flake parts - https://github.com/hercules-ci/flake-parts
    flake-parts = { url = "github:hercules-ci/flake-parts"; };

    ## Secrets management - https://github.com/Mic92/sops-nix
    sops-nix = { url = "github:Mic92/sops-nix"; };

    ## Zoomer text editor - https://github.com/nix-community/nixvim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Niri window manager - 
    ## https://github.com/YaLTeR/niri
    ## https://github.com/sodiboo/niri-flake/
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia =
      { # cool desktop shell - https://docs.noctalia.dev/getting-started/nixos/
        url = "github:noctalia-dev/noctalia-shell";
        inputs.nixpkgs.follows = "nixpkgs";
      };

    ## Nice-to-haves for gaming - https://github.com/fufexan/nix-gaming
    nix-gaming = { url = "github:fufexan/nix-gaming"; };

    ## Musnix - https://github.com/musnix/musnix
    musnix = { url = "github:musnix/musnix"; };

    ## Tidalcycles.nix 
    tidalcycles = {
      url = "github:mitchmindtree/tidalcycles.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Dotfiles management - https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Easy themeing - https://github.com/Misterio77/nix-colors
    # - REPLACE
    nix-colors = { url = "github:misterio77/nix-colors"; };

    stylix = { url = "github:danth/stylix"; };

    ## Boot animation
    #mac-style-plymouth = { # example setup I stole the code shamelessly from
    #url = "github:SergioRibera/s4rchiso-plymouth-theme";
    #inputs.nixpkgs.follows = "nixpkgs";
    #};
    sygil-plymouth = { # first version I "rawdogged" together
      url = "git+https://codeberg.org/serenity-F/sygil-plymouth";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sygil-plymouth-clean = { # second version using different options
      url = "git+https://codeberg.org/serenity-F/sygil-plymouth-clean";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { self, nixpkgs, sops-nix, home-manager, musnix, niri, noctalia, ... }

    @inputs:
    let

      inherit (self) outputs;

      ## Universal variable declarations
      label = "SerenityOS";
      user = "serenity"; # used for admin purposes
      userDescription = "Serenity";
      homeDirectory = "/home/${user}"; # for easy configuration
      disksPath = "${homeDirectory}/Disks"; # for easy disk navigation
      flakePath = "${homeDirectory}/${label}";
      wallpapersPath = "${homeDirectory}/Pictures/Wallpapers";
      wallpaper = "${wallpapersPath}/almondBlossoms-VanGogh.jpg";
      avatarsPath = "${homeDirectory}/Pictures/Avatars";
      avatar = "${avatarsPath}/avatar1.jpg";

    in {

      ## Available through 'nixos-rebuild <switch> --flake /path/to/flake/directory#yourhostname'
      nixosConfigurations = {

        ## Desktop - primary config
        hades = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            inherit niri noctalia;
            inherit label flakePath;
            inherit user userDescription; 
            inherit homeDirectory disksPath;
            inherit wallpapersPath wallpaper;
            inherit avatarsPath avatar;
          };
          modules = [
            ./core/hosts/hades
            #./home/desktop/noctalia.nix
            sops-nix.nixosModules.sops
            musnix.nixosModules.musnix
            home-manager.nixosModules.home-manager
            #inputs.stylix.nixosModules.stylix
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
              };
            }
          ];
        };
      };
    };
}
