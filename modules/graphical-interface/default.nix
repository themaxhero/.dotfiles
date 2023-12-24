{ self, config, pkgs, lib, home-manager, nur, nix-doom-emacs, ... }@attrs:
let
  nowl = (import (self + /tools/nowl.nix)) pkgs;
  cfg = config.graphical-interface;
  env = import (self + /env) attrs;
in
{
  options.graphical-interface = {
    enable = lib.mkEnableOption "Enable Development Module";
    environments = lib.mkOption {
      type = with lib.types; listOf (oneOf ["i3" "hyprland" "sway"]);
      description = "Enable envs Graphical Interface Modules";
      default = ["i3"];
    };
  };
  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = builtins.elem "hyprland" cfg.environments;
    };
    services.xserver.windowManager.i3 = {
      enable = builtins.elem "i3" cfg.environments;
      package = pkgs.i3-gaps;
    };
    systemd.targets."i3-session" = {
      enable = builtins.elem "i3" cfg.environments;
      description = "i3 session";
      bindsTo = [
        "graphical-session.target"
      ];
    };
    programs.sway = {
      enable = builtins.elem "sway" cfg.environments;
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
        ${builtins.concatStringsSep "\n" (builtins.map (v: "export ${v.name}='${v.value}'") env.sway_env)}
      '';
    };
    boot.plymouth = {
      enable = true;
    };
    environment.systemPackages = with pkgs; [
      alacritty
      kitty
      discord-canary
      ffmpegthumbnailer
      gnome.adwaita-icon-theme
      gnome.eog
      lxqt.pavucontrol-qt
      lxqt.pcmanfm-qt
      nowl
      pamixer
      qbittorrent
      slack
      spotify
      tdesktop
      #zoom-us
      wdisplays
      notion-app-enhanced
      gimp
      radeontop
      filezilla
      gparted
      gnome.gnome-tweaks
      orchis-theme
      libsForQt5.dolphin
      libsForQt5.dolphin-plugins
      tela-circle-icon-theme
      ddcutil
      whatsapp-for-linux
      pidgin-with-plugins
      rambox
      gnome.pomodoro
      #xarchiver
    ];

    nixpkgs.config.packageOverrides = pkgs: rec {
      pidgin-with-plugins = pkgs.pidgin.override {
        plugins = with pkgs; [
          pidgin-skypeweb
          pidgin-opensteamworks
          purple-slack
          purple-discord
          purple-googlechat
        ];
      };
    };

    fonts = {
      fonts = with pkgs; [
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
      fontconfig.allowBitmaps = true;
    };
    programs.dconf.enable = true;
    services.xserver.layout = "us";
    services.xserver.xkbVariant = "intl";
    services.xserver.enable = true;
  };
}
