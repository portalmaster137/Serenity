{

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      log = { enabled = false; };
      manager = {
        show_hidden = true;
        #linemode = "none"
        sort_by = "mtime";
        sort_dir_first = true;
        sort_reverse = false;
      };
    };
    #plugins = { };
  };

}
