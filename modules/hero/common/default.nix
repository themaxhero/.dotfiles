{ pkgs, lib, nix-doom-emacs, ... }:
{
  options.username = lib.mkOption = {
    type = types.str;
    description = "Username";
  };
  config = {
    networking = {
      networkmanager.enable = true;
      useDHCP = false;
      firewall.enable = false;
    };
    services.avahi.enable = true;
    services.avahi.nssmdns = true;
    users.users.maxhero = {
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

    console = lib.mkDefault {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };

    environment.systemPackages = with pkgs; [
      btop
      cachix
      file
      fzf
      git
      i3status-rust
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
      helvum
      neofetch
      nix-index
      nmap
      traceroute
      zsh
      bat
      ntfs3g
    ];

    nix = lib.mkDefault {
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

    nixpkgs.config.allowUnfree = lib.mkDefault true;

    i18n = lib.mkDefault {
      defaultLocale = "en_GB.UTF-8";
      supportedLocales = [
        "en_GB.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
        "pt_BR.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
      ];
      extraLocaleSettings = {
        LC_TIME = "pt_BR.UTF-8";
        LC_MONETARY = "pt_BR.UTF-8";
        LC_NUMERIC = "pt_BR.UTF-8";
      };
    };

    security.rtkit.enable = lib.mkDefault true;
    security.sudo.wheelNeedsPassword = lib.mkDefault false;
    services.sshd.enable = lib.mkDefault true;

    # Localization and Keyboard layout
    time.timeZone = lib.mkDefault "America/Sao_Paulo";

    system.autoUpgrade.enable = true;
  };
}
