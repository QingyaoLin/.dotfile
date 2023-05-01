{ lib, config, pkgs, ... }:

{
  services.sxhkd = {
    enable = true;
  };
  
  xdg.configFile."sxhkd".source = ../../../config/sxhkd;
  
  systemd.user.services.sxhkd = {
    Unit = {
      Description = "Simple X hotkey daemon";
      Documentation = [ "man:sxhkd" ];
      After = [ "graphical-session.target" ];
      PartOf = [ "bspwm-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.sxhkd}/bin/sxhkd";
    };

    Install = {
      WantedBy = [ "bspwm-session.target" ];
    };
  };
}
