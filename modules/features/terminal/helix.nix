{ inputs, ... }:

{

  # defines a custom helix module
  flake.nixosModules.helix =

    {
      lib,
      pkgs,
      user-parts,
      ...
    }:

    {

      # editor variables
      environment.variables = {
        EDITOR = "hx";
        VISUAL = "hx";
        SYSTEMD_EDITOR = "hx";
      };

      # helix plugins overlay from flake
      nixpkgs.overlays = [ inputs.helix-plugins.overlays.default ];

      # system level packages for helix editor
      environment.systemPackages = with pkgs; [ helix ];

      # home manager options
      home-manager.users.${user-parts.user.username} =

        {

          # module import for helix plugins home manager module
          imports = [ inputs.helix-plugins.homeManagerModules.default ];

          # alternate user friendly text editor
          programs.micro = {
            enable = true;
          };

          # primary text editor
          programs.helix = {

            # enables helix
            enable = true;

            # cursor settings
            settings.editor.cursor-shape = {
              normal = "underline";
              insert = "bar";
              select = "block";

            };

            # helix plugins
            plugins = with pkgs.helixPlugins; [
              smooth-scroll-hx # allows smoother scrolling
              show-keys-hx # shows keypresses within helix
              scooter-hx # interactive find and replace
              notify-hx # notification popups for helix
            ];

            # lsp settings
            languages = {

              language = [
                {
                  name = "nix";
                  auto-format = true;
                  formatter.command = lib.getExe pkgs.nixfmt;
                }
                {
                  name = "haskell";
                  auto-format = true;
                  formatter.command = lib.getExe pkgs.stylish-haskell;
                }
                {
                  name = "rust";
                  auto-format = true;
                  formatter.command = lib.getExe pkgs.rustfmt;
                }
                {
                  name = "python";
                  auto-format = true;
                  formatter.command = lib.getExe pkgs.black;
                }
                {
                  name = "markdown";
                }
                {
                  name = "fish";
                }
              ];

            };
          };
        };
    };
}
