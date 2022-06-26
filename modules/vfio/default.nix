{...}:
{
  services.udev.extraRules = ''
  # Supporting VFIO
  SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"
  ''
}