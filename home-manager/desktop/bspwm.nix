{ lib, config, pkgs, ... }:

let
  inherit (config.colorScheme) colors;
in
{
  imports = [
    ./programs/feh.nix
    ./programs/rofi.nix
    ./programs/sxhkd.nix
    ./programs/dunst.nix
    ./programs/picom.nix
    ./programs/startx.nix
    ./programs/i3lock.nix
    ./programs/polybar.nix
  ];

  home.packages = with pkgs; [
    polkit_gnome
    numlockx
  ];

  xsession.windowManager.bspwm = {
    enable = true;
    startupPrograms = [
      "numlockx on"
      "fcitx5"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
    ];
    extraConfigEarly =
      ''
        systemctl --user start bspwm-session.target
        bspc monitor -d I II III IV V
      '';
    settings = {
      border_width = 2;
      top_padding = 26;
      window_gap = 12;
      split_ratio = 0.50;
      automatic_scheme = "spiral";
      normal_border_color = "#${colors.base09}";
      active_border_color = "#${colors.base0E}";
      focused_border_color = "#${colors.base0F}";
      presel_feedback_color = "#${colors.base05}";
    };
    rules = {
      "Microsoft-edge" = {
        desktop = "^2";
      };
      "rofi" = {
        state = "floating";
        center = true;
      };
      "FloatAlacritty" = {
        state = "floating";
        center = true;
      };
      "TelegramDesktop" = {
        state = "floating";
        center = true;
      };
      "Dunst" = {
        layer = "above";
      };
    };
  };

  # 启动 bspwm targets 步骤:
  #   graphical-session-pre.target ->
  #   graphical-session.target     ->
  #   bspwm-session.target
  systemd.user.targets.bspwm-session = {
    Unit = {
      Description = "bspwm session";
      # man systemd.special
      Documentation = "man:systemd.special(7)";
      # bspwm-session.target 激活时也激活 graphical-session.target
      BindsTo = [ "graphical-session.target" ];
      # 要求先启动 graphical-session-pre.target 再启动 bspwm-session.target
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };
}
