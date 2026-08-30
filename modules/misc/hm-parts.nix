{ inputs, ... }:

{

  # loads home manager modules
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

}
