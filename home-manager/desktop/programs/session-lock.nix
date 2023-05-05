{ lib, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    i3lock-fancy
  ];

  services.screen-locker = {
    enable = true;
    lockCmd = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
    inactiveInterval = 10; # 超时 10分钟
    xss-lock = {
      screensaverCycle = 600; # 设置 cycle
      extraOptions = [
        "--ignore-sleep"
      ];
    };
  };

  systemd.user.services.xss-lock = {
    Service = {
      ExecStartPre = " systemctl --user import-environment XDG_SESSION_ID";
    };
    Install = lib.mkForce ({
      WantedBy = [ "bspwm-session.target" ];
    });
  };
}
