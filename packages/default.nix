{ pkgs, ... }:
with pkgs;

{
  environment.systemPackages = [
    # (callPackage ./lunarvim { })
  ];
  # programs.firefox.nativeMessagingHosts.packages = [
    # (callPackage ./vdhcoapp { })
  # ];
}
