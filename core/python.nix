{ pkgs, ... }:
let
  
in
{

  environment = {
    systemPackages = with pkgs; [ 
      python314Full
    ] ++ (with pkgs.python314Packages; [
      #pip
      tkinter
    ]);
  };

}
