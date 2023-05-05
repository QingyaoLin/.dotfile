{ lib, config, pkgs, ... }:

let
  inherit (config.colorScheme) kind;
in
{
  gtk.enable = true;

  gtk.cursorTheme = {
    package = pkgs.catppuccin-cursors.macchiatoPink;
    # gtk-cursor-theme-name: cursor 目录中 index.theme 中的 [icon theme] -> Name
    name = "Catppuccin-Macchiato-Pink";
    size = 32;
  };

  gtk.theme = {
    package = pkgs.unstable.catppuccin-gtk.override {
      accents = [ "pink" ];
      size = "compact";
      tweaks = [ "rimless" "black" ];
      variant = "macchiato";
    };
    # gtk-theme-name: 目录的名称
    name = "Catppuccin-Macchiato-Compact-Pink-Dark";
  };

  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    # gtk-icon-theme-name: 目录的名称
    name =
      if kind == "dark" then
        "Papirus-Dark"
      else
        "Papirus-light";
  };


  gtk.font = {
    name = "JetBrainsMono Nerd Font";
    size = 12;
  };

  gtk.gtk2 = {
    configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  gtk.gtk3 = { };

  gtk.gtk4 = { };

  home.file.".local/share/icons/Catppuccin-Macchiato-Pink-Cursors" = {
    source = "${pkgs.catppuccin-cursors.macchiatoPink}/share/icons/Catppuccin-Macchiato-Pink-Cursors";
  };
  home.file.".local/share/themes" = {
    source = "${pkgs.unstable.catppuccin-gtk}/share/themes";
  };
  home.file.".local/share/icons/Papirus" = {
    source = "${pkgs.papirus-icon-theme}/share/icons/Papirus";
  };
  home.file.".local/share/icons/Papirus-Dark" = {
    source = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
  };
  home.file.".local/share/icons/Papirus-Light" = {
    source = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Light";
  };
}
