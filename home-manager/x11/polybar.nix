{ config, pkgs, lib, ...}:

{
  config = lib.mkIf (config.xsession.enable) {
    services.polybar = {
      enable = true;
      package = pkgs.polybar.override {
        alsaSupport = true;
        iwSupport = true;
      };
      config = ~/.dotfile/config/polybar/config.ini;
    };
  };
}
