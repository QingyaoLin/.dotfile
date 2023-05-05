# Set your network and hostname.

{ lib, config, pkgs, ... }:

{
  networking = {
    # Define your hostname.
    hostName = "NixOS";
    networkmanager.enable = true;
    # proxy = {
    #   noProxy = "127.0.0.1,localhost,.localdomain";
    #   httpProxy = "http://127.0.0.1:7890";
    #   httpsProxy = "http://127.0.0.1:7890";
    #   allProxy = "socks5://127.0.0.1:7890";
    # };
    firewall = {
      enable = false;
    #   allowedTCPPorts = [ 80 443 8080 ];
    #   allowedUDPPorts = [];
    };
  };
  programs.nm-applet.enable = true;
}
