{ lib, config, pkgs, ... }:

{
  services.sxhkd = {
    enable = true;
  };
  xdg.configFile."sxhkd".source = ../../../config/sxhkd;
}
