{ config, ... }:
{
  # Better voltage and temperature
  boot.extraModulePackages = with config.boot.kernelPackages; [ zenpower ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  # Use Systemd Boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
}