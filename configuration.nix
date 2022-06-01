# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, home-manager, nix-gaming, ... }:
let
  nowl = (import ./tools/nowl.nix) pkgs;
  emacs = (pkgs.emacsWithPackagesFromUsePackage {
    package = pkgs.emacsGit;
    extraEmacsPackages = epkgs:
      with epkgs; [
        vterm
        magit
        org
        tide
        neotree
        hl-todo
        doom-modeline
        popup
        vi-tilde-fringe
        parinfer-rust-mode
        multiple-cursors
        consult
        embark-consult
        dockerfile-mode
        docker-compose-mode
        ansible
        editorconfig
        gist
        alchemist
      ];
  });
in {
  # Ativa o Cereal Real
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nix.settings = {
    trusted-users = [ "root" "maxhero" ];
    auto-optimise-store = true;
    substituters =
      [ "https://nix-gaming.cachix.org" "https://nixpkgs.cachix.org" ];
    trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
    ];
  };

  # Use Systemd Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Better voltage and temperature
  boot.extraModulePackages = with config.boot.kernelPackages; [ zenpower ];

  # Services/Programs configurations
  services.minidlna.friendlyName = "maxhero-workstation";
  services.udisks2.enable = true;
  # OpenCL
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
  ];

  # VFIO-Passthrough: https://gist.github.com/CRTified/43b7ce84cd238673f7f24652c85980b3
  # Add Unstable: https://stackoverflow.com/questions/41230430/how-do-i-upgrade-my-system-to-nixos-unstable

  networking.hostId = "cc1f83cb";
  networking = {
    hostName = "maxhero-workstation";
    networkmanager = { enable = true; };
    useDHCP = false;
    firewall.enable = false;
  };

  # Localization and Keyboard layout

  time.timeZone = "America/Sao_Paulo";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ mozc ];
    };
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

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  hardware.bluetooth.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.blueman.enable = true;

  # services.xserver.desktopManager.xfce.enable = true;
  sound.mediaKeys.enable = true;
  programs.waybar.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      swaynotificationcenter
      wl-clipboard
      libinput
      libinput-gestures
      wofi
    ];
    extraSessionCommands = ''
      # Force wayland overall.
      export CLUTTER_BACKEND='wayland'
      export ECORE_EVAS_ENGINE='wayland_egl'
      export ELM_ENGINE='wayland_egl'
      export GDK_BACKEND='wayland'
      export MOZ_ENABLE_WAYLAND=1
      export QT_AUTO_SCREEN_SCALE_FACTOR=0
      export QT_QPA_PLATFORM='wayland-egl'
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export SAL_USE_VCLPLUGIN='gtk3'
      export SDL_VIDEODRIVER='wayland'
      export _JAVA_AWT_WM_NONREPARENTING=1
      export NIXOS_OZONE_WL=1

      # KDE/Plasma platform for Qt apps.
      export QT_QPA_PLATFORMTHEME='kde'
      export QT_PLATFORM_PLUGIN='kde'
      export QT_PLATFORMTHEME='kde'

      export GTK_IM_MODULE='ibus'
      export QT_IM_MODULE='ibus'
      export XMODIFIERS='@im=ibus'
      export GTK_IM_MODULE='/run/current-system/sw/lib/gtk-2.0/2.10.0/immodules/im-ibus.so'
    '';
  };

  xdg.portal = {
    wlr.enable = true;
    extraPortals = with pkgs;
      [
        #xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
  };

  services.xserver.layout = "us";

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    media-session.enable = false;
    systemWide = false;
    wireplumber.enable = true;
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  environment.variables = {
    AE_SINK = "ALSA";
    SDL_AUDIODRIVER = "pipewire";
    ALSOFT_DRIVERS = "alsa";
    GAMEMODERUNEXEC =
      "mangohud WINEFSYNC=1 PROTON_WINEDBG_DISABLE=1 DXVK_LOG_PATH=none DXVK_HUD=compiler ALSOFT_DRIVERS=alsa";
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      sha256 = "16q7w68i1qw6sl02w3an0lx8ks7p7vs721fs1186xc3hgvc3ma7v";
    }))
  ];

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

  systemd.enableUnifiedCgroupHierarchy = true;
  security.sudo.wheelNeedsPassword = false;
  services.flatpak.enable = true;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    acpi
    alacritty
    kitty
    android-tools
    aria2
    avizo
    btop
    cachix
    discord
    ffmpegthumbnailer
    file
    firefox-wayland
    fzf
    git
    ungoogled-chromium
    grim
    i3status-rust
    gnome3.adwaita-icon-theme
    gnome.eog
    killall
    lm_sensors
    lxqt.pavucontrol-qt
    lxqt.pcmanfm-qt
    mpv
    nowl
    p7zip
    pamixer
    pciutils
    qbittorrent
    slack
    slurp
    spotify
    mako
    tdesktop
    tmux
    unrar
    unzip
    usbutils
    wget
    wpsoffice
    xarchiver
    xdg_utils
    zoom-us

    # Development
    vscodium
    dbeaver
    vim
    elmPackages.elm-format
    gnumake
    libtool
    libvterm
    nixpkgs-fmt
    shellcheck
    shfmt
    elixir_1_13
    yarn
    nushell

    # Other
    adbfs-rootless
    notion-app-enhanced
    gimp
    archiver
    dotnet-sdk
    xarchiver
    waybar
    helvum
    neofetch
    nix-index
    nmap
    traceroute
    radeontop
    lolcat
    cowsay
    filezilla
    fortune
    zsh
    bat

    ruby_3_1

    # Theming
    gnome.gnome-tweaks
    orchis-theme

    # Gaming
    mangohud
    minecraft
    mesa-demos
    #nix-gaming.packages.x86_64-linux.wine-tkg
    vulkan-tools
    winetricks

    ntfs3g

    # Emacs Dependencies
    cmigemo
    ansible
    # rtags
    ripgrep
    #nix-doom-emacs.doom-emacs
    nodePackages.stylelint
    nodePackages.js-beautify
    emacs28Packages.vterm
    mu
    zig
    python39Packages.nose
    cargo
    rustc
    rustfmt
    rust-analyzer
    rust-code-analysis
    rustracer
    ocamlPackages.utop
    python3Full
    black
    icr
    fsharp
    haskellPackages.Cabal_3_6_3_0
    haskellPackages.brittany
    haskellPackages.hlint
    haskellPackages.hoogle
    haskellPackages.nixfmt
    clj-kondo
    terraform
    metals

    racket
    markdown-anki-decks

    podman-compose

    cmake
    gcc

    # GI
    jq
    fd
    xdelta
    gparted

    # XFCE
    # xfce.xfce4-whiskermenu-plugin
    libsForQt5.dolphin
    libsForQt5.dolphin-plugins
    tela-circle-icon-theme
    # xfce.xfce4-power-manager
  ];

  programs.dconf.enable = true;
  programs.fish.enable = true;
  programs.gamemode.enable = true;
  programs.steam.enable = true;
  programs.nm-applet.enable = true;

  # Doom Emacs
  #programs.doom-emacs.enable = true;
  #programs.doom-emacs.doomPrivateDir = "/home/maxhero/.doom.d";

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  environment.variables.EDITOR = "vim";
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [ gamemode mangohud ];
    };
  };

  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.fwupd.enable = true;
  services.emacs.enable = true;
  services.ntp.enable = true;
  services.sshd.enable = true;
  services.tumbler.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.minidlna = {
    enable = true;
    mediaDirs = [ "/home/upnp-shared/Media" ];
  };
  systemd.services."user@".serviceConfig = { Delegate = "yes"; };
  services.postgresql.enable = true;
  services.postgresql.authentication = lib.mkForce ''
    # Generated file; do not edit!
    local all all              trust
    host  all all 127.0.0.1/32 trust
    host  all all ::1/128      trust
  '';

  fonts.fontconfig.allowBitmaps = true;
  fonts.fonts = with pkgs; [
    cantarell-fonts
    font-awesome_4
    font-awesome_5
    freefont_ttf
    google-fonts
    liberation_ttf
    noto-fonts
    ubuntu_font_family
    scientifica
    curie
  ];

  virtualisation.oci-containers.backend = "podman";
  virtualisation = {
    podman = {
      enable = true;
      dockerSocket = { enable = true; };
      dockerCompat = true;
    };
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.autoUpgrade.enable = true;

  system.stateVersion = "21.11";
}
