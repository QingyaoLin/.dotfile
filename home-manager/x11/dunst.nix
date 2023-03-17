{ config, pkgs, lib, ... }:

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
        width = 256;
        height = 222;
        origin = "top-right";
        offset = "0x32";
        progress_bar_height = 10;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        progress_bar_frame_width = 1;
        transparency = 3;
        horizontal_padding = 8;
        frame_width = 2;
        frame_color = "#89B4FA";
        gap_size = 4;
        separator_color = "frame";
        font = "JetBrainsMono Nerd Font 14";
        format = "<b>%s</b>\n%b";
        show_age_threshold = 60;
        icon_position = "left";
        min_icon_size = 48;
        max_icon_size = 80;
        enable_recursive_icon_lookup = true;
        icon_theme = "Papirus-Dark";
        sticky_history = false;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
        alignment = "center";
        markup = "full";
        always_run_script = true;
        corner_radius = 10;
      };
      urgency_low = {
        timeout = 3;
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        highlight = "#f48ee8";
      };
      urgency_normal = {
        timeout = 6;
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        highlight = "#f48ee8";
      };
      urgency_critical = {
        timeout = 0;
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        highlight = "#f48ee8";
        frame_color = "#FAB387";
      };
    };
  };
}
