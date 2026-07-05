let
  desktop = [

    ./core
    ./core/boot.nix
    ./network
    ./hardware/brightness.nix
    ./hardware/graphics.nix
    ./hardware/bluetooth.nix
    ./programs
    ./services
    ./services/greetd.nix
    ./services/pipewire.nix
  ];

  laptop = desktop ++ [
    ./services/backlight.nix
    ./services/power.nix
  ];
in
{
  inherit desktop laptop;
}
