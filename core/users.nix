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

  # To add new users, copy a block for
  # an existing user, and adjust to needs.

    # coffee = {
      # description = "Coffee Beans";
      # isNormalUser = true;
      # initialPassword = "password";
      # shell = pkgs.fish;
      # extraGroups = [
        # "wheel"
        # "networkmanager"
      # ];
    # };

    serenity = {
      description = "Serenity Amalgam";
      isNormalUser = true;
      initialPassword = "password";
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
    
  };



  home-manager = {
  	extraSpecialArgs = { inherit inputs outputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {

      # coffee = {
        # imports = [ ../home/home.nix ];
        # home = {
      	  # username = "coffee";
      	  # homeDirectory = "/home/coffee";
      	  # stateVersion = "23.11";
      	# };
      # };

      serenity = {
        imports = [ ../home/home.nix ];
        home = {
      	  username = "serenity";
      	  homeDirectory = "/home/serenity";
      	  stateVersion = "23.11";
      	};
      };

    };
  };

}
