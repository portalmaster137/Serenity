{

  description = "SerenityOS";

  inputs = {

    # Nixpkgs version - https://github.com/NixOS/nixpkgs
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };

    # NixOS hardware - https://github.com/NixOS/nixos-hardware
    hardware = { url = "github:nixos/nixos-hardware"; };

    # Dendritic stuff - https://www.vimjoyer.com/vid79-parts-wrapped
    flake-parts = { url = "github:hercules-ci/flake-parts"; };
    flake-utils = { url = "github:numtide/flake-utils"; };
    import-tree = { url = "github:vic/import-tree"; };
    wrapper-modules = { url = "github:BirdeeHub/nix-wrapper-modules";};
    den = { url = "github:vic/den/v0.17.0"; };

    # Secrets management - https://github.com/Mic92/sops-nix
    #sops-nix = { url = "github:Mic92/sops-nix"; };

    # Zoomer text editor - https://github.com/notashelf/nvf
    nvf = { url = "github:notashelf/nvf"; };

    # Sound driver optimisations - https://github.com/musnix/musnix
    musnix = { url = "github:musnix/musnix"; };

    # Nice-to-haves for gaming - https://github.com/fufexan/nix-gaming
    nix-gaming = { url = "github:fufexan/nix-gaming"; };


    # Declarative dots - https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Niri window manager - https://github.com/YaLTeR/niri
    niri = { # - https://github.com/sodiboo/niri-flake/
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      #inputs.niri-unstable.follows = "";
      #inputs.niri-stable.follows = "";
      #inputs.xwayland-satellite-unstable.follows = "";
      #inputs.xwayland-satellite-stable.follows = "";
    };

    # Hassle free desktop shell - https://docs.noctalia.dev/getting-started/nixos/
    noctalia = { 
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Easy theming - https://github.com/nix-community/stylix
    stylix = { url = "github:danth/stylix"; };

  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake
    {inherit inputs; }
    (inputs.import-tree ./modules);
}

