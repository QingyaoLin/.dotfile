{ config, pkgs, lib, ...}:

{
  config = lib.mkIf (config.xsession.enable) {
    services.polybar = {
      enable = true;
      package = pkgs.polybar.override {
        pulseSupport = true;
        iwSupport = true;
      };
      script = "polybar -q mybar &";
    };

    # home.packages = with pkgs; [
    #  polybar
    # ];

    home.file = {
      ".config/polybar" = {
        recursive = true;
        source = config.lib.file.mkOutOfStoreSymlink ../../config/polybar;
      };
    };
  };
}
