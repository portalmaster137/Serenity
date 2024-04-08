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

  # To add a user, copy the template in the users.users
  # block and adjust it to match,then the same with the
  # home-manager block below, then add new username.nix
  # file in home/users by copying the existing template
  #  
  # A suite of programs and applications has been provided
  # via a shared home.nix file, as well as a common config
  # across machines and users. Please do not add or remove
  # entries outside of these mentioned locations, thankyou&
   
  users.users = {

    # TEMPLATE = {
      # description = "TEMPLATE";
      # isNormalUser = true;
      # # be sure to change this with 'passwd'
      # initialPassword = "password";
      # shell = pkgs.fish;
      # extraGroups = [
        # "wheel"
        # "networkmanager"
      # ];
    # };

    coffee = {
      description = "Coffee Beans";
      isNormalUser = true;
      # be sure to change this with 'passwd'
      initialPassword = "password";
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };

    serenity = {
      description = "Serenity Amalgam";
      isNormalUser = true;
      # be sure to change this with 'passwd'
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

      # TEMPLATE = {
        # imports = [ ./-template.nix ];
        # home = {
      	  # username = "TEMPLATE";
      	  # homeDirectory = "/home/TEMPLATE";
      	# };
      # };

      coffee = {
        imports = [ ./-coffee.nix ];
        home = {
      	  username = "coffee";
      	  homeDirectory = "/home/coffee";
      	 };
      };

      serenity = {
        imports = [ ./-serenity.nix ];
        home = {
      	  username = "serenity";
      	  homeDirectory = "/home/serenity";
      	};
      };

    };
  };

}
