{ ... }:

{

  imports = [
    ## Semi-modularised config
    #./sync.nix # Syncthing and gitwatch settings
    ./audio.nix # Musnix and ... audio ... config
    ./display.nix # Display configs
    ./regreet.nix # Login greeter config
    ./packages.nix # All system-level packages here
  ];

}
