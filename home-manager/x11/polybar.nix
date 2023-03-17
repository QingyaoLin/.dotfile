{ config, pkgs, lib, ...}:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      pulseSupport = true;
      iwSupport = true;
    };
    script = "polybar -q mybar &";
  };

  home.file = {
    ".config/polybar" = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink ../../config/polybar;
    };
  };
}
