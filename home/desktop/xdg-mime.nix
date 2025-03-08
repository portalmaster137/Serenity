# Mime allows us to configure the default applications for each file type
{
  xdg = {
    mime.enable = true;
    configFile."mimeapps.list" = {
      #enable = true; # enables ? following declarations
      force = true; # forces the following declarations
    };
    #desktopEntries = { }; 
    mimeApps = {
      enable = true;
      associations = {
        added = {
          ## General Desktop
          #"text/plain" = [ "nvim.desktop" ];
          "text/markdown" = [ "obsidian.desktop" ];
          "inode/directory" = [ "nautilus.desktop" ];
          ## Multimedia
          "image/gif" = [ "gimp.desktop" ];
          "image/png" = [ "gimp.desktop" ];
          "image/jpg" = [ "gimp.desktop" ];
          "image/jpeg" = [ "gimp.desktop" ];
          "image/webp" = [ "gimp.desktop" ];
          "audio/aac" = [ "vlc.desktop" ];
          "audio/mp4" = [ "vlc.desktop" ];
          "audio/ogg" = [ "vlc.desktop" ];
          "audio/opus" = [ "vlc.desktop" ];
          "audio/mpeg" = [ "vlc.desktop" ];
          "audio/aiff" = [ "vlc.desktop" ];
          "audio/flac" = [ "vlc.desktop" ];

          ## Web 
          "text/css" = [ "firefox.desktop" ];
          "text/html" = [ "firefox.desktop" ];
          "application/json" = [ "nvim.desktop" ];
        };
      };
      defaultApplications = {
        ## General Desktop
        "text/plain" = [ "nvim.desktop" ];
        "text/markdown" = [ "nvim.desktop" ];
        "inode/directory" = [ "yazi.desktop" ];
        "application/pdf" = [ "zathura.desktop" ];
        "application/zip" = [ "org.gnome.FileRoller.desktop" ];
        ## Multimedia
        "image/gif" = [ "swayimg.desktop" ];
        "image/png" = [ "swayimg.desktop" ];
        "image/jpg" = [ "swayimg.desktop" ];
        "image/jpeg" = [ "swayimg.desktop" ];
        "image/webp" = [ "swayimg.desktop" ];
        "audio/aac" = [ "strawberry.desktop" ];
        "audio/mp4" = [ "strawberry.desktop" ];
        "audio/ogg" = [ "strawberry.desktop" ];
        "audio/opus" = [ "strawberry.desktop" ];
        "audio/mpeg" = [ "strawberry.desktop" ];
        "audio/aiff" = [ "strawberry.desktop" ];
        "audio/flac" = [ "strawberry.desktop" ];
        "audio/vnd.wav" = [ "strawberry.desktop" ];
        "video/mp4" = [ "vlc.desktop" ];
        "video/mpeg" = [ "vlc.desktop" ];
        "video/webm" = [ "vlc.desktop" ];
        "video/x-m4v" = [ "vlc.desktop" ];
        "video/x-msvideo" = [ "vlc.desktop" ];
        "video/quicktime" = [ "vlc.desktop" ];
        "video/x-matroska" = [ "vlc.desktop" ];
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
