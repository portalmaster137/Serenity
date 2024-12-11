{ ... }: 

{

  imports = [
    ## Import desktop configs
    ./desktop
    ## Import service configs
    ./scripts/systemd
    ## Import program configs
    ./programs 
  ];

  ## Enabling home-manager
  programs.home-manager.enable = true; # Declarative dots
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";

}
