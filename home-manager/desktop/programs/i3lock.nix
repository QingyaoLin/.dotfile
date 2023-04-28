{ lib, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    i3lock-fancy
  ];
}
