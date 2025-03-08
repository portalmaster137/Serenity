{ pkgs, config, inputs, flakePath, disksPath, primaryUser, homeDir, ... }:

{

  imports = [ inputs.sops-nix.nixosModules.sops ];

  environment = { systemPackages = with pkgs; [ age age-keygen sops ]; };

  ## Sops-nix config
  sops = {
    defaultSopsFile = ./secrets.yaml; # default sops file
    defaultSopsFormat = "yaml"; # yaml for ease of use

    age.keyFile = "${homeDir}/.config/sops/age/keys.txt"; # keyfile location
    # move this to a separate private repo directory

    secrets = {

      example_key = { };

      "example_service/example_subdir/example_secret" = { };

    };
  };

}
