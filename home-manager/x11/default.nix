{ config, pkgs, lib, ... }:

{
  imports = [
    ./picom.nix
    ./bspwm.nix
    ./sxhkd.nix
  ];

  xsession.enable = true;
  xsession.numlock.enable = true;
}
