{ ... }:

{

  home.file."Disks" = {
    source = ../automount/Disks;
    recursive = true;
  };

  services = {
    udiskie = {
      enable = true;
      automount = true;
      tray = "always";
      notify = true;
      #settings = {
      #};
    };
  };

}
