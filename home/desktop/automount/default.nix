{ ... }:

{

  home.file.disks = {
    enable = true;
    source = "./Disks";
    target = "/Disks";
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
