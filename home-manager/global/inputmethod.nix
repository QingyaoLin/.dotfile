{ lib, config, pkgs, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-chinese-addons
      fcitx5-table-extra
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-zhwiki
    ];
  };
}
