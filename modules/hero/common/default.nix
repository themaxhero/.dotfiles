{ config, pkgs, lib, home-manager, nur, nix-doom-emacs, ... }:
let
  username = config.username;
in
{
  options.username = lib.mkOption = {
    type = types.str;
    description = "Username";
  };
  config = {
    networking = {
      networkmanager = { enable = true; };
      useDHCP = false;
      firewall.enable = false;
    };
    services.avahi.enable = true;
    services.avahi.nssmdns = true;
    users.users."${username}" = {...}: {
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
        trusted-users = [ "root" username ];
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

    # User level Stuff
    home-manager.users."${username}" = lib.mkDefault {
      home.username = username;
      home.homeDirectory = "/home/${username}";
      home.language = {
        base = "en_GB.UTF-8";
        time = "pt_BR.UTF-8";
        monetary = "pt_BR.UTF-8";
        numeric = "pt_BR.UTF-8";
      };
      home.file = {
        ".zshrc".text = (import ./zshrc.nix) {
          inherit pkgs;
          theme = "lambda";
        };
      };
      programs.aria2.enable = true;
      programs.bat.enable = true;
      programs.fish.enable = true;
      programs.command-not-found.enable = true;
      programs.gpg.enable = true;
      services.gpg-agent = {
        enable = true;
        pinentryFlavor = "qt";
      };
      programs.home-manager.enable = true;
      programs.jq.enable = true;
      programs.lsd = {
        enable = true;
        enableAliases = true;
      };
      programs.man = {
        enable = true;
        generateCaches = true;
      };
      programs.mu.enable = true;
      programs.tealdeer.enable = true;
      programs.tmux.enable = true;
      programs.zsh.oh-my-zsh.enable = true;
      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        desktop = "$HOME/Desktop";
        documents = "$HOME/Documents";
        download = "$HOME/Downloads";
        pictures = "$HOME/Pictures";
        publicShare = "$HOME/Public";
        templates = "$HOME/Templates";
        videos = "$HOME/Videos";
        music = "$HOME/Music";
      };

      programs.alacritty = {
        enable = config.graphical-interface.enable;
        package = pkgs.alacritty;
        settings = {
          window.opacity = 0.8;
          font = {
            size = 16;
            normal.family = "scientifica";
            bold.family = "scientifica";
            italic.family = "scientifica";
            bold_italic = {
              family = "scientifica";
              size = 9.0;
            };
          };
          shell.program = "${pkgs.zsh}/bin/zsh";
        };
      };

      programs.ssh = {
        enable = true;
        matchBlocks = {
          "github.com" = {
            hostname = "github.com";
            user = "themaxhero";
            identityFile = "~/.ssh/id_ed25519";
          };
        };
      };
    };

    system.autoUpgrade.enable = true;
  };
}
