{ config, pkgs, lib, ...}:

{
  home.file = {
    ".config/script" = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink ./script;
    };
  };
}