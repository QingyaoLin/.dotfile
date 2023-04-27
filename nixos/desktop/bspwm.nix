{ lib, config, pkgs, ... }:

{
  services.xserver = {
    displayManager.startx.enable = true;
    windowManager.bspwm.enable = true;
  };
}
