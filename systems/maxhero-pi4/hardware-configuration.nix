{ config, lib, pkgs, modulesPath, ... }:
{
  fileSystems = lib.mkForce {
    "/" = {
      device = "/dev/mmcblk1p2";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/mmcblk1p1";
      fsType = "vfat";
    };
  };
}
