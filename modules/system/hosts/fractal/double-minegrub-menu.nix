{ ... }:
{
  flake.nixosModules.double-minegrub-menu =
    { config, lib, pkgs, ... }:
    let
      cfg = config.boot.loader.grub.double-minegrub-menu;

      backgroundArg =
        if cfg.main_menu_background == "random" then ""
        else "backgrounds/${cfg.main_menu_background}";
      splashTextArg = if cfg.splash_text == "random" then "" else cfg.splash_text;

      minegrubTheme = pkgs.fetchFromGitHub {
        owner = "Lxtharia";
        repo = "minegrub-theme";
        rev = "v3.1.0";
        # Correct source hash for v3.1.0 (the upstream module's hash is stale).
        hash = "sha256-+7b0jXVVAyIAtYKeZZONZv2qzfESjwITSng1TVjyAfQ=";
      };

      pythonEnv = pkgs.python313.withPackages (pythonPackages: [ pythonPackages.pillow ]);
      fakeFastfetch = pkgs.writeShellScriptBin "fastfetch" ''
        package_count=$(ls -d /nix/var/nix/profiles/system/sw/bin/* 2>/dev/null | wc -l)
        echo "Packages: $package_count (nix)"
      '';

      minegrubUpdate = pkgs.writeShellScriptBin "minegrub-update" ''
        cd /boot/grub/themes/minegrub
        export PATH="${fakeFastfetch}/bin:${pythonEnv}/bin:$PATH"
        exec ${pythonEnv}/bin/python3 update_theme.py \
          ${lib.escapeShellArg backgroundArg} \
          ${lib.escapeShellArg splashTextArg}
      '';

      themeDir = "${minegrubTheme}/minegrub";
      backgroundDir = "${minegrubTheme}/background_options";
      themeFiles = builtins.listToAttrs (map
        (file: {
          name = builtins.unsafeDiscardStringContext
            ("grub/themes/minegrub" + lib.removePrefix (toString themeDir) (toString file));
          value = file;
        })
        (lib.filesystem.listFilesRecursive themeDir));
      backgroundFiles = builtins.listToAttrs (map
        (file: {
          name = builtins.unsafeDiscardStringContext
            ("grub/themes/minegrub/backgrounds" + lib.removePrefix (toString backgroundDir) (toString file));
          value = file;
        })
        (lib.filesystem.listFilesRecursive backgroundDir));
    in
    {
      options.boot.loader.grub.double-minegrub-menu = {
        enable = lib.mkEnableOption "the Minegrub double menu";
        main_menu_background = lib.mkOption {
          type = lib.types.str;
          default = "random";
          description = "Main menu background asset, or random.";
        };
        splash_text = lib.mkOption {
          type = lib.types.str;
          default = "random";
          description = "Main menu splash text, or random.";
        };
        world_selection_custom_icons = lib.mkOption {
          type = lib.types.listOf (lib.types.attrsOf lib.types.anything);
          default = [ ];
          description = "Custom icons for the world-selection menu.";
        };
        world_selection_background_scaled = lib.mkOption {
          type = lib.types.str;
          default = "1920x1080";
          description = "World-selection background resolution.";
        };
      };

      config = lib.mkIf cfg.enable {
        boot.loader.grub = {
          minegrub-world-sel = {
            enable = true;
            customIcons = cfg.world_selection_custom_icons;
            background = "assets/background-scaled/background-${cfg.world_selection_background_scaled}.png";
          };
          extraFiles = {
            "grub/mainmenu.cfg" = ./mainmenu.cfg;
          } // themeFiles // backgroundFiles;
          extraConfig = ''
            if [ -z "$chosen" ] ; then
              if [ "''${config_file}" ] ; then
                configfile $prefix/$config_file
              fi
            fi
          '';
        };

        environment.systemPackages = [ minegrubUpdate ];
        systemd.services.minegrub-update = {
          description = "Update Minegrub splash text and background";
          after = [ "local-fs.target" ];
          wantedBy = [ "multi-user.target" ];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${minegrubUpdate}/bin/minegrub-update";
            User = "root";
          };
        };

        # Set the GRUB environment variable needed to select the main menu.
        system.activationScripts.minegrub-menu = {
          deps = [ "specialfs" ];
          text = ''
            ${pkgs.grub2}/bin/grub-editenv - set config_file=mainmenu.cfg
          '';
        };
      };
    };
}
