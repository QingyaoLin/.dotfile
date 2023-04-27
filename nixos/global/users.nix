# Configure your system-wide user settings (groups, etc), add more users as needed.

{ lib, config, pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  users.users = {
    lqy = {
      description = "LQY's home";
      initialPassword = "lqy";
      shell = pkgs.zsh;
      isNormalUser = true;
      # openssh.authorizedKeys.keys = [
      #   # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      # ];
      extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    };
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };
}
