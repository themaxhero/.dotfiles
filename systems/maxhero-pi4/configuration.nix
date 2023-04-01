{...}@attrs:
{
  hardware.raspberry-pi."4".fkms-3d.enable = true;
  networking = {
    hostName = "maxhero-pi4";
    wireless.enable = true;
  };
}
