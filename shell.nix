# wiki: https://nixos.wiki/wiki/Development_environment_with_nix-shell
# Shell for bootstrapping flake-enabled nix and home-manager
# You can enter it through 'nix develop' or (legacy) 'nix-shell'

{ pkgs ? (import ./nixpkgs.nix) { } }:

{
  default = pkgs.mkShell {
    # Enable experimental features without having to specify the argument
    NIX_CONFIG = "experimental-features = nix-command flakes";
    shellHook =
    ''
      clear
      echo "
     ______   _           _                 
    |  ____| | |         | |                
    | |__    | |   __ _  | | __   ___   ___ 
    |  __|   | |  / _\` | | |/ /  / _ \ / __|
    | |      | | | (_| | |   <  |  __/ \\__ \\
    |_|      |_|  \__,_| |_|\_\  \___| |___/
          "
       export PS1="[\e[0;34m(Flakes)\$\e[m:\w]\$ "
    '';
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git
    ];
  };
}
