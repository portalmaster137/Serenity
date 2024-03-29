{
  extensions = rec {
    base = [
      # "espresso@coadmunkee.github.com"
      "gsconnect@andyholmes.github.io"
      "rounded-window-corners@yilozt"
      "caffeine@patapon.info"
      # "appindicatorsupport@rgcjonas.gmail.com"
      # "aztaskbar@aztaskbar.gitlab.com"
      # "pano@elhan.io"
    ];
    desktop = base ++ [
      "Current_screen_only_for_Alternate_Tab@bourcereau.fr"
      "advanced-alt-tab@G-dH.github.com"
    ];
    laptop = base;
  };
  pinnedApps = rec {
    base = [
    ];
    base-end = [
    ];
    desktop = base ++ [
    ] ++ base-end;
    laptop = base ++ [
    ] ++ base-end;
  };
  extraDconf = {
    desktop = {
     # "org/gnome/shell/extensions/advanced-alt-tab-window-switcher" = {
      # switcher-popup-position = 2;
     # };
    };
  };
}
