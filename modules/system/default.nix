let
  desktop = [

    ./security.nix
    ./users.nix

    ./core.nix
    #./core
    ./nix

    ./network
    ./hardware
    ./programs
    ./services
  ];

  laptop = desktop ++ [
    ./services/backlight.nix
    ./services/power.nix
  ];
in
{
  inherit desktop laptop;
}
