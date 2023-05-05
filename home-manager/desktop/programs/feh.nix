{ lib, config, pkgs, ... }:


{
  programs.feh.enable = true;
  
  systemd.user.timers.feh = {
    Unit = {
      Description = "Runs wallpaperscript every 10 minutes";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Timer = {
      OnActiveSec = "0s";
      OnUnitActiveSec = "10s";
    };
    Install = {
      WantedBy = [ "bspwm-session.target" ];
    };
  };

  systemd.user.services.feh = {
    Unit = {
      Description = "Change the wallapaper";
    };
    Service = {
      Environment = "DISPLAY=:0";
      ExecStart = "${pkgs.feh}/bin/feh --no-fehbg --bg-fill --randomize /home/lqy/.wallpaper";
    };
  };
}
