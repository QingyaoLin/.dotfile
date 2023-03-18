{ config, lib, pkgs, ... }:

{
  xsession.windowManager.bspwm = {
    enable = true;
    alwaysResetDesktops = true;
    startupPrograms = [
      "sxhdk"
    ];
    # xrandr
    monitors = {
      eDP-1 = [
        "I"
	"II"
	"III"
	"IV"
	"V"
      ];
    };
    rules = {
      "Microsoft-edge" = {
        desktop = "^2";
      };
    };
    settings = {
      border_width = 2;
      top_padding = 26;
      window_gap = 12;
      split_ratio = 0.50;
      automatic_scheme = "spiral";
      normal_border_color = "#fab387";
      active_border_color = "#cba6f7";
      focused_border_color = "#f5c2e7";
      presel_feedback_color = "#6c7086";
    };
    extraConfigEarly =
    ''
      systemctl --user start bspwm-session.target 
      systemctl --user start polybar.service
      systemctl --user start dunst.service
    '';
  };
  systemd.user.targets.bspwm-session = {
    Unit = {
      Description = "bspwm session";
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" "xdg-desktop-autostart.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };
}
