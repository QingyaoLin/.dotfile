{ lib, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    unstable.clash-verge
  ];
}
