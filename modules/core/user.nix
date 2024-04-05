{ pkgs, config, inputs, ... }:

{

  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    # extraSpecialArgs = { inherit inputs username; };
    users.serenity = {
      imports = [ (import ../home) ];
      home.username = "serenity";
      home.homeDirectory = "/home/serenity";
      home.stateVersion = "23.11";
      programs.home-manager.enable = true;
    };
  };

  users = {

  	defaultUserShell = pkgs.fish;

    users.serenity = {
      description = "Serenity Amalgam";
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [
      	"wheel"
      	"networkmanager"
      ];
    };

  };


  system.stateVersion = "23.11";
  
}
