{ ... }:
{
  # VFIO-Passthrough: https://gist.github.com/CRTified/43b7ce84cd238673f7f24652c85980b3
  # Add Unstable: https://stackoverflow.com/questions/41230430/how-do-i-upgrade-my-system-to-nixos-unstable
  services.udev.extraRules = ''
    # Supporting VFIO
    SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"
  '';
}
