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
  hardware.raspberry-pi."4".fkms-3d.enable = true;
  networking.hostName = "maxhero-pi4";
  sdImage.compressImage = false;
  boot.kernelPackages = pkgs.linuxPackages_rpi4;
  boot.enableContainers = false;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  users.users.maxhero.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpqsk5zX3Q/YLhx/zADZvHYdXPC27YiR6Eaby3EGlVb"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGDbhh28/j9VKeJ7el5y5T+bMcfLtKxp7b9vEcTW+vyK"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMI03ted/wvFqDZ8w251SyY/gTDexN/6auIVphoiwqbs"
  ];
  services.openssh = {
    # TODO: Use openssh_hpn
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
