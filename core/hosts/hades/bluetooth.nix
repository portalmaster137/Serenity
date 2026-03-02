{ pkgs, config, ... }:

{
  imports = [ ];

  #services.blueman.enable = true; # enables blueman

  hardware.bluetooth = {
    enable = true; # Enables bluetooth
    powerOnBoot = true; # Turns the bluetooth adapter on at boot
    input.General = { UserspaceHID = true; }; # fix bluetooth keyboard input
    settings.General = {
      Experimental = true; # Displays battery charge of connected devices
      FastConnectable = true; # Uses more power, but hades is a desktop
    };
  };

}
