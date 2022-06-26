# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" "cryptd" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.initrd.luks.devices.root = {
      device = "/dev/disk/by-uuid/2afb6cb6-fc98-4103-ab83-3fe6282db083";
      preLVM = true;
      allowDiscards = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4fe10a63-89d2-4b0e-ada7-b1af00cfe85f";
    fsType = "ext4";
  };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7068-CB8C";
      fsType = "vfat";
    };

  swapDevices = [ ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}