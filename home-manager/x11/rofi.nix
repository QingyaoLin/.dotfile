{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    rofi
  ];

  home.file = {
    ".config/rofi" = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink ../../config/rofi;
    };
  };
}
