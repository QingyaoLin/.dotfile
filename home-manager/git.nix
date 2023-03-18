{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "2650426778@qq.com";
    userName = "QingyaoLin";
    extraConfig = {
      "credential" = {
        "helper" = "store";
      };
    };
  };
}
