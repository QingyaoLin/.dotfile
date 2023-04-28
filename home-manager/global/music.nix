{ lib, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    unstable.yesplaymusic
  ];
};
