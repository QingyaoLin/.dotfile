# This setups a SSH server. Very important if you're setting up a headless system.

{ lib, config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    permitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    # passwordAuthentication = false;
  };
}
