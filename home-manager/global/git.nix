{ lib, config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "2650426778@qq.com";
    userName = "QingyaoLin";
    aliases = { };
    extraConfig = {
      credential = {
        helper = "store";
      };
      core = {
        editor = "vim";
      };
    };
  };
}
