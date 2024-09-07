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
 
    # TEMPLATE = {
    #   description = "TEMPLATE";
    #   isNormalUser = true;
    #   ## be sure to change this with 'passwd'
    #   initialPassword = "password";
    #   shell = pkgs.fish;
    #   extraGroups = [
    #     "wheel"
    #     "networkmanager"
    #   ];
    # };

    # coffee = {
      # description = "Coffee Beans";
      # isNormalUser = true;
      ## be sure to change this with 'passwd'
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
      ## be sure to change this with 'passwd'
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
      #   imports = [ ./u-template.nix ];
      #   home = {
      #     username = "TEMPLATE";
      #     homeDirectory = "/home/TEMPLATE";
      #   };
      # };

      # coffee = {
        # imports = [ ./u-coffee.nix ];
        # home = {
          # username = "coffee";
          # homeDirectory = "/home/coffee";
        # };
      # };

      serenity = {
        imports = [ ./u-serenity.nix ];
        home = {
      	  username = "serenity";
      	  homeDirectory = "/home/serenity";
      	};
      };

    };
  };

}
