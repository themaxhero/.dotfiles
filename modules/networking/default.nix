{ ... }:
{
  networking = {
    networkmanager = { enable = true; };
    useDHCP = false;
    firewall.enable = false;
  };
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
}
