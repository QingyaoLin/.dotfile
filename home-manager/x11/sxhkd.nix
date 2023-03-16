{ config, pkgs, lib, ... }:

{
  config = lib.mkIf (config.xsession.enable) {
    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "alacritty";
        "alt + @space" = "rofi -show drun";
        "super + Escape" =
        ''
          pkill -USR1 -x sxhkd; \
          bspc wm -r; \
          sleep 1; \
          dunstify "Reload all configuration." -u low
        '';
        "alt + @slash" = "~/.config/sxhkd/sxhkd-help.sh";
        # "Super_L; @Super_L" = "eww";
        "super + o ; {b,t}" = "{microsoft-edge,alacritty --class FloatAlacritty}";
        "super + alt + q" = "bspc quit";
        "super + {_, shift + }w" = "bspc node -{c, k}";
        "alt + {_,shift + }f" = "bspc node -t {floating,fullscreen} || bspc node -t tiled";
        "alt + m" = "bspc desktop -l next";
        "alt + h" = "~/.config/sxhkd/hidden.sh";
        "super + {h,j,k,l}" = "bspc node -f {west,south,north,east}";
        "alt + {_,shift + }Tab" = "bspc desktop -f {next,prev}.local";
        "super + {grave,Tab}" = "bspc {node,desktop} -f last";
        "super + {1-5}" = "bspc desktop -f '^{1-5}'";
        "super + g" = "bspc node -s biggest.window";
        "alt + s : {h,j,k,l}" = "bspc node -s {west,south,north,east}";
        "super + shift + {1-5}" = "bspc node -d '^{1-5}' --follow";
        "alt + p : {h,j,k,l}" = "bspc node -p {west,south,north,east}";
        "alt + shift + space" = "bspc node -p cancel";
        "super + r : {h,j,k,l}" =
        '' 
          n=10; \
          { d1=left;   d2=right;  dx=-$n; dy=0;   \
          , d1=bottom; d2=top;    dx=0;   dy=$n;  \
          , d1=top;    d2=bottom; dx=0;   dy=-$n; \
          , d1=right;  d2=left;   dx=$n;  dy=0;   \
          } \
          bspc node --resize $d1 $dx $dy || bspc node --resize $d2 $dx $dy
        '';
        "super + shift + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
      };
    };
  };
}
