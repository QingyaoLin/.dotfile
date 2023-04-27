{ lib, config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
  };
  xdg.configFile."starship.toml".source = ../../config/starship/starship.toml;

}
