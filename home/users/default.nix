{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

{

  imports = [
    inputs.home-manager.nixosModules.default
  ];
   
  users.users = {
 # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    serenity = {
      description = "Serenity Amalgam";
      isNormalUser = true;
      ## be sure to change this with 'passwd'
      initialPassword = "password";
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };



 # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  };

  home-manager = {
  	extraSpecialArgs = { inherit inputs outputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
 # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

      serenity = {
        imports = [ ./u-serenity.nix ];
        home = {
      	  username = "serenity";
      	  homeDirectory = "/home/serenity";
      	};
      };



 # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    };
  };

}
