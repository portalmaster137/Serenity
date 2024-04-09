{ config, pkgs, ... }: {

    home.file.".local/share/icons/rose-pine-hyprcursor" = {
      recursive = true;
      source = ./rose-pine;
    };

}
