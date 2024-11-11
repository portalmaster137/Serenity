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
    ## planning to have a discrete config file for
    ## the greeter(s) to keep this file tidy.
     #./regreet-config.nix
     #./sddm-config.nix
  ];

  ## xserver still needed for xwayland stuff
  services.xserver.enable = true;

  ## Current login greeter/display manager,
  ## set to run wayland.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };


  ## Eventual login greeter/display manager,
  ## wayland native.
   #services.greetd = {
       #enable = true;
       #settings.default_session = {
         #command = "${pkgs.greetd.regreet}/bin/regreet";
       #};
   #};

  programs = {

    ## Eventual login greeter/display manager,
    ## wayland native.
     #regreet.enable = true;

    ## Temporary, fuck vaxery or whatever his name is
    ## punk-ass motherfucker, swayfx looks neat
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    
    ## enable sway window manager
    sway = {
      enable = true;
      package = pkgs.swayfx;
      wrapperFeatures.gtk = true;
    };
  };

}
