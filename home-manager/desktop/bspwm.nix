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
    xss-lock
  ];

  xsession.windowManager.bspwm = {
    enable = true;
    startupPrograms = [
      "sxhkd"
      "numlockx on"
      "polybar -q mybar"
      "xss-lock --ignore-sleep -- i3lock -i ~/.wallpaper/01.png"
      "ibus-daemon"
      "picom --experimental-backends"
      "feh --bg-fill --randomize ~/.wallpaper/*"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
    ];
    extraConfigEarly =
      ''
        GTK_IM_MODULE=ibus
        QT_IM_MODULE=ibus
        XMODIFIERS=@im=ibus
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
}
