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

  # To add a user, copy the template and adjust it to match,
  # then the same with the home-manager block below, then
  # add new $user.nix file in home/users/ by copyoing the 
  # existing template
  #
  #  
  # A suite of programs and applications has been provided
  # via a shared home.nix file, as well as a common config
  # across machines and users. Please do not add or remove
  # entries outside of these mentioned locations, thankyou&
   
  users.users = {

    # TEMPLATE = {
      # description = "TEMPLATE";
      # isNormalUser = true;
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
        # imports = [ ../home/users/coffee.nix ];
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
