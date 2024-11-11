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
     #./regreet.nix
    ./sddm.nix
  ];

  ## xserver still needed for xwayland stuff
  services.xserver.enable = true;

  programs = {

    ## Temporary, fuck vaxery or whatever his name is
    ## punk-ass motherfucker, swayfx looks neat
    ## and is probably more stable anyway so yeah
    ## whatever, im not mad, why would you think im mad
    ## its not like the prettiest wayland "wm" has
    ## a complete shithead as a lead dev, it's not
    ## like i got sold on it and nearly set it up
    ## completely before finding out about vaxo-bingus'
    ## chuddery and deciding i had to jump ship to sway
    ## a "wm" with comparatively little by ways of 
    ## "eye-candy". Oh boy am i glad swayfx exists
    ## 
    ## Authors note: this is excessive, overly dramatic,
    ## and played entirely (mostly) for laughs.
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

  };

}
