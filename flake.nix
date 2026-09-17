{

  description = "SerenityOS";

  # my 1 trillionth rewrite of my flake, hopefully more robust and easier to modify in future now
  # rewriting using the 'dendritic' pattern using flake-parts and such, based on examples provided by:
  #
  # vimjoyer
  # https://www.vimjoyer.com/nix/dendritic-home-manager
  #
  # v3rm1n
  # https://codeberg.org/v3rm1n/dotfiles
  #
  # quantenzitrone
  # https://codeberg.org/quantenzitrone/nixos-config

  inputs = {

    # nix hardware - https://github.com/NixOS/nixos-hardware
    hardware = {
      url = "github:nixos/nixos-hardware";
    };

    # nixpkgs version - https://github.com/NixOS/nixpkgs
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # dendritic stuff - https://github.com/mightyiam/dendritic
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    import-tree = {
      url = "github:vic/import-tree";
    };

    # sound driver optimisations - https://github.com/musnix/musnix
    musnix = {
      url = "github:musnix/musnix";
    };

    # nice-to-haves for gaming - https://github.com/fufexan/nix-gaming
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
    };

    # declarative dots - https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # easy theming - https://github.com/nix-community/stylix
    stylix = {
      url = "github:danth/stylix";
    };

    # niri window manager - https://github.com/YaLTeR/niri
    # niri flake docs - https://github.com/sodiboo/niri-flake/
    niri = {
      # using alternate flake repo while sodiboo gets their shit together
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      #inputs.niri-unstable.follows = "";
      #inputs.niri-stable.follows = "";
      #inputs.xwayland-satellite-unstable.follows = "";
      #inputs.xwayland-satellite-stable.follows = "";
    };

    # hassle free desktop shell - https://docs.noctalia.dev/getting-started/nixos/
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  # flake entry point
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake

      # pass inputs to modules
      { inherit inputs; }

      # where to find modules?
      (inputs.import-tree ./modules);

}
