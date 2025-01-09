{ ... }:

{

  imports = [
    ## Import desktop configs
    ./desktop
    ## Import program configs
    ./programs
    ## Import user themes
    ./resources/themes
    ./resources/themes/SerenityOS.nix
  ];

  ## Enabling home-manager
  programs.home-manager.enable = true; # Declarative dots
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.11";

}
