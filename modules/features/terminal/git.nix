{
  self,
  inputs,
  pkgs,
  ...
}:
{

  # defines a custom git module
  flake.modules.homeManager.git = {

    # packages to include
    home.packages = with pkgs; [
      git
    ];

    programs.git = {
      enable = true;
    };

  };

}
