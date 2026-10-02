{

  description = "SerenityOS";

  # my 1 trillionth rewrite of my flake, hopefully more robust and easier to modify in future now
  # rewriting using the 'dendritic' pattern using flake-parts and such.

  # flake entry point
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake

      # pass inputs to modules
      { inherit inputs; }

      # where to find modules?
      (inputs.import-tree ./modules);

  # flake inputs
  inputs = {

    # nixos core module inputs - https://wiki.nixos.org/wiki/NixOS_Wiki
    # nixpkgs version - https://github.com/NixOS/nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nix hardware - https://github.com/NixOS/nixos-hardware
    hardware.url = "github:nixos/nixos-hardware";

    # dendritic stuff - https://github.com/mightyiam/dendritic
    # flake parts - https://github.com/hercules-ci/flake-parts
    # import tree - https://github.com/denful/import-tree
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    # helix editor plugins - https://codeberg.org/maxschipper/helix-plugins-nix
    helix-plugins = {
      url = "github:maxschipper/helix-plugins-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nice-to-haves for gaming - https://github.com/fufexan/nix-gaming
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # sound driver optimisations - https://github.com/musnix/musnix
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # media server nixos module - https://github.com/kiriwalawren/nixflix
    nixflix = {
      url = "github:kiriwalawren/nixflix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # declarative dots - https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # easy theming - https://github.com/nix-community/stylix
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # niri window manager - https://github.com/YaLTeR/niri
    # niri flake docs - https://github.com/sodiboo/niri-flake/
    niri = {
      # using alternate flake repo while sodiboo is away
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hassle free desktop shell - https://docs.noctalia.dev/getting-started/nixos/
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

}
