# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }:

{
  # 禁用 home-manager 的模块
  # https://github.com/nix-community/home-manager/issues/602
  # https://nixos.org/manual/nixos/stable/#sec-replace-modules
  disabledModules = [];

  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
  ] ++ [
    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default
  ] ++ [
    # You can also split up your configuration and import pieces of it here:
    ./global/git.nix
    ./global/gtk.nix
    ./global/vim.nix
    ./global/music.nix
    ./global/clash.nix
    ./global/shell.nix
    ./global/colors.nix
    ./global/neovim.nix
    ./global/starship.nix
    ./global/neofetch.nix
    ./global/terminal.nix
    ./global/wallpaper.nix
    ./global/backlight.nix
    ./global/inputmethod.nix
    ./global/resource-monitor.nix
  ] ++ [
    ./desktop/bspwm.nix
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
      inputs.picom.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # Set your username
  home = {
    username = "lqy";
    homeDirectory = "/home/lqy";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    microsoft-edge
    unstable.qq
    pavucontrol
    gnome.gucharmap
    tdesktop
    papirus-icon-theme
    wget
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "Hack"
        "JetBrainsMono"
      ];
    })
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
