{ lib, config, pkgs, ... }:

{
  xsession.numlock.enable = true;
  
  systemd.user.services.numlockx = {
    Install = lib.mkForce ({
      WantedBy = [ "bspwm-session.target" ];
    });
  };
}
