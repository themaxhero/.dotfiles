{ config, lib, pkgs, modulesPath, ... }:
{
  fileSystems."/" = {
    device = "/dev/mmcblk1p2";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/mmcblk1p1";
    fsType = "vfat";
  };
}
