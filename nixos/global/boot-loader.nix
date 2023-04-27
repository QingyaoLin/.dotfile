# This setups a boot-loader.

{ lib, config, pkgs, ... }:

{
  # Use the Grub EFI boot loader.
  boot.loader = {
    grub.device = "nodev";
    grub.efiSupport = true;
    # grub.useOSProber = true;
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

}
