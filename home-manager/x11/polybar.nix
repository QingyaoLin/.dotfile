{ config, pkgs, lib, ...}:

{
  config = lib.mkIf (config.xsession.enable) {
    home.packages = with pkgs; [
      polybar
    ];
    home.file = {
      ".config/polybar" = {
        recursive = true;
        source = config.lib.file.mkOutOfStoreSymlink ../../config/polybar;
      };
    };
  };
}
