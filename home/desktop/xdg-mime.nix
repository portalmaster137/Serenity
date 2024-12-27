# Mime allows us to configure the default applications for each file type
{
  xdg = {
    configFile."mimeapps.list" = {
      #enable = true; # enables ? following declarations
      force = true; # forces the following declarations
    };
    #desktopEntries = { }; 
    mimeApps = {
      enable = true;
      associations = {
        added = {
          ## General
          "inode/directory" = [ "yazi.desktop" ];
          "image/*" = [ "swayimg.desktop" ];
          "audio/*" = [ "strawberry.desktop" ];
          "video/*" = [ "vlc.desktop" ];
          "text/plain" = [ "nvim.desktop" ];
          "text/markdown" = [ "nvim.desktop" ];
          "application/pdf" = [ "zathura.desktop" ];
          "application/zip" = [ "org.gnome.FileRoller.desktop" ];
          ## Web
          "text/css" = [ "nvim.desktop" ];
          "text/html" = [ "nvim.desktop" ];
          "application/json" = [ "firefox.desktop" ];
          "x-scheme-handler/ftp" = [ "firefox.desktop" ];
          "x-scheme-handler/http" = [ "firefox.desktop" ];
          "x-scheme-handler/https" = [ "firefox.desktop" ];
          ## Code
          "text/x-shellscript" = [ "nvim.desktop" ];
          "text/x-xml" = [ "nvim.desktop" ];
          "text/x-yaml" = [ "nvim.desktop" ];
          "text/x-toml" = [ "nvim.desktop" ];
          "text/x-nix" = [ "nvim.desktop" ];
          "text/x-rust" = [ "nvim.desktop" ];
          "text/x-python" = [ "nvim.desktop" ];
        };
      };
      defaultApplications = {
          ## General
          "inode/directory" = [ "yazi.desktop" ];
          "image/*" = [ "swayimg.desktop" ];
          "audio/*" = [ "strawberry.desktop" ];
          "video/*" = [ "vlc.desktop" ];
          "text/plain" = [ "nvim.desktop" ];
          "text/markdown" = [ "nvim.desktop" ];
          "application/pdf" = [ "zathura.desktop" ];
          "application/zip" = [ "org.gnome.FileRoller.desktop" ];
          ## Web
          "text/css" = [ "nvim.desktop" ];
          "text/html" = [ "nvim.desktop" ];
          "application/json" = [ "firefox.desktop" ];
          "x-scheme-handler/ftp" = [ "firefox.desktop" ];
          "x-scheme-handler/http" = [ "firefox.desktop" ];
          "x-scheme-handler/https" = [ "firefox.desktop" ];
          ## Code
          "text/x-shellscript" = [ "nvim.desktop" ];
          "text/x-xml" = [ "nvim.desktop" ];
          "text/x-yaml" = [ "nvim.desktop" ];
          "text/x-toml" = [ "nvim.desktop" ];
          "text/x-nix" = [ "nvim.desktop" ];
          "text/x-rust" = [ "nvim.desktop" ];
          "text/x-python" = [ "nvim.desktop" ];
      };
    };
  };
}
