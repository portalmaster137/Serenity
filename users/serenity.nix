{ ... }:

{
  imports = [
  	# ../desktops/gnome/gnome.nix
  ];

  users = {
  	users.serenity = {
  	  description = "Serenity";
  	  home = "/home/serenity";
  	  createHome = true;
  	  initialPassword = "amogus";
  	  isNormalUser = true;
  	  extraGroups = [
  	  	"wheel"
  	  	"networkmanager"	
  	  ];
  	  # packages = with pkgs; [	
  	  # ];
  	  # openssh.authorizedkeys.keys =[
  	  # ];
  	};
  };

  # home-manager = {
  	# extraSpecialArgs = { inherit inputs outputs; };
  	# users = {
  	  # Import your& home-manager configs
  	  # serenity = { pkgs, ... }:
  	  
  	  # {
  	    # import ../../home-manager/home.nix;
  	    # home = { 
  	      # packages = with pkgs; [
  	        # micro
  	      # ];
          # stateVersion = "23.11";
		# };
	  # };
	# };
  # };

  system.stateVersion = 23.11;		 
}
