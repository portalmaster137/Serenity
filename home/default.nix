{ ... }: 

{

  imports = [
    ## Import desktop configs
    ./desktop
    ## Import program configs
    ./programs 
  ];

  ## Enabling home-manager
  programs.home-manager.enable = true; # Declarative dots
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.11";

}
