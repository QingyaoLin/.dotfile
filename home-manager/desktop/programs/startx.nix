{ lib, config, pkgs, ... }:

{
  home.file.".Xresources" = {
    text =
      ''
        Xcursor.theme: Catppuccin-Macchiato-Pink-Cursors
        Xcursor.size: 32
      '';
  };

  home.file.".xinitrc" = {
    text =
      ''
        if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
                eval $(dbus-launch --exit-with-session --sh-syntax)
        fi

        systemctl --user import-environment DISPLAY XAUTHORITY XDG_SESSION_ID

        if command -v dbus-update-activation-environment >/dev/null 2>&1; then
                dbus-update-activation-environment DISPLAY XAUTHORITY XDG_SESSION_ID
        fi

        # 合并 .Xresources 配置,设置鼠标主题
        xrdb -merge ~/.Xresources
        xsetroot -cursor_name left_ptr

        exec bspwm
      '';
    executable = true;
  };
}
