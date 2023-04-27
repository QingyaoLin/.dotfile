# This setups a localization.

{ lib, config, pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
    };
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "Hack"
          "JetBrainsMono"
        ];
      })
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji # Color and Black-and-White emoji fonts
      twemoji-color-font # Twitter emoji
    ];
    fontconfig.defaultFonts = {
      serif = [
        "Noto Sans CJK SC"
        "Noto Sans"
      ];
      sansSerif = [
        "Noto Sans CJK SC"
        "Noto Sans"
      ];
      monospace = [
        "Noto Sans Mono CJK SC"
        "Symbols Nerd Font"
      ];
      emoji = [
        "Twemoji"
      ];
    };
  };
}
