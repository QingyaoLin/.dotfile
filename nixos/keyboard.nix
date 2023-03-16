{ config, ... }:

{
  # Switch CapsLock and Esc
  # https://wiki.archlinux.org/title/Map_scancodes_to_keycodes
  # https://wiki.archlinux.org/title/Keyboard_input#Identifying_scancodes
  # https://github.com/NixOS/nixpkgs/issues/127443
  # help: man hwdb
  services.udev.extraHwdb =
  ''
    evdev:input:b0003v0416pB23C*
     KEYBOARD_KEY_70039=esc
     KEYBOARD_KEY_70029=capslock

    evdev:atkbd:dmi:bvn*:bvr*:bd*:svn*:pn*:pvr*
     KEYBOARD_KEY_3a=esc
     KEYBOARD_KEY_01=capslock
  '';
}
