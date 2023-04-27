# This setups a sound service.

{ lib, config, pkgs, ... }:

{
  # Pulseaudio config
  security.rtkit.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };
}
