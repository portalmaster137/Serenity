{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell
{

  nativeBuildInputs = with pkgs; [
    python3
    pipx
  ];

   #packages = with pkgs; [
     #python3
     #pipx
   #];

  shellHook = ''
    echo "Welcome !"
    echo "To SerenityOS-dev."
  '';

}
