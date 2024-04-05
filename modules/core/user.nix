{ pkgs, config, ... }:

{

  imports = [
  ../home
  ];

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
