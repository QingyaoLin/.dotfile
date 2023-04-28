{ config, lib, pkgs, ... }:

{
  services.auto-cpufreq.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
}
