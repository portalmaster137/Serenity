{ self, inputs, ... }:

{

  # yazi module declaration
  flake.nixosModules.yazi =

    { ... }:

    {

      # for home manager functionality
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      # home manager options
      home-manager.users.serenity = {

        # yazi settings
        programs = {

          yazi = {

            # enables yazi
            enable = true;

            # shell integration
            shellWrapperName = "y";
            enableFishIntegration = true;

            # yazi settings
            settings = {
              log.enabled = false;
              mgr = {
                show_hidden = true;
                linemode = "none";
                sort_by = "mtime";
                sort_reverse = false;
                sort_dir_first = true;
              };
            };

          };

        };

      };

    };

}
