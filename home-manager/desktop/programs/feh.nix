{ lib, config, pkgs, ... }:

let
  wallpaper = "/home/lqy/.wallpaper";
  extraArgs = [
    "no-fehbg"
  ];
in
{
  programs.feh.enable = true;

  systemd.user.timers.feh = {
    Unit = {
      Description = "Run every 1h feh services";
      Documentation = [ "man:systemd.timers(5)" ];
      PartOf = [ "graphical-session.target" ];
    };

    Timer = {
      OnActiveSec = "1s";
      OnCalendar = "*:*:30";
    };

    Install = {
      WantedBy = [ "bspwm-session.target" ];
    };
  };

  systemd.user.services.feh = {
    Unit = {
      Description = "feh desktop wallpaper";
      Documentation = [ "man:feh" ];
    };

    Service = {
      ExecStart = lib.concatStringsSep " " (
        [
          "${pkgs.feh}/bin/feh"
          "--bg-fill --randomize ${wallpaper}"
        ] ++ extraArgs
      );
    };
  };
}
