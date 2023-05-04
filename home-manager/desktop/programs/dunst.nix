# https://github.com/dunst-project/dunst/blob/master/docs/dunst.5.pod

{ lib, config, pkgs, ... }:

let
  inherit (config.colorScheme) colors;
in
{
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
      size = "32x32";
    };
    settings = {
      global = {
        follow = "mouse";
        width = 400;
        height = 300;
        origin = "top-right";
        offset = "0x32";
        frame_color = "#${colors.base0D}";
        frame_width = 1;
        gap_size = 3;
        font = "JetBrainsMono Nerd Font 10";
        format = "<span size='x-large' weight='bold'>%s</span>\\n%b";
        stack_duplicates = false;
        icon_path = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
        icon_theme = "Papirus-Dark";
        enable_recursive_icon_lookup = false;
        alignment = "center";
        markup = "full";
        corner_radius = 5;
      };
      urgency_low = {
        timeout = 3;
        background = "#${colors.base00}";
        foreground = "#${colors.base05}";
      };
      urgency_normal = {
        timeout = 6;
        background = "#${colors.base00}";
        foreground = "#${colors.base05}";
      };
      urgency_critical = {
        timeout = 0;
        background = "#${colors.base00}";
        foreground = "#${colors.base05}";
        frame_color = "#${colors.base09}";
      };
    };
  };
  
  # 追加的部分服务
  systemd.user.services.dunst = {
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
