{ pkgs, config, ... }:

{

  programs.yazi = {
  	enable = true;
  	enableFishIntegration = true;
  	
  };

}
