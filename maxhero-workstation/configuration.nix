{ ... }:
{
  networking = {
    hostId = "cc1f83cb";
    hostName = "maxhero-workstation";
  };
  services.minidlna.friendlyName = "maxhero-workstation";

  users.users = {
    maxhero = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "realtime"
        "libvirt"
        "kvm"
        "input"
        "networkmanager"
        "rtkit"
        "podman"
      ];
      shell = pkgs.bash;
    };
  };
}