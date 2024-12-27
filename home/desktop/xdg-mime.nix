# Mime allows us to configure the default applications for each file type
{
  xdg.mimeApps = {
    defaultApplications = {

      ## Basic Text
      "text/plain" = "nvim.desktop";
      "text/markdown" = "nvim.desktop";
      "application/pdf" = "firefox.desktop";

      ## Images
      "image/gif" = "swayimg";
      "image/png" = "swayimg";
      "image/jpg" = "swayimg.desktop";
      "image/jpeg" = "swayimg.desktop";
      "image/webp" = "swayimg.desktop";

      ## Videos
      "video/mp4" = "vlc.desktop";
      "video/mpeg" = "vlc.desktop";
      "video/webm" = "vlc.desktop";
      "video/quicktime" = "vlc.desktop";
      "video/x-matroska" = "vlc.desktop";


      ## Music

      ## Gaming

      ## Web
      "text/css" = "nvim.desktop";
      "text/html" = "nvim.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";

      ## Code
      "text/x-shellscript" = "nvim.desktop";
      "text/x-xml" = "nvim.desktop";
      "text/x-yaml" = "nvim.desktop";
      "text/x-toml" = "nvim.desktop";
      "text/x-nix" = "nvim.desktop";
      "text/x-rust" = "nvim.desktop";
      "text/x-python" = "nvim.desktop";

    };
  };
}
