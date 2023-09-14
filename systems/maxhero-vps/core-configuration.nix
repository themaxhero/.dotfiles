# The top lambda and it super set of parameters.
{ config, lib, pkgs, nixpkgs, ... }:

# NixOS-defined options
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

  # Enable all the firmwares
  hardware.enableRedistributableFirmware = true;

  # I like /tmp on RAM.
  boot.tmpOnTmpfs = true;
  boot.tmpOnTmpfsSize = "100%";

  # Kernel versions (I prefer Liquorix).
  #boot.kernelPackages = pkgs.linuxPackages_lqx;

  # Disable the firewall.
  networking.firewall.enable = false;

  # "enp2s0" instead of "eth0".
  networking.usePredictableInterfaceNames = true;

  # Default time zone_.
  time.timeZone = "America/Sao_Paulo";

  # Internationalisation.
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [ "en_GB.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" "pt_BR.UTF-8/UTF-8" ];
    extraLocaleSettings = {
      LC_TIME = "pt_BR.UTF-8";
    };
  };
  console.font = "Lat2-Terminus16";

  # User accounts.
  users.users.maxhero = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" "users" "audio" "video" "input" "networkmanager" "rtkit" "podman" "minidlna" "kvm" "adbusers" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpqsk5zX3Q/YLhx/zADZvHYdXPC27YiR6Eaby3EGlVb"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGDbhh28/j9VKeJ7el5y5T+bMcfLtKxp7b9vEcTW+vyK"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMI03ted/wvFqDZ8w251SyY/gTDexN/6auIVphoiwqbs"
    ];
  };
  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  # List packages.
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    aria2
    btop
    busyboxWithoutAppletSymlinks
    file
    fzf
    git
    vim
    google-authenticator
    jq
    killall
    mosh
    neofetch
    nix-index
    nmap
    p7zip
    pciutils
    sshfs-fuse
    traceroute
    unrar
    unzip
    uutils-coreutils
    wget
    wireguard-tools
  ];

  # Special apps (requires more than their package to work).
  programs.command-not-found.enable = false;
  programs.dconf.enable = true;
  programs.fish = {
    enable = true;
    vendor = {
      config.enable = true;
      completions.enable = true;
    };
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true; # So I can use GPG through SSH
    pinentryFlavor = "tty";
  };
  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  # Override some packages' settings, sources, etc...
  nixpkgs.overlays =
    let
      thisConfigsOverlay = _: prev: {
        # Allow uutils to replace GNU coreutils.
        uutils-coreutils = prev.uutils-coreutils.override { prefix = ""; };

        # Busybox without applets
        busyboxWithoutAppletSymlinks = prev.busybox.override {
          enableAppletSymlinks = false;
        };
      };
    in
    [ thisConfigsOverlay ];

  # Enable services (automatically includes their apps' packages).
  services.ntp.enable = true;
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

  # Enable google-authenticator
  security.pam.services.sshd.googleAuthenticator.enable = true;

  # Disable nixos-containers (conflicts with virtualisation.containers)
  boot.enableContainers = false;

  # Virtualisation / Containerization.
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # Podman provides docker.
  };

  # We are anxiously waiting for PR 122547
  #services.dbus-broker.enable = true;

  # Global adjusts to home-manager
  #home-manager.useGlobalPkgs = true;

  # Set $NIX_PATH entry for nixpkgs.
  # This is for reusing flakes inputs for old commands.
  nix.nixPath = [ "nixpkgs=${nixpkgs}" ];

  # Always uses system's flakes instead of downloading or updating.
  nix.registry.nixpkgs.flake = nixpkgs;
}
