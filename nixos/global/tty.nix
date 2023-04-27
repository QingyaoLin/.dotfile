# This setups a tty.

{ lib, config, pkgs, ... }:

{
  # Setting TTY
  console = {
    # Enable setting virtual console options as early as possible (in initrd).
    earlySetup = true;
    font = "ter-v32n";
    keyMap = "us";
    packages = with pkgs; [ terminus_font ];
  };
  services.getty.autologinUser = "lqy";
}
