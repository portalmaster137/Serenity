{ self, ... }:
{
  flake.nixosModules.coreConfiguration =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        self.nixosModules.hadesHardware
        self.nixosModules.coreConfig
        self.nixosModules.programs
        self.nixosModules.niri
      ];

      services.printing.enable = true;

      users.users.serenity = {
        shell = pkgs.fish;
        ignoreShellProgramCheck = true;
        isNormalUser = true;
        description = "";
        extraGroups = [
          "networkmanager"
          "wheel"
          "i2c"
          "audio"
          "video"
          "input"
        ];
        packages = with pkgs; [
          tree
        ];
      };
      programs.firefox.enable = true;

      environment.systemPackages = with pkgs; [
        vim
        wget
        git
        curl
        bat
        xclip
        ddcutil
        unzip
        ripgrep
        tealdeer
        chezmoi
      ];

      system.stateVersion = "24.11";
    };
}
