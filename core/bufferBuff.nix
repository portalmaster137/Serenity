{ ... }:

{

  # Increased download buffer as it caused issues previously
  nix.settings.download-buffer-size = [ "268435456" ];

  # Temporarily increasing max open files for my bloated flake
  systemd.settings.Manager = { DefaultLimitNOFILE = "8192:524288"; };
  sercurity.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "8192";
  }];

}
