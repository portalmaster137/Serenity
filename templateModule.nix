{ ... }:
let
  x = 1;
  a = x;
in 

{

  imports = [ ];

  environment = { 
    systemPackages = [ ];
  };

  programs = {
    name = {
      enable = true;
      someValue = a;
      settings = {  };
    };
  };

}
