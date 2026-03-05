{ ... }:

{
  imports = [

    ./git.nix # Version control
    ./yazi.nix # File browser
    ./fish.nix # Shell prompt
    ./btop.nix # Task manager
    ./kitty.nix # Catgirl terminal

    #./fetch # CHOOSE FETCH PROVIDER
    #./neofetch.nix # OG fetch
    ./fastfetch.nix # New fetch

    ./nvim # Neovim config, stolen
  ];
}
