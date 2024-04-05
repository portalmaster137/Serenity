{ pkgs, config, inputs, ... }:

{

  imports = [
    ../home
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    # extraSpecialArgs = { inherit inputs; };
    users.serenity = {
      programs.home-manager.enable = true;
      # imports = [ (import ../home) ];
      home = {
      	username = "serenity";
      	homeDirectory = "/home/serenity";
      	stateVersion = "23.11";
      };
    };
  };

  users.users.serenity = {
    description = "Serenity Amalgam";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

}
