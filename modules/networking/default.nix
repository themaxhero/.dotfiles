{ ... }:
{
  networking = {
    networkmanager = { enable = true; };
    useDHCP = false;
    firewall.enable = false;
  };
}
