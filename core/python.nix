{ pkgs, ... }:
let
  
in
{

  environment = {
    systemPackages = with pkgs; [ 
      python314
    ] ++ (with pkgs.python314Packages; [
      #pip
      tkinter
    ]);
  };

}
