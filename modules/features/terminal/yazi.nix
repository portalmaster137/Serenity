{
  self,
  inputs,
  pkgs,
  ...
}:
{

  # defines a custom yazi module
  flake.modules.homeManager.yazi = {

    # packages to include
    home.package = with pkgs; [
      yazi
    ];

    programs.yazi = {

      # enables yazi
      enable = true;

      # yazi settings
      settings = { };

    };

  };
}
