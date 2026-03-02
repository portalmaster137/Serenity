# SerenityOS
#
#  A study in linux, packaging, user experience,
#  desktop and system environments, themeing,
#  system administration, and functional programming.
#
#  Basically, we are playing linux distro simulator. /pos
#
#  But seriously, we want to know things, best way to learn
#  is to jump in and experience. So that's what we shall do.
#
#  :D
#
#  Formatting example:
#
#  ## <URGENT MESSAGE>
#  ## Section Heading - <relevantLink>
#  # <additionalLongerRelevantLink>
#  # <alternateSectionHeading> - <relevantLink>
#  nixos.module = { # needed for x thing
#    option = true; ## URGENT MESSAGE
#    #otherOption = [ "$string" ]; # disabled for z reason
#    differentOption = '' # needed to make y thing work
#      text_config1 = auto; # does b
#      text_config2 = yes; # does d
#    '';
#  };
#
#  - - - - - - - - - - - - - - - - - - - - - - - -
#
{

  description = "SerenityOS";

  inputs = {

    ## NixOS Core and Utilities

    # Nixpkgs version - https://github.com/NixOS/nixpkgs
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };

    # NixOS hardware - https://github.com/NixOS/nixos-hardware
    hardware = { url = "github:nixos/nixos-hardware"; };

    # Flake utils - https://github.com/numtide/flake-utils
    flake-utils = { url = "github:numtide/flake-utils"; };

    # Flake parts - https://github.com/hercules-ci/flake-parts
    flake-parts = { url = "github:hercules-ci/flake-parts"; };

    # Secrets management - https://github.com/Mic92/sops-nix
    sops-nix = { url = "github:Mic92/sops-nix"; };

    ## Window Management & Desktop

    # Niri window manager - https://github.com/YaLTeR/niri
    # - https://github.com/sodiboo/niri-flake/
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hassle free desktop shell - https://docs.noctalia.dev/getting-started/nixos/
    noctalia = { 
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Dotfiles & Theme Management

    # Declarative dots - https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Zoomer text editor - https://github.com/nix-community/nixvim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Easy themeing (Switch to stylix) - 
    # - https://github.com/nix-community/stylix
    # - https://github.com/Misterio77/nix-colors
    stylix = { url = "github:danth/stylix"; };
    nix-colors = { url = "github:misterio77/nix-colors"; };

    # Custom 'Sygil' plymouth boot theme [WIP] - https://codeberg.org/serenity-F/sygil-plymouth
    sygil-plymouth = { url = "git+https://codeberg.org/serenity-F/sygil-plymouth"; };

    ## Sound & Multimedia

    # Sound driver optimisations - https://github.com/musnix/musnix
    musnix = { url = "github:musnix/musnix"; };

    # Nice-to-haves for gaming - https://github.com/fufexan/nix-gaming
    nix-gaming = { url = "github:fufexan/nix-gaming"; };

    # Programmatic music language - https://github.com/mitchmindtree/tidalcycles.nix
    tidalcycles = {
      url = "github:mitchmindtree/tidalcycles.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  outputs =
    ## THIS IS DEFINITELY
    { self, nixpkgs, sops-nix, home-manager, musnix, niri, noctalia, stylix, flake-parts, ... }
    ## A WEIRD WAY
    @inputs:
    let
    ## TO DO THIS
      inherit (self) outputs;

      # Universal variable declarations
      label = "SerenityOS"; # used for theming
      user = "serenity"; # used for admin purposes
      userDescription = "Serenity"; # your name
      homeDirectory = "/home/${user}"; # for easy configuration
      disksPath = "${homeDirectory}/Disks"; # for easy disk navigation
      flakePath = "${homeDirectory}/${label}"; # unused currently
      wallpapersPath = "${homeDirectory}/Pictures/Wallpapers"; # where to store wallpapers
      wallpaper = "${wallpapersPath}/almondBlossoms-VanGogh.jpg"; # current wallpaper
      avatarsPath = "${homeDirectory}/Pictures/Avatars"; # where to store wallpapers
      avatar = "${avatarsPath}/avatar.jpg"; # current avatar

    in {

      ## Available through 'nixos-rebuild <switch> --flake /path/to/flake/directory#yourhostname'
      nixosConfigurations = {

        ## Desktop
        hades = nixpkgs.lib.nixosSystem {
          # Inerhiting variables
          specialArgs = {
            inherit inputs outputs;
            inherit niri noctalia;
            inherit flake-parts;
            inherit label flakePath;
            inherit user userDescription; 
            inherit homeDirectory disksPath;
            inherit wallpapersPath wallpaper;
            inherit avatarsPath avatar;
          };
          # Importing modules
          modules = [
            ./core/hosts/hades # core config
            sops-nix.nixosModules.sops # secrets module
            musnix.nixosModules.musnix # audio driver module
            stylix.nixosModules.stylix # universal theme module
            home-manager.nixosModules.home-manager # home-manager
            {
              home-manager = {
                useGlobalPkgs = true; # keeps hm pkgs pinned to system
                useUserPackages = true; # keeps hm pkgs pinned to user
                backupFileExtension = "backup"; # for emergencies only
              };
            }
          ];
        };
        
        ## Laptop

        ## Home server

        ## Remote server

        ## Installer ISO

      };
    };
}
