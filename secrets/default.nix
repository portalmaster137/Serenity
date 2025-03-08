{ pkgs, config, inputs, flakePath, disksPath, primaryUser, homeDir, ... }:

{

  imports = [ inputs.sops-nix.nixosModules.sops ];

  ## Packages used in sops-nix setup
  environment = { systemPackages = with pkgs; [ age ssh-to-age sops ]; };

  ## Sops-nix config
  sops = {
    defaultSopsFile = ./secrets.yaml; # default secrets file
    defaultSopsFormat = "yaml"; # .yaml format - ease of use
    age = {
      keyFile = "${homeDir}/.config/sops/age/keys.txt"; # keyfile location
      generateKey = true; # generate a new key if the one above is missing
    };

    ## List of secrets retrieved from secrets.yaml by sops-nix
    secrets = {

      loginPassword = { };

    };
  };

}
