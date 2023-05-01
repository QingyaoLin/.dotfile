{ lib, config, pkgs, ... }:

let
  timeout = 600; # 10分钟
  cycle = 600;
  extraOptions = [
    "--ignore-sleep"
  ];
  lockCmd = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
in
{
  home.packages = with pkgs; [
    i3lock-fancy
    xss-lock
    xorg.xset
  ];

  systemd.user.services.xss-lock = {
    Unit = {
      Description = "xss-lock, session locker service";
      After = [ "graphical-session.target" ];
      PartOf = [ "bspwm-session.target" ];
    };

    Install = {
      WantedBy = [ "bspwm-session.target" ];
    };

    Service = {
      ExecStartPre = "${pkgs.xorg.xset}/bin/xset s ${toString timeout} ${toString cycle}";
      ExecStart = lib.concatStringsSep " " ([
          "${pkgs.xss-lock}/bin/xss-lock"
          "-s \${XDG_SESSION_ID}"
        ]
          ++ extraOptions
          ++ [ "-- ${lockCmd}" ]
        );
    };
  };
}
