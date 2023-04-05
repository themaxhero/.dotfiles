{ nixpkgs, pkgs, ... }@attrs:
{
  # Nix package-management settings.
  nix = {
    # Enable flakes, newer CLI features, CA, and keep sources around for offline-building
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
      keep-outputs = true
      keep-derivations = true
    '';

    # Allow my user to use nix
    settings.trusted-users = [ "root" "maxhero" ];

    # Automatically removes NixOS' older builds.
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  networking = {
   hostName = "maxhero-pi4";
  };
  boot.enableContainers = false;
  boot.initrd.network.ssh.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/mnt/sda1" = {
    device = "/dev/sda1";
    fsType = "ntfs";
    options = [ "defaults" "user" "rw" "utf8" "noauto" "umask=000" ];
  };
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  sdImage.firmwareSize = 512;
  sdImage.compressImage = false;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  users.users.maxhero = {
    initialHashedPassword = "$y$j9T$a2Q7Dpby0aZttKPbAmCDw/$8M/A1hFjVLyaRWtDn0.qfNMb9puNRHNg92YQK57mRyD";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpqsk5zX3Q/YLhx/zADZvHYdXPC27YiR6Eaby3EGlVb"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGDbhh28/j9VKeJ7el5y5T+bMcfLtKxp7b9vEcTW+vyK"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMI03ted/wvFqDZ8w251SyY/gTDexN/6auIVphoiwqbs"
    ];
  };
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      GatewayPorts = "yes";
      PermitRootLogin = "no";
    };
    extraConfig = ''
      AllowTCPForwarding yes
    '';
  };
  nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
  nix.registry.nixpkgs.flake = nixpkgs;
  system.stateVersion = "23.05";
}
