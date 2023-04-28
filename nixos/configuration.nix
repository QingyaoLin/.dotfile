# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, lib, config, pkgs, ... }:

{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example
  ] ++ [
    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd
  ] ++ [
    # You can also split up your configuration and import pieces of it here:
    ./desktop/bspwm.nix

    ./global/tty.nix
    ./global/users.nix
    ./global/sound.nix
    ./global/network.nix
    ./global/openssh.nix
    ./global/backlight.nix
    ./global/boot-loader.nix
    ./global/localization.nix
    ./global/swap-keyboard.nix
    ./global/nvidia-intel-drivers.nix
  ] ++ [
    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Enable unfree packages
      allowUnfree = true;
      # Support pulseaudio
      pulseaudio = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  # Add the rest of your current configuration:

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable xserver
  services.xserver = {
    enable = true;
    layout = "us";
    logFile = "/tmp/Xorg.0.log";
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };

  # dbus config
  services.dbus.packages = [ pkgs.gcr ];

  # Polkit config
  security.polkit.enable = true;
  
  programs.dconf.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
