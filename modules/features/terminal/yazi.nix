{ ... }:

{

  # yazi module declaration
  flake.nixosModules.yazi =

    { user-parts, ... }:

    {

      # home manager options
      home-manager.users.${user-parts.user.username} = {

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
