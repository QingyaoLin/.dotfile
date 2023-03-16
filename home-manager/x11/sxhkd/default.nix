{ config, pkgs, lib, ... }:

{
  config = lib.mkIf (config.xsession.enable) {
    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "alacritty";
        "alt + @space" = "rofi -show drun";
        # "Super_L; @Super_L" = "eww";
        "super + o ; {b,t}" = "{microsoft-edge,alacritty --class FloatAlacritty}";
        "super + alt + q" = "bspc quit";
        "super + {_, shift + }w" = "bspc node -{c, k}";
        "alt + {_,shift + }f" = "bspc node -t {floating,fullscreen} || bspc node -t tiled";
        "alt + m" = "bspc desktop -l next";
        "super + {h,j,k,l}" = "bspc node -f {west,south,north,east}";
        "alt + {_,shift + }Tab" = "bspc desktop -f {next,prev}.local";
        "super + {grave,Tab}" = "bspc {node,desktop} -f last";
        "super + {1-5}" = "bspc desktop -f '^{1-5}'";
        "super + g" = "bspc node -s biggest.window";
        "alt + s : {h,j,k,l}" = "bspc node -s {west,south,north,east}";
        "super + shift + {1-5}" = "bspc node -d '^{1-5}' --follow";
        "alt + p : {h,j,k,l}" = "bspc node -p {west,south,north,east}";
        "alt + shift + space" = "bspc node -p cancel";
        "super + shift + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
      };
      extraConfig =
      ''
super + r : {h,j,k,l}
  n=10; \
  { d1=left;   d2=right;  dx=-$n; dy=0; \
  , d1=bottom; d2=top;    dx=0;   dy=$n; \
  , d1=top;    d2=bottom; dx=0;   dy=-$n; \
  , d1=right;  d2=left;   dx=$n;  dy=0; \
  } \
  bspc node --resize $d1 $dx $dy || bspc node --resize $d2 $dx $dy

super + Escape
  pkill -USR1 -x sxhkd; \
  bspc wm -r; \
  sleep 1; \
  dunstify "Reload all configuration." -u low

alt + h
  ~/.config/sxhkd/script/hidden.sh
     
alt + @slash
  ~/.config/sxhkd/script/sxhkd-help.sh
      '';
    };

    home.file = {
      ".config/sxhkd/script" = {
        recursive = true;
	source = config.lib.file.mkOutOfStoreSymlink ./script;
      };
    };
  };
}
