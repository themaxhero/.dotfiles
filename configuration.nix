# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, nix-gaming, ... }:
let
  nowl = (pkgs.writeShellScriptBin "nowl" ''
    unset CLUTTER_BACKEND
    unset ECORE_EVAS_ENGINE
    unset ELM_ENGINE
    unset SDL_VIDEODRIVER
    unset BEMENU_BACKEND
    unset GTK_USE_PORTAL
    unset NIXOS_OZONE_WL
    export GDK_BACKEND='x11'
    export XDG_SESSION_TYPE='x11'
    export QT_QPA_PLATFORM='xcb'
    export MOZ_ENABLE_WAYLAND=0
    exec -a "$0" "$@"
  '');
in {
  imports = [ ./hardware-configuration.nix ];

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

  # OpenCL
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
  ];

  # VFIO-Passthrough: https://gist.github.com/CRTified/43b7ce84cd238673f7f24652c85980b3
  # Add Unstable: https://stackoverflow.com/questions/41230430/how-do-i-upgrade-my-system-to-nixos-unstable

  networking = {
    hostId = "7d0ccde8";
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
      ibus.engines = with pkgs.ibus-engines; [ anthy ];
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

  programs.waybar.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      libinput
      libinput-gestures
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
    fortune
    zsh
    bat

    ruby_3_1

    # Theming
    gnome.gnome-tweaks
    orchis-theme
    tela-circle-icon-theme

    # Gaming
    mangohud
    minecraft
    mesa-demos
    nix-gaming.packages.x86_64-linux.wine-tkg
    vulkan-tools
    winetricks

    # Emacs Dependencies
    cmigemo
    ansible
    # rtags
    ripgrep
    #nix-doom-emacs.doom-emacs
    nodePackages.stylelint
    nodePackages.js-beautify
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
