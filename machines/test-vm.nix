{ self, nixpkgs, home-manager, nix-doom-emacs, ... }@attrs:
{
  /* 
  # this works, I just want to test something else
  imports = [
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    ../modules/common
    ../modules/graphical-interface
    ../modules/gaming
    ../modules/development
    #../systems/maxhero-vps/core-configuration.nix
    ../systems/maxhero-vps/configuration.nix
    #../servers/adguard.nix
    ../servers/postgres.nix
    ../servers/firefly.nix
    ../servers/journal-remote.nix
    #../servers/nginx.nix
    #../servers/wireguard.nix
    #../shared/oci-options.nix
    #../shared/oci-common.nix
    ../servers/minecraft-server-1.nix
  ];
  */
  boot.kernelParams = ["console=ttyS0,115200"];
  deployment.targetEnv = "libvirtd";
  deployment.libvirtd = {
    headless = true;
    memorySize = 2048;
    vcpu = 4;
    extraDevicesXML = ''
      <serial type='pty'>
        <target port='0'/>
      </serial>
      <console type='pty'>
        <target type='serial' port='0'/>
      </console>
    '';
  };
  nixpkgs.localSystem.system = "x86_64-linux";
}
