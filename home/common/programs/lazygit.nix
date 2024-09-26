{ lib, config, pkgs, ... }:

{

    programs.lazygit = {
      enable = true;
      settings = {
        gui.theme = {
          lightTheme = false;
          activeBorderColor = [ "blue" "bold" ];
          inactiveBorderColor = [ "black" ];
          selectedLineBgColor = [ "default" ];
	    };
      };
    };
	
}
