{ lib, config, pkgs, ... }:

let
  inherit (config.colorScheme) colors;
in
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      pulseSupport = true;
    };
    script = "polybar -q mybar";
    settings = {
      "bar/mybar" = {
        bottom = false;
        fixed-center = true;
        width = "100%";
        height = "24pt";
        offset-x = 0;
        offset-y = 0;
        background = "#${colors.base00}";
        foreground = "#${colors.base05}";
        padding-left = 1;
        padding-right = 1;
        module-margin = "8px";
        font-0 = "JetBrainsMono Nerd Font:size=14:weight=bold;4";
        modules-left = "log bspwm temperature xwindow";
        modules-center = "date";
        modules-right = "backlight memory cpu network pulseaudio battery";
        tray-position = "left";
        tray-detached = false;
        tray-background = "\${root.background}";
        tray-foreground = "\${root.foreground}";
        tray-offset-x = 0;
        tray-offset-y = 0;
        tray-scale = 1.0;
        wm-restack = "bspwm";
        dpi = 0;
        enable-ipc = true;
        cursor-click = "default";
        cursor-scroll = "default";
      };
      "global/wm" = {
        margin-bottom = 0;
        margin-top = 0;
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        interval = 2;
        label-volume = "%percentage%%";
        label-muted = "ﱝ Muted";
        format-muted-foreground = "#${colors.base0A}";
        format-volume = "<ramp-volume> <label-volume>";
        format-volume-foreground = "#${colors.base08}";
        ramp-volume = [ "" "" "" "" ];
        click-right = "pavucontrol";
      };
      "module/bspwm" = {
        type = "internal/bspwm";
        occupied-scroll = true;
        label-focused = "%name%";
        label-occupied = "%name%";
        label-urgent = "%name%";
        label-empty = "%name%";
        label-focused-padding = "8px";
        label-occupied-padding = "8px";
        label-urgent-padding = "8px";
        label-empty-padding = "8px";
        label-focused-background = "#${colors.base0C}";
        label-focused-foreground = "#${colors.base01}";
      };
      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:20:...%";
        format-foreground = "#${colors.base09}";
      };
      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%I:%M %p";
        date-alt = "%I:%M %p %A %B %d";
        label = "%date%";
        label-foreground = "#${colors.base05}";
      };
      "module/backlight" = {
        type = "internal/backlight";
        card = "intel_backlight";
        use-actual-brightness = true;
        enable-scroll = true;
        label = "%percentage%%";
        ramp = [ "" "" "" "" ];
        format = "<ramp> <label>";
        format-foreground = "#${colors.base0E}";
      };
      "module/temperature" = {
        type = "internal/temperature";
        base-temperature = 20;
        warn-temperature = 60;
        label = "%temperature-c%";
        label-warn = "%temperature-c%";
        format = "<ramp> <label>";
        format-warn = "<ramp> <label-warn>";
        format-foreground = "#${colors.base07}";
        format-warn-foreground = "#${colors.base08}";
        ramp = [ "" "" "" "" ];
      };
      "module/memory" = {
        type = "internal/memory";
        label = "﬙ %percentage_used%%";
        label-warn = "﬙ %percentage_used%%";
        format = "<label>";
        format-foreground = "#${colors.base0D}";
        format-warn = "<label-warn>";
        format-warn-foreground = "#${colors.base08}";
      };
      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        warn-percentage = 90;
        label = " %percentage%%";
        label-warn = " %percentage%%";
        format = "<label>";
        format-foreground = "#${colors.base0F}";
        format-warn = "<label-warn>";
        format-warn-foreground = "#${colors.base08}";
      };
      "module/network" = {
        type = "internal/network";
        interface = "wlp2s0";
        interface-type = "wireless";
        interval = 2;
        label-connected = "說 %essid% %netspeed%";
        label-connected-foreground = "#${colors.base0B}";
        label-disconnected = "⚠ Disconnected";
        label-disconnected-foreground = "#${colors.base0B}";
        format-connected = "<label-connected>";
        format-disconnected = "<label-disconnected>";
      };
      "module/battery" = {
        type = "internal/battery";
        full-at = 99;
        low-at = 20;
        battery = "BAT1";
        adapter = "ACAD";
        label-charging = "%percentage%%";
        label-discharging = "%percentage%%";
        label-full = "%percentage%%";
        label-low = "%percentage%%";
        format-charging = "<animation-charging> <label-charging>";
        format-discharging = "<ramp-capacity> <label-discharging>";
        format-full = "  <label-full>";
        format-low = "<animation-low> <label-low>";
        format-charging-foreground = "#${colors.base05}";
        format-discharging-foreground = "#${colors.base05}";
        format-full-foreground = "#${colors.base05}";
        format-low-foreground = "#${colors.base05}";
        animation-charging = [ " " " " " " " " " " ];
        ramp-capacity = [ " " " " " " " " ];
        animation-low = [ "! " " " ];
        animation-low-framerate = 200;
      };
      "module/log" = {
        type = "custom/text";
        content = "";
        content-foreground = "#${colors.base0D}";
      };
      "settings" = {
        screenchange-reload = true;
        pseudo-transparency = false;
      };
    };
  };
}
