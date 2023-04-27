{ lib, config, pkgs, ... }:

{
  home.file.".Xresources" = {
    text =
      ''
        Xcursor.theme: Catppuccin-Macchiato-Pink
        Xcursor.size: 32
      '';
  };

  home.file.".xinitrc" = {
    text =
      ''
        xrandr

        if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
                eval $(dbus-launch --exit-with-session --sh-syntax)
        fi

        systemctl --user import-environment DISPLAY XAUTHORITY

        if command -v dbus-update-activation-environment >/dev/null 2>&1; then
                dbus-update-activation-environment DISPLAY XAUTHORITY
        fi

        # 设置 session lock 超时的时间
        xset s 600
        # 合并 .Xresources 配置,设置鼠标主题
        xrdb -merge ~/.Xresources
        xsetroot -cursor_name left_ptr

        exec bspwm
      '';
    executable = true;
  };
}
