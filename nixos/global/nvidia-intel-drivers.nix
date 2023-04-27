# https://nixos.wiki/wiki/Intel_Graphics
# https://nixos.wiki/wiki/Accelerated_Video_Playback
# https://nixos.org/manual/nixos/stable/index.html#sec-gpu-accel
# https://nixos.org/manual/nixos/stable/index.html#sec-gpu-accel-vulkan
# https://nixos.wiki/wiki/Nvidia

{ lib, config, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  # === NVIDIA drive config ===

  # Custom system program starts NVIDIA drive
  environment.systemPackages = [ nvidia-offload ];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;


  # === Intel drive config ===

  # test config: `nix-shell -p libva-utils --run "vainfo"`
  # vaapiIntel overriden to Intel's Hybrid Driver.
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  # the proper installation of OpenCL drivers can be verified through the command of the clinfo package.
  # clinfo command: `nix-shell -p clinfo --run "clinfo"`,
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # OpenGL for 32-bit programs such as in Wine
  hardware.opengl = {
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiIntel
      libvdpau-va-gl
      vaapiVdpau
    ];
  };

  # Vulkan test: `nix-shell -p vulkan-tools --run "vulkaninfo | grep GPU"`
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };


  # === Mixed mode ===

  # `nix-shell -p pciutils --run "lspci"`
  hardware.nvidia.prime = {
    offload.enable = true;
    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";
    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";
  };
}
