# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix

      # Nvidia and Intel drivers
      ./nvidia-intel-drivers.nix

      # Switch CapsLock and Esc
      ./keyboard.nix
    ];


  boot.loader = {
    grub.device = "nodev";
    grub.efiSupport = true;
    grub.font = "${pkgs.grub2}/share/grub/unicode.pf2";
    grub.theme = pkgs.nixos-grub2-theme;
    efi.efiSysMountPoint = "/boot/efi";
    efi.canTouchEfiVariables = true;
    grub.extraEntries =
    ''
      menuentry 'Windows Boot Manager (on /dev/sda1)' --class windows --class os $menuentry_id_option 'osprober-efi-CC5C-D868' {
         insmod part_gpt
	 insmod fat
	 set root='hd0,gpt1'
	 if [ x$feature_platform_search_hint = xy ]; then
             search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt1 --hint-efi=hd0,gpt1 --hint-baremetal=ahci0,gpt1  CC5C-D868
	 else
	     search --no-floppy --fs-uuid --set=root CC5C-D868
	 fi
	 chainloader /efi/Microsoft/Boot/bootmgfw.efi
       }
    '';
  };


  # Setting network.
  networking = {
    hostName = "NixOS";
    networkmanager.enable = true;
  };
  #programs.nm-applet.enable = true;


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
      (nerdfonts.override { fonts = [
        "FiraCode"
        "Hack"
        "JetBrainsMono"
      ]; })
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


  # Setting TTY
  console = {
    earlySetup = true;
    font = "ter-v32n";
    keyMap = "us";
    packages = with pkgs; [ terminus_font ];
  };
  services.getty.autologinUser = "lqy";


  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.startx.enable = true;
    logFile = "/tmp/Xorg.0.log";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Pulseaudio config
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };
  nixpkgs.config.pulseaudio = true;
  security.rtkit.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lqy = {
    description = "LQY's home";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    initialPassword = "lqy";
    packages = with pkgs; [
      microsoft-edge
    ];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    alacritty
    feh
    killall
    eww
    neofetch
    brightnessctl
    clash
    pavucontrol
    gnome.gucharmap
    tdesktop
    papirus-icon-theme
    (callPackage ../pkgs/polkit-gnome.nix {})
  ];
  programs.light.enable = true;


  # List services that you want to enable:

  # dbus config
  services.dbus.packages = [ pkgs.gcr ];

  # Polkit config
  security.polkit.enable = true;


  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  nixpkgs.config.allowUnfree = true;
}

