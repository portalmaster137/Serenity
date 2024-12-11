{ ... }:

{

  home.file."Disks" = {
    source = "./Disks/";
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
