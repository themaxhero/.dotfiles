{ pkgs, ...}:
{
  users.users.maxhero = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "adbusers"
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

  services.ntp.enable = true;

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.systemPackages = with pkgs; [
    btop
    cachix
    file
    fzf
    git
    killall
    lm_sensors
    p7zip
    pciutils
    tmux
    unrar
    unzip
    usbutils
    wget
    xdg-utils
    archiver
    neofetch
    nix-index
    nmap
    traceroute
    zsh
    bat
    ntfs3g
  ];

  nix = {
    # Ativa o Cereal Real
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      trusted-users = [ "root" "maxhero" ];
      auto-optimise-store = true;
      substituters = [
        "https://nix-gaming.cachix.org"
        "https://nixpkgs.cachix.org"
      ];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  i18n = {
    defaultLocale = "ja_JP.UTF-8";
    supportedLocales = [
      "ja_JP.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "pt_BR.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ALL = "ja_JP.UTF-8";
      LANGUAGE = "ja_JP.UTF-8";
      LC_TIME = "ja_JP.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
    };
  };

  programs.fish.enable = true;
  security.rtkit.enable = true;
  security.sudo.wheelNeedsPassword = false;
  services.sshd.enable = true;
  powerManagement.enable = false;

  # Localization and Keyboard layout
  time.timeZone = "America/Sao_Paulo";

  system.autoUpgrade.enable = true;
}
