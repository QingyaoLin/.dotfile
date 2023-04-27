{ lib, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    light
    brightnessctl
  ];
}
