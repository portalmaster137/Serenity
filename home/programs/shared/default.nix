{ pkgs, ... }:

{

  imports = [ ./git ./yazi ./btop ./fish ./nvim ./fetch ./kitty ];

  home = { packages = with pkgs; [ peaclock cmatrix ]; };

}
