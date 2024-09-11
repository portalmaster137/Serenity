{ ... }:

{

  #systemd.tmpfiles.rules = [
    #" d ~/sync/organisation 0755 serenity users"
  #];

  services.git-sync = {
    enable = true;
    #package = [ ];
    repositories = {

      organisation-sync = {
        interval = 75000;
        url = "https://codeberg.org/serenity-F/organisation-sync.git";
      	path = "~/sync/organisation";
      	#extraPackages = pkgs.blank;
      };
      	
    };
  };

}
