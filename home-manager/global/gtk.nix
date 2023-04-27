{ lib, config, pkgs, ... }:

{
  gtk.enable = true;

  gtk.cursorTheme = {
    package = pkgs.catppuccin-cursors.macchiatoPink;
    name = "Catppuccin-Macchiato-Pink-Cursors";
    size = 32;
  };
  home.file.".local/share/icons/default" = {
    source = "${pkgs.catppuccin-cursors.macchiatoPink}/share/icons/Catppuccin-Macchiato-Pink-Cursors";
  };

  gtk.theme = {
    package = pkgs.unstable.catppuccin-gtk.override {
      accents = [ "pink" ];
      size = "compact";
      tweaks = [ "rimless" "black" ];
      variant = "macchiato";
    };
    name = "Catppuccin-Macchiato-Compact-Pink-Dark";
  };

  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus-Dark";
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
}
