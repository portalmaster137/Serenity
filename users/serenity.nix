{ ... }:

{
  imports = [
  	../desktops/gnome/gnome.nix
  ];

  users = {
  	users.serenity = {
  	  description = "Serenity";
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
  	 # serenity = import ..../home-manager/home.nix;
  	# };
  # };

  system.stateVersion = "23.11";
}
